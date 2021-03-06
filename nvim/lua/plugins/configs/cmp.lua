local present, cmp = pcall(require, "cmp")

if not present then
   return
end

vim.opt.completeopt = "menuone,noselect"

local luasnip = require("luasnip")
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local default = {
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   formatting = {
      format = function(entry, vim_item)
         local icons = require "plugins.configs.lspkind_icons"
         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      -- ["<Tab>"] = function(fallback)
      --    if cmp.visible() then
      --       cmp.select_next_item()
      --    elseif require("luasnip").expand_or_jumpable() then
      --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      --    else
      --       fallback()
      --    end
      -- end,
      -- ["<S-Tab>"] = function(fallback)
      --    if cmp.visible() then
      --       cmp.select_prev_item()
      --    elseif require("luasnip").jumpable(-1) then
      --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      --    else
      --       fallback()
      --    end
      -- end,

      ["<Tab>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then
					-- cmp.select_next_item()
					cmp.confirm{
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
						}
				elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                    fallback()
                end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
   },
}

local M = {}
M.setup = function()
   cmp.setup(default)
end

return M
