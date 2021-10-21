local function clock()
	return "🎈"..os.date("%H:%M")
end
local function winnr()
	return vim.fn.winnr()
end
local function lsp_pregress()
	local messages=vim.lsp.util.get_progress_messages()

	if #messages==0 then
		return
	end
	local status={}
	for _,msg in pairs(messages) do
		table.insert(status,(msg.percentage or 0).."%%"..(msg.title or ""))
	end
	local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	return table.concat(status, " | ") .. " " .. spinners[frame + 1]

end


vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme = "tokyonight",
    section_separators = { "", "" },
    component_separators = { "", "" },
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { winnr},
    lualine_b = { "mode" },
    lualine_c = { "branch" },
    lualine_x = { "filetype", lsp_progress },
    lualine_y = { { "diagnostics", sources = { "nvim_lsp" } }, "filename" },
    lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {winnr},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nerdtree" },
}