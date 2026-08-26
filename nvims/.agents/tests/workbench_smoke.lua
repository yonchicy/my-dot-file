-- Run with the installed configuration, for example:
-- TEST_STATE="$(mktemp -d)" XDG_STATE_HOME="$TEST_STATE" \
--   nvim --headless \
--   '+luafile /Users/bytedance/.config/nvim/.agents/tests/workbench_smoke.lua' \
--   '+qa!'
--
-- This intentionally uses only local /bin/sh commands. It never starts Codex,
-- accesses a network, writes project files, or sends input to a real agent.

local workbench = require("workbench")

local function wait_for(timeout, predicate, message)
  assert(vim.wait(timeout, predicate, 20), message)
end

assert(pcall(require, "mini.pick"), "mini.pick was not loaded")
assert(pcall(require, "mini.tabline"), "mini.tabline was not loaded")
assert(vim.fn.exists(":AgentTermNew") == 2, "AgentTermNew command is missing")
assert(not vim.tbl_contains(vim.opt.sessionoptions:get(), "terminal"), "session restore can restart terminal jobs")

local done = assert(workbench.create({
  name = "smoke-done",
  argv = { "/bin/sh", "-c", "printf 'done\\n'; exit 0" },
  layout = "split",
}))
wait_for(2000, function()
  return done.exit_code ~= nil
end, "successful terminal did not exit")
assert(workbench.status(done) == "done", "successful terminal did not report done")

local active = assert(workbench.create({
  name = "smoke-active",
  argv = { "/bin/sh", "-c", "sleep 0.2; printf 'background\\n'; sleep 3" },
  layout = "split",
}))
vim.cmd("AgentTermHide")
assert(vim.api.nvim_buf_is_valid(active.buf), "hiding a terminal wiped its buffer")
wait_for(1200, function()
  return active.unread > 0
end, "background output did not become unread")
assert(workbench.status(active) == "running", "active terminal did not remain running")

assert(workbench.open(active, "split"), "could not reopen hidden terminal")
assert(active.unread == 0, "opening a terminal did not clear unread output")
assert(workbench.stop(active), "could not stop active terminal")
wait_for(2000, function()
  return active.exit_code ~= nil
end, "stopped terminal did not exit")
assert(workbench.status(active) == "stopped", "stopped terminal reported wrong status")

local attention = assert(workbench.create({
  name = "smoke-attention",
  argv = { "/bin/sh", "-c", "printf 'needs confirmation [Y/n]\\n'; sleep 3" },
  profile = "codex",
  layout = "split",
}))
vim.cmd("AgentTermHide")
wait_for(1200, function()
  return attention.attention
end, "profile matcher did not mark attention")
assert(workbench.status(attention) == "attention", "attention status was not shown")
assert(workbench.open(attention, "split"), "could not reopen attention terminal")
assert(not attention.attention, "focusing a terminal did not acknowledge attention")
assert(workbench.stop(attention), "could not stop attention terminal")
wait_for(2000, function()
  return attention.exit_code ~= nil
end, "attention terminal did not exit")

assert(workbench.format_tab(active.buf, "fallback"):find("smoke%-active"), "terminal tab formatting lost its name")
assert(pcall(function()
  require("mini.tabline").config.format(active.buf, "fallback")
end), "mini.tabline formatter failed")

vim.cmd("AgentTermNew smoke-command printf command-test")
local command_test = assert(workbench.find_by_name("smoke-command"), "AgentTermNew did not create a named session")
wait_for(2000, function()
  return command_test.exit_code ~= nil
end, "command-created terminal did not exit")
assert(workbench.status(command_test) == "done", "AgentTermNew shell command did not succeed")

workbench.rename(command_test, "smoke-command")
assert(command_test.name == "smoke-command", "renaming to the same name changed the session name")

print("WORKBENCH_SMOKE_OK")
