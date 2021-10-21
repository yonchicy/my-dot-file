require'nvim-treesitter.configs'.setup{
	ensure_installed={"c","rust","lua"},
	highlight={
		enable=true;
	},
	indent={
		enable=true;
	},
}
vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
