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
vim.cmd("let g:rnvimr_enable_ex=1")
vim.cmd("let g:rnvimr_enable_picker=1")
vim.cmd("let g:rnvimr_draw_border=0")

require'hop'.setup {keys='etovxqpdygfblzhckisuran'}
-- require('plug_set.todo-comments')
require('plug_set.lualine')
require('plug_set.colorscheme')
require('plug_set.treesitter')
require('plug_set.toggleterm')
-- require('plug_set.orgmode')
require('plug_set.telescope')
require('plug_set.neogit')
require('plug_set.marks')
require('plug_set.nvim-tree')
require('plug_set.trouble')
require('plug_set.gitsigns_status')
require('plug_set.AutoSave')
require('plug_set.context')
-- require('plug_set.lightspeed')
