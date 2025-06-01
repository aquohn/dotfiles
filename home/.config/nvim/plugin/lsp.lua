-- require('goto-preview').setup {}

require('nvim-lightbulb').setup({
  autocmd = { enabled = true }
})

require("mason").setup()

local lspconfig = require('lspconfig')

lspconfig.rescriptls.setup{}
lspconfig.clangd.setup{}
