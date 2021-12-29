local gps=require("nvim-gps")
local function clock()
	return "🎈"..os.date("%H:%M")
end
local function winnr()
	local hello= tostring(vim.fn.winnr())
	return hello
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

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme =bubbles_theme,
    section_separators = { left = '', right = '' },
    component_separators = '|',
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
  },
  sections = {
		lualine_a = {
			winnr,
		},-- Lua
-- {"filename",file_status=true,path=2}
    lualine_b = { "mode",'filename','branch' },
    lualine_c = {},
    lualine_x = { "filetype", lsp_pregress },
    lualine_y = {  "diagnostics",},
    lualine_z = { 'location' ,clock},
  },
  inactive_sections = {
    lualine_a = {winnr},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nerdtree" },
}

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()
