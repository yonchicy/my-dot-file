local gps=require("nvim-gps")
local function clock()
	return "🎈"..os.date("%H:%M")
end
local function winnr()
	local hello= tostring(vim.fn.winnr())
	return hello
end
local function lsp_progress()
	local messages=vim.lsp.util.get_progress_messages()

	if #messages==0 then
		local msg = 'No Active Lsp'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
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

local function getname()
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



-- -- Eviline config for lualine
-- -- Author: shadmansaleh
-- -- Credit: glepnir
local lualine = require 'lualine'

-- -- Color table for highlights
-- -- stylua: ignore
-- local colors = {
--   bg       = '#202328',
--   fg       = '#bbc2cf',
--   yellow   = '#ECBE7B',
--   cyan     = '#008080',
--   darkblue = '#081633',
--   green    = '#98be65',
--   orange   = '#FF8800',
--   violet   = '#a9a1e1',
--   magenta  = '#c678dd',
--   blue     = '#51afef',
--   red      = '#ec5f67',
-- }

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- -- Config
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
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {winnr},
    lualine_b = {'filename'},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- -- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
local function ins_left_a(component)
  table.insert(config.sections.lualine_a, component)
end
local function ins_left_b(component)
  table.insert(config.sections.lualine_b, component)
end
-- -- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end
local function ins_right_y(component)
  table.insert(config.sections.lualine_y, component)
end

local function ins_right_z(component)
  table.insert(config.sections.lualine_z, component)
end
ins_left_a {
  function()
    local hello= tostring(vim.fn.winnr())
    return hello
  end,
  padding = { left = 0, right = 1 }, -- We don't need space before this
}
ins_left_a {
	'mode'
}


-- ins_left {
--   -- mode component
--   function()
--     -- auto change color according to neovims mode
--     vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
--     return ''
--   end,
--   color = 'LualineMode',
--   padding = { right = 1 },
-- }

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left_b {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}


ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}
-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left {
--   function()
--     return '%='
--   end,
-- }


ins_left {
  -- Lsp server name .
  lsp_progress,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}
ins_left {
  gps.get_location,cond=gps.is_available
}


-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right_y {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

-- ins_right {
--   'diff',
--   -- Is it me or the symbol for modified us really weird
--   symbols = { added = ' ', modified = '柳 ', removed = ' ' },
--   diff_color = {
--     added = { fg = colors.green },
--     modified = { fg = colors.orange },
--     removed = { fg = colors.red },
--   },
--   cond = conditions.hide_in_width,
-- }

ins_right_y { 'progress', color = { fg = colors.fg, gui = 'bold' } }
ins_right_y { 'location' }

ins_right_z { clock }

-- Now don't forget to initialize lualine
lualine.setup(config)
