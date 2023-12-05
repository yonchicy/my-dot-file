  local cmp = require("cmp")
local M = {}
M.treesitter = {
	ensure_installed = {
		"lua",
		"cpp",
		"rust",
	},
	textobjects = {
	},
  indent = { enable = false },
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
	-- view = {
	-- 	mappings = {
	-- 		list = {
	-- 			{ key = "h", action = "close_node" },
	-- 			{ key = "l", action = "edit" },
	-- 		},
	-- 	},
	-- },
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
M.nvterm = {
  terminals = {
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.1,
        col = 0.1,
        width = 0.8,
        height = 0.8,
        border = "single",
      },
    }
  },
}
return M

