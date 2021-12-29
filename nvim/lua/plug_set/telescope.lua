require('telescope').setup{

	defaults={
		layout_strategy="flex",
		scroll_strategy = "cycle",
		previewer = true,
		layout_config = {
			vertical ={
				mirror = true,
			}
		},
		file_previewer=require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer=require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer=require'telescope.previewers'.vim_buffer_qflist.new,
		mappings={
			i={
				["<c-h>"]= "which_key"
			}
		}
	},
	-- extensions = {
	-- 	fzf = {
	-- 		fuzzy = true,                    -- false will only do exact matching
	-- 		override_generic_sorter = true,  -- override the generic sorter
	-- 		override_file_sorter = true,     -- override the file sorter
	-- 		case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
	-- 										 -- the default case_mode is "smart_case"
	-- 	  }
	-- }

}


-- require('telescope').load_extension('fzf')

