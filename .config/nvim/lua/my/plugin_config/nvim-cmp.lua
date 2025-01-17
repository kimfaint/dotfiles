-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local my_on_attach = function(client, bufnr)
  print("my_on_attach")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pylsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig')['pylsp'].setup {
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    include_params = true,
                },
		pycodestyle = {
                    ignore = {'E501'}
		}
            },
        },
    },
}

local pythonpath = os.getenv("PYTHONPATH")
local handle = io.popen('which python')
local output = handle:read('*a')
local format = output:gsub('[\n\r]', '')
local pythonexe = format
print("pythonexe:", pythonexe)

require('lspconfig')['robotframework_ls'].setup {
    on_attach = my_on_attach,
    capabilities = capabilities,
    settings = {
        robot = {
            pythonpath = {
                pythonpath
            },
            python = {
                executable = pythonexe
            }
        }
    }
}


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'codeium' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
