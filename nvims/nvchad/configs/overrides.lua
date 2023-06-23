  local cmp = require("cmp")
-- local M = {}
--
-- M.treesitter = {
--   ensure_installed = {
--     "vim",
--     "lua",
--     "html",
--     "css",
--     "javascript",
--     "c",
--     "markdown",
--     "markdown_inline",
--   },
-- }
--
-- M.mason = {
--   ensure_installed = {
--     -- lua stuff
--     "lua-language-server",
--     "stylua",
--
--     -- web dev stuff
--     "css-lsp",
--     "html-lsp",
--     "typescript-language-server",
--     "deno",
--   },
-- }
--
-- -- git support in nvimtree
-- M.nvimtree = {
--   git = {
--     enable = true,
--   },
--
--   renderer = {
--     highlight_git = true,
--     icons = {
--       show = {
--         git = true,
--       },
--     },
--   },
-- }
--
-- return M
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
      set_jumps = true,
			keymaps = {
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
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

    -- "debug"
    "codelldb",

    -- python
    pyright,
	},
}
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
 api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('close dir'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('open'))

end
M.nvimtree = {
	on_attach=on_attach,
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
	view = {
		mappings = {
			list = {
				{ key = "h", action = "close_node" },
				{ key = "l", action = "edit" },
			},
		},
	},
}

M.gitsigns = {
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 500,
		ignore_whitespace = false,
	},
}
M.cmp = {

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				cmp.confirm()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}
return M

