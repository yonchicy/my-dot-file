require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
local opt = vim.opt
local g = vim.g

opt.nu=true
opt.scrolloff=8
opt.sidescrolloff=8
opt.wrap=false
opt.tabstop=2
opt.shiftwidth=2
opt.expandtab=true
opt.wildmode = { "longest", "list:full" }
-- opt.guifont = "CodeNewRoman Nerd Font:h15" -- the font used in graphical neovim applications

-- hilight yank
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150,on_visual=true }) end })
g.neovide_cursor_vfx_mode = "railgun"

-- g.neovide_transparency = 0.7




local goto_file = function ()
    local line = vim.api.nvim_get_current_line();
    local pattern = "^(.-):(%d+):(%d+)"
    local file, line, column = string.match(line, pattern)
    if file and line  and column then
        vim.cmd("close")
        vim.cmd("e ".. file)
        vim.api.nvim_win_set_cursor(0, {tonumber(line),tonumber(column)})
    end
end
vim.api.nvim_create_autocmd({"BufEnter","TermOpen"}, {
    pattern= "term://*",
    callback = function ()
        vim.keymap.set("n","<leader>cd",goto_file,{silent=true,noremap=true,buffer=true,desc = "go to file"})
    end
}
)
