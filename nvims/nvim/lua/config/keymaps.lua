local map = vim.keymap.set

local function pick(method)
  return function()
    local ok, mini_pick = pcall(require, "mini.pick")
    if not ok then
      vim.notify("mini.pick is not available", vim.log.levels.WARN)
      return
    end
    mini_pick.builtin[method]()
  end
end

-- Search
map("n", "<leader>ff", pick("files"), { desc = "Find files" })
map("n", "<leader>fg", pick("grep_live"), { desc = "Find text" })
map("n", "<leader>fb", pick("buffers"), { desc = "Find buffers" })

-- Terminal workbench
map("n", "<leader>tn", function()
  require("workbench").new_interactive()
end, { desc = "New terminal" })
map("n", "<leader>tc", function()
  require("workbench").new_codex_interactive()
end, { desc = "New Codex terminal" })
map("n", "<leader>tl", function()
  require("workbench").select_session()
end, { desc = "List terminal sessions" })
map("n", "<leader>tt", function()
  require("workbench").toggle_last()
end, { desc = "Toggle last terminal" })
map("n", "<leader>th", function()
  vim.cmd("AgentTermHide")
end, { desc = "Hide terminal" })
map("n", "<leader>ts", function()
  require("workbench").open_current_or_select("split")
end, { desc = "Open terminal in split" })
map("n", "<leader>tf", function()
  require("workbench").open_current_or_select("float")
end, { desc = "Open terminal in float" })
map("n", "<leader>to", function()
  require("workbench").open_current_or_select("tab")
end, { desc = "Open terminal in tab" })
map("n", "<leader>tx", function()
  require("workbench").stop_current_or_select()
end, { desc = "Stop terminal" })
