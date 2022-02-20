-- following options are the default

local tree_cb = require'nvim-tree.config'.nvim_tree_callback



require'nvim-tree'.setup {
}
local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_window_picker_exclude = {
   filetype = { "notify", "packer", "qf" },
   buftype = { "terminal" },
}

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = 1,
}

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
   },
   folder = {
      default = "",
      empty = "",
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
   },
}

local default = {
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   git = {
      enable = false,
      ignore = false,
   },
	update_to_buf_dir   = {
	  -- enable the feature
	  enable = true,
	  -- allow to open the tree if it was previously closed
	  auto_open = true,
	},
	-- show lsp diagnostics in the signcolumn
	diagnostics = {
	  enable = false,
	  icons = {
		hint = "",
		info = "",
		warning = "",
		error = "",
	  }
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
	  -- the command to run this, leaving nil should work in most cases
	  cmd  = nil,
	  -- the command arguments as a list
	  args = {}
	},

	view = {
	  -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
      allow_resize = true,
      side = "left",
      width = 25,
      hide_root_folder = true,
	  height = 30,
	  auto_resize = false,
	  mappings = {
		custom_only = false,
		list = {
			{ key = {"l","<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
			{ key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
			{ key = "<C-v>",                        cb = tree_cb("vsplit") },
			{ key = "<C-x>",                        cb = tree_cb("split") },
			{ key = "<C-n>",                        cb = tree_cb("tabnew") },
			{ key = "<",                            cb = tree_cb("prev_sibling") },
			{ key = ">",                            cb = tree_cb("next_sibling") },
			{ key = "P",                            cb = tree_cb("parent_node") },
			{ key = "<BS>",                         cb = tree_cb("close_node") },
			{ key = "h",                         cb = tree_cb("close_node") },
			{ key = "<S-CR>",                       cb = tree_cb("close_node") },
			{ key = "<Tab>",                        cb = tree_cb("preview") },
			{ key = "K",                            cb = tree_cb("first_sibling") },
			{ key = "J",                            cb = tree_cb("last_sibling") },
			{ key = "I",                            cb = tree_cb("toggle_ignored") },
			{ key = "H",                            cb = tree_cb("toggle_dotfiles") },
			{ key = "R",                            cb = tree_cb("refresh") },
			{ key = "a",                            cb = tree_cb("create") },
			{ key = "dd",                            cb = tree_cb("cut") },
			{ key = "dD",                            cb = tree_cb("remove") },
			{ key = "r",                            cb = tree_cb("rename") },
			{ key = "<C-r>",                        cb = tree_cb("full_rename") },
			{ key = "x",                            cb = tree_cb("cut") },
			{ key = "c",                            cb = tree_cb("copy") },
			{ key = "p",                            cb = tree_cb("paste") },
			{ key = "yn",                            cb = tree_cb("copy_name") },
			{ key = "Y",                            cb = tree_cb("copy_path") },
			{ key = "yp",                           cb = tree_cb("copy_absolute_path") },
			{ key = "[c",                           cb = tree_cb("prev_git_item") },
			{ key = "]c",                           cb = tree_cb("next_git_item") },
			{ key = "-",                            cb = tree_cb("dir_up") },
			{ key = "s",                            cb = tree_cb("system_open") },
			{ key = "q",                            cb = tree_cb("close") },
			{ key = "g?",                           cb = tree_cb("toggle_help") },
		  }
	  }
	}
}

local M = {}

M.setup = function(override_flag)
   if override_flag then
      default = require("core.utils").tbl_override_req("nvim_tree", default)
   end
   nvimtree.setup(default)
end

return M
