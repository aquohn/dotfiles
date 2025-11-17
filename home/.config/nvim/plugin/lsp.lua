-- require('goto-preview').setup {}

require('nvim-lightbulb').setup({
    autocmd = { enabled = true }
  })

require("mason").setup()

vim.lsp.enable({'clangd', 'texlab', 'zuban', 'guile_ls', 'julials',
    'rust_analyzer', 'ocamllsp', 'rescriptls', 'vhdl_ls', 'verible'})
