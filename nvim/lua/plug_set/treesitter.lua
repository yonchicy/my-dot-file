require('nvim-treesitter.configs').setup{
	ensure_installed={"c","rust","lua"},
	highlight={
		enable=true;
	},
	-- indent={
	-- 	enable=true;
	-- },
	rainbow={
		enable=true,
		extended_mode=true,
		max_file_lines=nil,
	}
}
vim.cmd('set foldmethod=manual')
-- vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
