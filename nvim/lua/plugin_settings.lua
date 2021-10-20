require("bufferline").setup{}

vim.cmd("let g:airline_powerline_fonts=1")
vim.cmd("let g:airline_section_c=''")
vim.cmd("let g:airline_section_y='%{strftime(\"%H:%M\")}'")
