vim.g.tokyonight_style='night'
vim.g.material_style="oceanic"
vim.g.sonokai_style="shusia"
vim.g.sonokai_enable_italic=1
vim.g.gruvbox_material_background="hard"
vim.g.gruvbox_material_palette="original"
vim.o.termguicolors=true
vim.cmd('hi LineNr guifg=#DFFF00')
vim.cmd('colorscheme gruvbox')
vim.cmd('hi Search guibg=#ff9800 guifg=#000000' )
vim.cmd('hi Visual guibg=#46413f ' )
vim.cmd('hi HopNextKey guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopNextKey1 guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopUnmatched guifg=#928374' )
-- vim.cmd('hi MatchParen guibg=#ff9800 ' )
-- require('material').set()

require("lsp-colors").setup({
	Error="#db4b4b",
	Warning="#e0af68",
	Information="#0db9d7",
	Hint="#10B981"
})
