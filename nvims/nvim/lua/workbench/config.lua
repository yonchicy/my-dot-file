local M = {}

M.defaults = {
  default_layout = "split",
  split_height = 18,
  float = {
    width = 0.86,
    height = 0.78,
    border = "rounded",
  },
  notifications = {
    enabled = true,
    on_attention = true,
    on_exit = true,
    on_start = false,
  },
  profiles = {
    codex = {
      command = vim.env.CODEX_CMD or "codex",
      -- These are deliberately conservative. CLI agents do not expose a
      -- universal status protocol, so non-Codex terminals have no matcher by
      -- default and users can extend this list for their own tools.
      attention_patterns = {
        "Press Enter to continue",
        "Allow this",
        "[Y/n]",
        "[y/N]",
      },
    },
  },
}

function M.make(user_config)
  return vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), user_config or {})
end

return M
