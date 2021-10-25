require('nvim-treesitter.configs').setup{
	ensure_installed={"c","rust","lua","python"},
	highlight={
		enable=true;
	},
	indent={
		enable=true;
	},
	incremental_selection={
		enable=true,
		keymaps={
		init_selection    = "gnn",
			node_incremental  = "grn",
			scope_incremental = "grc",
			node_decremental  = "grm",
		},
	},
	rainbow={
		enable=true,
		extended_mode=true,
		max_file_lines=nil,
	},
	textobjects={
		select={
			enable=true,

			lookahead=true,
		}

	}
}
vim.cmd('set foldmethod=manual')
-- vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')

