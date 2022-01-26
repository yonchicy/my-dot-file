-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/root/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/root/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/root/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/root/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/root/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["AutoSave.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/AutoSave.nvim",
    url = "https://gitclone.com/Pocco81/AutoSave.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://gitclone.com/L3MON4D3/LuaSnip"
  },
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/TrueZen.nvim",
    url = "https://gitclone.com/Pocco81/TrueZen.nvim"
  },
  ["argtextobj.vim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/argtextobj.vim",
    url = "https://gitclone.com/vim-scripts/argtextobj.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://gitclone.com/jiangmiao/auto-pairs"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://gitclone.com/akinsho/bufferline.nvim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/clever-f.vim",
    url = "https://gitclone.com/rhysd/clever-f.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://gitclone.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://gitclone.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://gitclone.com/saadparwaiz1/cmp_luasnip"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://gitclone.com/glepnir/dashboard-nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://gitclone.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://gitclone.com/lewis6991/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/root/.local/share/nvim/site/pack/packer/opt/goyo.vim",
    url = "https://gitclone.com/junegunn/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://gitclone.com/morhetz/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://gitclone.com/sainnhe/gruvbox-material"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://gitclone.com/ray-x/guihua.lua"
  },
  hop = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/hop",
    url = "https://gitclone.com/phaazon/hop.nvim"
  },
  ["limelight.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/root/.local/share/nvim/site/pack/packer/opt/limelight.vim",
    url = "https://gitclone.com/junegunn/limelight.vim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://gitclone.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://gitclone.com/hoob3rt/lualine.nvim"
  },
  ["marks.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/marks.nvim",
    url = "https://gitclone.com/chentau/marks.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/material.nvim",
    url = "https://gitclone.com/marko-cerovac/material.nvim"
  },
  ["navigator.lua"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/navigator.lua",
    url = "https://gitclone.com/ray-x/navigator.lua"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://gitclone.com/hrsh7th/nvim-cmp"
  },
  ["nvim-gps"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-gps",
    url = "https://gitclone.com/SmiteshP/nvim-gps"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://gitclone.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://gitclone.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://gitclone.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://gitclone.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://gitclone.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://gitclone.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://gitclone.com/kyazdani42/nvim-web-devicons"
  },
  ["onedarkpro.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
    url = "https://gitclone.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://gitclone.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://gitclone.com/nvim-lua/plenary.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/quick-scope",
    url = "https://gitclone.com/unblevable/quick-scope"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/registers.nvim",
    url = "https://gitclone.com/tversteeg/registers.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://gitclone.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://gitclone.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://gitclone.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://gitclone.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://gitclone.com/folke/trouble.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-code-dark",
    url = "https://gitclone.com/tomasiser/vim-code-dark"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://gitclone.com/tpope/vim-commentary"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://gitclone.com/tpope/vim-dispatch"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://gitclone.com/junegunn/vim-easy-align"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://gitclone.com/psliwka/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/root/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://gitclone.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
