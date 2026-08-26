local config_module = require("workbench.config")
local ui = require("workbench.ui")

local M = {}

local state = {
  config = nil,
  sessions = {},
  name_to_id = {},
  by_buf = {},
  next_id = 1,
  last_id = nil,
  redraw_scheduled = false,
}

local state_badges = {
  starting = "…",
  running = "●",
  attention = "!",
  stopping = "…",
  stopped = "■",
  done = "✓",
  failed = "×",
  orphaned = "?",
}

local function trim(value)
  return (value or ""):gsub("^%s*(.-)%s*$", "%1")
end

local function session_for_buffer(buf)
  if buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end
  local id = state.by_buf[buf]
  return id and state.sessions[id] or nil
end

local function is_interactive(session)
  return session.process == "starting" or session.process == "running" or session.process == "stopping"
end

local function schedule_redraw()
  if state.redraw_scheduled then
    return
  end

  state.redraw_scheduled = true
  vim.schedule(function()
    state.redraw_scheduled = false
    vim.cmd("redrawtabline")
  end)
end

local function notify(message, level)
  if not state.config.notifications.enabled then
    return
  end

  vim.schedule(function()
    vim.notify("[Terminal] " .. message, level)
  end)
end

local function make_unique_name(name)
  local base = trim(name)
  if base == "" then
    base = "terminal"
  end

  local candidate = base
  local suffix = 2
  while state.name_to_id[candidate] do
    candidate = base .. "-" .. suffix
    suffix = suffix + 1
  end
  return candidate
end

local function is_current_session(session)
  return session.buf and vim.api.nvim_buf_is_valid(session.buf) and vim.api.nvim_get_current_buf() == session.buf
end

local function add_unread(session)
  if not is_current_session(session) then
    session.unread = math.min((session.unread or 0) + 1, 99)
    schedule_redraw()
  end
end

local function clean_terminal_line(line)
  -- PTY output can contain ANSI control data. Strip the common CSI form before
  -- comparing against an explicit profile matcher.
  return line:gsub("\27%[[%d;?]*[%a]", ""):gsub("\r", "")
end

local function attention_match(session, line)
  local haystack = clean_terminal_line(line):lower()
  for _, pattern in ipairs(session.attention_patterns) do
    if haystack:find(pattern:lower(), 1, true) then
      return pattern
    end
  end
  return nil
end

local function set_process(session, process)
  if session.process == process then
    return false
  end
  session.process = process
  session.last_state_change = os.time()
  schedule_redraw()
  return true
end

local function process_line(session, line)
  if line == "" then
    return false
  end

  session.last_output = clean_terminal_line(line)
  session.last_activity = os.time()

  if is_interactive(session) and not session.attention then
    local pattern = attention_match(session, line)
    if pattern then
      session.attention = true
      session.attention_reason = session.last_output
      schedule_redraw()
      if state.config.notifications.on_attention and not is_current_session(session) then
        notify(session.name .. " needs attention (matched: " .. pattern .. ")", vim.log.levels.WARN)
      end
    end
  end

  return true
end

local function on_stdout(id, job_id, data)
  local session = state.sessions[id]
  if not session or (session.job and session.job ~= job_id) or type(data) ~= "table" then
    return
  end

  -- Job callbacks are line-oriented, but their first and last entry may be a
  -- partial line. Keep the per-session tail before matching any text.
  local saw_output = false
  for index, chunk in ipairs(data) do
    if index == 1 then
      session.output_tail = (session.output_tail or "") .. chunk
    else
      saw_output = process_line(session, session.output_tail) or saw_output
      session.output_tail = chunk
    end
  end

  if saw_output then
    add_unread(session)
  end
end

local function on_exit(id, job_id, exit_code)
  local session = state.sessions[id]
  if not session or (session.job and session.job ~= job_id) or session.exit_code ~= nil then
    return
  end

  if session.output_tail and session.output_tail ~= "" then
    process_line(session, session.output_tail)
    session.output_tail = ""
  end

  session.exit_code = exit_code
  set_process(session, "exited")

  if not is_current_session(session) then
    add_unread(session)
  end

  if state.config.notifications.on_exit and not is_current_session(session) then
    local status = M.status(session)
    if status == "done" then
      notify(session.name .. " completed", vim.log.levels.INFO)
    elseif status == "stopped" then
      notify(session.name .. " stopped", vim.log.levels.INFO)
    else
      notify(session.name .. " exited with code " .. tostring(exit_code), vim.log.levels.ERROR)
    end
  end
end

local function session_items()
  local items = {}
  for _, session in pairs(state.sessions) do
    table.insert(items, session)
  end
  table.sort(items, function(a, b)
    return a.id < b.id
  end)
  return items
end

local function complete_session_names(arglead)
  local names = {}
  for name in pairs(state.name_to_id) do
    if name:sub(1, #arglead) == arglead then
      table.insert(names, name)
    end
  end
  table.sort(names)
  return names
end

local function parse_name_and_command(args)
  local name, command = args:match("^%s*(%S+)%s+(.+)$")
  return trim(name or args), command
end

local function shell_argv(command)
  local argv = { vim.o.shell }
  vim.list_extend(argv, vim.split(vim.o.shellcmdflag, "%s+", { trimempty = true }))
  table.insert(argv, command)
  return argv
end

function M.setup(user_config)
  state.config = config_module.make(user_config)

  local group = vim.api.nvim_create_augroup("WorkbenchTerminal", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter" }, {
    group = group,
    callback = function(args)
      M.focus_buffer(args.buf)
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(args)
      local session = session_for_buffer(args.buf)
      if not session then
        return
      end
      state.by_buf[args.buf] = nil
      session.buf = nil
      if is_interactive(session) then
        set_process(session, "orphaned")
      end
    end,
  })

  vim.api.nvim_create_user_command("AgentTermNew", function(command)
    if trim(command.args) == "" then
      M.new_interactive({ layout = command.bang and "float" or nil })
      return
    end
    local name, shell_command = parse_name_and_command(command.args)
    M.create({
      name = name,
      command = shell_command,
      layout = command.bang and "float" or nil,
    })
  end, { nargs = "*", bang = true, desc = "Create a named terminal: name [command]" })

  vim.api.nvim_create_user_command("AgentTermCodex", function(command)
    M.create_codex(trim(command.args), command.bang and "float" or nil)
  end, { nargs = "?", bang = true, desc = "Create a Codex terminal" })

  vim.api.nvim_create_user_command("AgentTermList", function()
    M.select_session()
  end, { desc = "Select a terminal session" })

  vim.api.nvim_create_user_command("AgentTermToggle", function()
    M.toggle_last()
  end, { desc = "Toggle the last terminal session" })

  vim.api.nvim_create_user_command("AgentTermHide", function()
    local session = session_for_buffer(0)
    if not session or not ui.hide_current(session) then
      vim.notify("Current buffer is not a visible workbench terminal", vim.log.levels.WARN)
    end
  end, { desc = "Hide the current terminal without stopping it" })

  vim.api.nvim_create_user_command("AgentTermOpen", function(command)
    local name, layout = command.fargs[1], command.fargs[2]
    local session = name and M.find_by_name(name) or session_for_buffer(0)
    if session then
      M.open(session, layout)
    else
      M.select_session(function(selected)
        M.open(selected, layout)
      end)
    end
  end, {
    nargs = "*",
    complete = complete_session_names,
    desc = "Open a terminal session: [name] [split|float|tab]",
  })

  vim.api.nvim_create_user_command("AgentTermStop", function(command)
    local session = trim(command.args) ~= "" and M.find_by_name(trim(command.args)) or session_for_buffer(0)
    if session then
      M.stop(session)
    else
      M.stop_current_or_select()
    end
  end, { nargs = "?", complete = complete_session_names, desc = "Stop a terminal session" })

  vim.api.nvim_create_user_command("AgentTermRename", function(command)
    local session = session_for_buffer(0)
    if not session then
      vim.notify("Open a workbench terminal before renaming it", vim.log.levels.WARN)
      return
    end
    if trim(command.args) == "" then
      vim.ui.input({ prompt = "New terminal name: ", default = session.name }, function(value)
        if value and trim(value) ~= "" then
          M.rename(session, value)
        end
      end)
      return
    end
    M.rename(session, command.args)
  end, { nargs = "?", desc = "Rename the current terminal session" })

  vim.api.nvim_create_user_command("AgentTermSend", function(command)
    local name, text = command.args:match("^%s*(%S+)%s+(.+)$")
    local session = name and M.find_by_name(name) or nil
    if not session or not text then
      vim.notify("Usage: :AgentTermSend <name> <text>", vim.log.levels.WARN)
      return
    end
    M.send_line(session, text)
  end, { nargs = "+", complete = complete_session_names, desc = "Send a line to a terminal session" })
end

function M.create(opts)
  opts = opts or {}
  local command = opts.command and trim(opts.command) or nil
  local argv = opts.argv or (command and shell_argv(command) or { vim.o.shell })
  local name = make_unique_name(opts.name or "terminal")
  local profile = opts.profile
  local attention_patterns = {}
  if profile and state.config.profiles[profile] then
    vim.list_extend(attention_patterns, state.config.profiles[profile].attention_patterns or {})
  end
  vim.list_extend(attention_patterns, opts.attention_patterns or {})

  local id = state.next_id
  state.next_id = state.next_id + 1

  local buffer = vim.api.nvim_create_buf(true, false)
  vim.bo[buffer].bufhidden = "hide"
  vim.bo[buffer].buflisted = true
  vim.bo[buffer].swapfile = false

  local session = {
    id = id,
    name = name,
    command = command or vim.o.shell,
    argv = vim.deepcopy(argv),
    cwd = opts.cwd or vim.fn.getcwd(),
    profile = profile,
    buf = buffer,
    job = nil,
    process = "starting",
    attention = false,
    unread = 0,
    output_tail = "",
    attention_patterns = attention_patterns,
    created_at = os.time(),
  }
  state.sessions[id] = session
  state.name_to_id[name] = id
  state.by_buf[buffer] = id
  state.last_id = id
  vim.b[buffer].workbench_terminal_id = id

  local layout = opts.layout or state.config.default_layout
  if not ui.open(session, layout, state.config) then
    return nil
  end

  local job = vim.api.nvim_buf_call(buffer, function()
    return vim.fn.jobstart(argv, {
      term = true,
      cwd = session.cwd,
      on_stdout = function(job_id, data)
        on_stdout(id, job_id, data)
      end,
      on_exit = function(job_id, code)
        on_exit(id, job_id, code)
      end,
    })
  end)

  if job <= 0 then
    session.exit_code = -1
    set_process(session, "exited")
    notify("Could not start " .. name, vim.log.levels.ERROR)
    return session
  end

  session.job = job
  if session.exit_code == nil then
    set_process(session, "running")
  end
  if state.config.notifications.on_start then
    notify(name .. " started", vim.log.levels.INFO)
  end

  vim.schedule(function()
    if is_current_session(session) and is_interactive(session) then
      vim.cmd("startinsert")
    end
  end)
  return session
end

function M.create_codex(name, layout)
  local profile = state.config.profiles.codex
  local command = profile.command
  local argv = profile.argv
  if not argv and not command:find("%s") then
    argv = { command }
  end

  if argv and vim.fn.executable(argv[1]) == 0 then
    vim.notify("`" .. argv[1] .. "` is not on PATH; the terminal may exit immediately", vim.log.levels.WARN)
  end

  return M.create({
    name = name ~= "" and name or "codex",
    command = command,
    argv = argv,
    profile = "codex",
    layout = layout,
  })
end

function M.new_interactive(opts)
  opts = opts or {}
  vim.ui.input({ prompt = "Terminal name: ", default = "terminal" }, function(name)
    if not name or trim(name) == "" then
      return
    end
    vim.ui.input({ prompt = "Command (blank for shell): " }, function(command)
      if command == nil then
        return
      end
      M.create({ name = name, command = trim(command) ~= "" and command or nil, layout = opts.layout })
    end)
  end)
end

function M.new_codex_interactive()
  vim.ui.input({ prompt = "Codex session name: ", default = "codex" }, function(name)
    if name and trim(name) ~= "" then
      M.create_codex(name)
    end
  end)
end

function M.open(session, layout)
  if not session then
    return false
  end
  local opened = ui.open(session, layout or state.config.default_layout, state.config)
  if opened then
    M.focus_buffer(session.buf)
    vim.schedule(function()
      if is_current_session(session) and is_interactive(session) then
        vim.cmd("startinsert")
      end
    end)
  end
  return opened
end

function M.focus_buffer(buffer)
  local session = session_for_buffer(buffer)
  if not session then
    return
  end
  session.unread = 0
  session.attention = false
  session.attention_reason = nil
  schedule_redraw()
end

function M.find_by_name(name)
  local id = state.name_to_id[name]
  return id and state.sessions[id] or nil
end

function M.current_session()
  return session_for_buffer(0)
end

function M.toggle_last()
  local session = state.last_id and state.sessions[state.last_id] or nil
  if not session then
    vim.notify("No terminal sessions yet", vim.log.levels.INFO)
    return
  end

  if is_current_session(session) then
    ui.hide_current(session)
    return
  end

  if not ui.focus_existing(session) then
    M.open(session, state.config.default_layout)
  end
end

function M.open_current_or_select(layout)
  local session = M.current_session()
  if session then
    M.open(session, layout)
    return
  end
  M.select_session(function(selected)
    M.open(selected, layout)
  end)
end

function M.stop(session)
  if not session or not is_interactive(session) or not session.job then
    vim.notify("That terminal is not running", vim.log.levels.WARN)
    return false
  end

  session.stop_requested = true
  set_process(session, "stopping")
  local stopped = vim.fn.jobstop(session.job)
  if stopped == 0 then
    session.stop_requested = false
    if session.exit_code == nil then
      set_process(session, "running")
    end
    vim.notify("Could not stop " .. session.name, vim.log.levels.WARN)
    return false
  end
  return true
end

function M.stop_current_or_select()
  local session = M.current_session()
  if session then
    M.stop(session)
    return
  end
  M.select_session(function(selected)
    M.stop(selected)
  end)
end

function M.rename(session, new_name)
  if not session then
    return
  end
  if trim(new_name) == session.name then
    return
  end
  state.name_to_id[session.name] = nil
  local name = make_unique_name(new_name)
  session.name = name
  state.name_to_id[name] = session.id
  schedule_redraw()
end

function M.send_line(session, text)
  if not session or not is_interactive(session) or not session.job then
    vim.notify("That terminal is not running", vim.log.levels.WARN)
    return false
  end
  vim.fn.chansend(session.job, text .. "\r")
  return true
end

function M.status(session)
  if session.process == "orphaned" then
    return "orphaned"
  end
  if session.process == "exited" then
    if session.stop_requested then
      return "stopped"
    end
    return session.exit_code == 0 and "done" or "failed"
  end
  if session.process == "stopping" then
    return "stopping"
  end
  if session.attention then
    return "attention"
  end
  return session.process
end

function M.select_session(callback)
  local sessions = session_items()
  if #sessions == 0 then
    vim.notify("No terminal sessions yet", vim.log.levels.INFO)
    return
  end

  local choose = callback or function(session)
    M.open(session, state.config.default_layout)
  end

  local items = vim.tbl_map(function(session)
    return {
      text = M.session_label(session) .. "  " .. session.cwd,
      session_id = session.id,
    }
  end, sessions)

  local ok, mini_pick = pcall(require, "mini.pick")
  if ok then
    mini_pick.start({
      source = {
        name = "Terminal sessions",
        items = items,
        choose = function(item)
          local selected = item and state.sessions[item.session_id]
          if not selected then
            return
          end
          local picker_state = mini_pick.get_picker_state()
          local target = picker_state and picker_state.windows and picker_state.windows.target
          if target and vim.api.nvim_win_is_valid(target) then
            vim.api.nvim_win_call(target, function()
              choose(selected)
            end)
          else
            choose(selected)
          end
        end,
      },
    })
    return
  end

  vim.ui.select(sessions, {
    prompt = "Terminal session",
    format_item = M.session_label,
  }, choose)
end

function M.session_label(session)
  local status = M.status(session)
  local badge = state_badges[status] or "?"
  local unread = session.unread and session.unread > 0 and " +" .. session.unread or ""
  return session.name .. " " .. badge .. unread
end

function M.format_tab(buffer, label)
  local session = session_for_buffer(buffer)
  if not session then
    return label
  end
  return " " .. M.session_label(session) .. " "
end

function M.list()
  return session_items()
end

return M
