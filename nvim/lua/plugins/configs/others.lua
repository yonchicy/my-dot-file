local M={}

M.lsp_handlers = function()
   local function lspSymbol(name, icon)
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
   end

   lspSymbol("Error", "")
   lspSymbol("Info", "")
   lspSymbol("Hint", "")
   lspSymbol("Warn", "")

   vim.diagnostic.config {
      virtual_text = {
         prefix = "",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
   }

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
   })
   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
   })

   -- suppress error messages from lang servers
   vim.notify = function(msg, log_level)
      if msg:match "exit code" then
         return
      end
      if log_level == vim.log.levels.ERROR then
         vim.api.nvim_err_writeln(msg)
      else
         vim.api.nvim_echo({ { msg } }, true, {})
      end
   end
end

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if present then
      local default = {
         history = true,
         updateevents = "TextChanged,TextChangedI",
      }
      luasnip.config.set_config(default)
      -- require("luasnip/loaders/from_vscode").load { paths = chadrc_config.plugins.options.luasnip.snippet_path }
      require("luasnip/loaders/from_vscode").load()
   end
end
M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

   if present1 and present2 then
      local default = { fast_wrap = {} }
      autopairs.setup(default)

      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
   end
end
M.comment = function()
   local present, nvim_comment = pcall(require, "Comment")
   if present then
      local default = {}
      nvim_comment.setup(default)
   end
end
M.blankline = function()
   local default = {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "alpha",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
         "nvchad_cheatsheet",
         "lsp-installer",
         "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      space_char_blankline = " ",
      show_current_context=true,
   }
   require("indent_blankline").setup(default)
end
M.gitsigns = function()
   local present, gitsigns = pcall(require, "gitsigns")
   if present then
      local default = {
         signs = {
            add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
            change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
            delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
            topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
            changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
         },
      }
      gitsigns.setup(default)
   end
end
M.signature = function(override_flag)
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      local default = {
         bind = true,
         doc_lines = 0,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
      if override_flag then
         default = require("core.utils").tbl_override_req("signature", default)
      end
      lspsignature.setup(default)
   end
end
M.lsp_installer = function ()
    local present, lspinstaller = pcall(require, "nvim-lsp-installer")
    if present then
        local servers = {
            "clangd",
            "pyright",
            "rust_analyzer",
            "sumneko_lua",
        }

        for _, name in pairs(servers) do
            local server_is_found, server = lspinstaller.get_server(name)
            if server_is_found and not server:is_installed() then
                print("Installing " .. name)
                server:install()
            end
        end
    end
end
M.nvim_colorizer = function ()
    local present, nvim_colorizer = pcall(require,"colorizer")
    if present then
        nvim_colorizer.setup({"*"},{
            RGB=true,
            RRGGBB=true,
            RRGGBBAA=true,
            rgb_fn=true,
            hsl_fn=true
        })
    end
end
return M
