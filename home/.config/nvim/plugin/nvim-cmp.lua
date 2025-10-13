-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      }, {
        { name = 'buffer',
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          }
        },
      })
  })

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      })
  })
require("cmp_git").setup()

for ftype in next, {"txt", "org", "markdown"} do
  cmp.setup.filetype(ftype, {
    enabled = false,
  })
end

function setAutoCmp(mode)
  if mode then
    cmp.setup({
      completion = {
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
      }
    })
  else
    cmp.setup({
      completion = {
        autocomplete = false
      }
    })
  end
end

-- enable automatic completion popup on typing
vim.cmd('command AutoCmpOn lua setAutoCmp(true)')

-- disable automatic competion popup on typing
vim.cmd('command AutoCmpOff lua setAutoCmp(false)')

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
if vim.version().major < 11 then
  local lspconfig = require('lspconfig')
  lspconfig.rescriptls.setup {
    capabilities = capabilities
  }
  lspconfig.clangd.setup {
    capabilities = capabilities
  }
else
  vim.lsp.config('rescriptls', {
    capabilities = capabilities
  })
  vim.lsp.config('clangd', {
    capabilities = capabilities
  })
end
