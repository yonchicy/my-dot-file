  -- Setup lspconfig.

-- local lsp_setup={
-- 	on_attach = fuction(client,bufnr)
-- 			require"lsp_signature".on_attach()
-- 		end

-- }
  require('lspconfig').clangd.setup ({
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  })
  require('lspconfig').rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  require'lspconfig'.pyright.setup{}

-- auto complete
--
  local cmp=  require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.

        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },

    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<C-e>'] = cmp.mapping.close(),
	  ['<Tab>'] = cmp.mapping.confirm({
		  select = true ,
		  behavior=cmp.ConfirmBehavior.Replace
	  }),
	  -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(),{
		  -- 'i','s'
	  -- }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'orgmode' },

      -- For vsnip user.

      -- For luasnip user.
      { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })



-- lsp config
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')


end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
