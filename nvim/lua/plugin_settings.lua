require("bufferline").setup{
	show_close_icon=false,
	separator_style="thick",
}

vim.cmd("let g:airline_powerline_fonts=1")
vim.cmd("let g:airline_section_c=''")
vim.cmd("let g:airline_section_y='%{strftime(\"%H:%M\")}'")
vim.cmd("let g:dashboard_default_executive='telescope'")
vim.cmd("let g:dashboard_custom_header=[ 'look at the bottom' ]")
vim.cmd("let g:dashboard_custom_footer=[ 'look at the top' ]")

require('plug_set.lualine')
require('plug_set.colorscheme')
