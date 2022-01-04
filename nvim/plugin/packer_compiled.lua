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
local package_path_str = "/home/yang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/yang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/yang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/yang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/yang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
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
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/AutoSave.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["argtextobj.vim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/argtextobj.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/bufferline.nvim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/clever-f.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yang/.local/share/nvim/site/pack/packer/opt/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/guihua.lua"
  },
  hop = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["limelight.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yang/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["marks.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/marks.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  ["navigator.lua"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/navigator.lua"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-gps"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-gps"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedarkpro.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/registers.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-code-dark"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/yang/.local/share/nvim/site/pack/packer/start/vim-surround"
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
