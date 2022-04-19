local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
--
local get_random_theme = function ()
    local light_themes = {
        "blossom",
    }
    local all_dark_theme = {
        "aquarium",
        "catppuccin",
        "chadracula",
        "chadtain",
        "classic-dark" ,
        "doom-chad",
        "everforest",
        "gruvbox",
        "gruvchad",
        "javacafe",
        "jellybeans",
        "kanagawa",
        "lfgruv",
        "monekai",
        "monokai",
        "mountain",
        "nightlamp",
        "night-owl",
        "nord",
        "onebright",
        "onedark-deep" ,
        "onedark" ,
        "onejelly" ,
        "one-light",
        "onenord" ,
        "palenight" ,
        "paradise" ,
        "penokai" ,
        "solarized" ,
        "tokyodark" ,
        "tokyonight" ,
        "tomorrow-night" ,
        "wombat"
    }
    math.randomseed(os.time())
    return  all_dark_theme[math.random(#all_dark_theme)]
end
M.init = function(theme)
    if not theme then
        theme = get_random_theme()
    end

    -- set the global theme, used at various places like theme switcher, highlights
    vim.g.nvchad_theme = theme

    local present, base16 = pcall(require, "base16")

    if present then
        -- first load the base16 theme
        base16(base16.themes(theme), true)

        -- unload to force reload
        package.loaded["colors.highlights" or false] = nil
        -- then load the highlights
        require "colors.highlights"
    end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
    if not theme then
        theme = vim.g.nvchad_theme
    end

    return require("hl_themes." .. theme)
end

M.set_random_theme = function ()
    M.init(get_random_theme())
end

return M
