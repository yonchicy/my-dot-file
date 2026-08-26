local M = {}

local function valid_windows_for(buf)
  local windows = vim.fn.win_findbuf(buf)
  return vim.tbl_filter(vim.api.nvim_win_is_valid, windows)
end

function M.focus_existing(session)
  if not session.buf or not vim.api.nvim_buf_is_valid(session.buf) then
    return false
  end

  local windows = valid_windows_for(session.buf)
  if #windows == 0 then
    return false
  end

  vim.api.nvim_set_current_win(windows[1])
  return true
end

local function open_split(session, height)
  local clamped_height = math.max(6, math.min(height, math.floor(vim.o.lines * 0.7)))
  vim.cmd("botright " .. clamped_height .. "split")
  vim.api.nvim_win_set_buf(0, session.buf)
end

local function open_float(session, float_config)
  local width = math.max(40, math.floor(vim.o.columns * float_config.width))
  local height = math.max(8, math.floor(vim.o.lines * float_config.height))
  width = math.min(width, vim.o.columns - 4)
  height = math.min(height, vim.o.lines - 4)

  vim.api.nvim_open_win(session.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = float_config.border,
    title = " " .. session.name .. " ",
    title_pos = "center",
  })
end

local function open_tab(session)
  vim.cmd("tabnew")
  vim.api.nvim_win_set_buf(0, session.buf)
end

function M.open(session, layout, config)
  if not session.buf or not vim.api.nvim_buf_is_valid(session.buf) then
    vim.notify("Terminal buffer is no longer available", vim.log.levels.WARN)
    return false
  end

  -- A PTY has one terminal size. Keep a session in one visible window at a
  -- time; opening an existing session focuses it instead of creating a second
  -- competing view.
  if M.focus_existing(session) then
    return true
  end

  if layout == "float" then
    open_float(session, config.float)
  elseif layout == "tab" then
    open_tab(session)
  else
    open_split(session, config.split_height)
  end

  return true
end

function M.hide_current(session)
  if not session.buf or vim.api.nvim_get_current_buf() ~= session.buf then
    return false
  end

  local window_config = vim.api.nvim_win_get_config(0)
  local tab_windows = vim.api.nvim_tabpage_list_wins(0)
  if window_config.relative ~= "" or #tab_windows > 1 then
    vim.api.nvim_win_close(0, false)
  elseif #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd("tabclose")
  else
    vim.cmd("enew")
  end
  return true
end

return M
