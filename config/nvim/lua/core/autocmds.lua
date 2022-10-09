local settings = {
      copy_cut = true, -- copy cut text ( x key ), visual and normal mode
      copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
      insert_nav = true, -- navigation in insertmode
      window_nav = true,
      terminal_numbers = false,

      -- updater
      update_url = "https://github.com/NvChad/NvChad",
      update_branch = "main",
}

if not settings.terminal_numbers then
   vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
end
