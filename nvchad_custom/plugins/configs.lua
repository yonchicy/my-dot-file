local M = {}
M.treesitter = {
    ensure_installed = {
        "lua",
        "cpp",
        "rust",
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["ia"] = "@parameter.inner",
                -- ["af"] = "@function.outer",
                -- ["if"] = "@function.inner",
                -- ["ac"] = "@class.outer",
                -- ["ic"] = "@class.inner",
            },
        },
    }
}
M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",
        -- 
        "clangd",
        "clang-format",
        "rust-analyzer",
        -- shell
        "shfmt",
        "shellcheck",
    },
}

M.nvimtree= {
  view = {
    mappings = {
      list = {
        { key = "h",action = "close_node"},
        { key = "l",action = "edit",}
        
      }
    }
  }
  
} 
return M
