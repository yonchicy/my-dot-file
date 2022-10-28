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
	},
}

M.nvimtree = {
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
return M
