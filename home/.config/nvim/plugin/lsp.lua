-- require('goto-preview').setup {}

require('nvim-lightbulb').setup({
    autocmd = { enabled = true }
  })

require("mason").setup()

vim.lsp.enable({'clangd', 'texlab', 'guile_ls', 'julials', 'ty',
    'rust_analyzer', 'ocamllsp', 'rescriptls', 'vhdl_ls', 'verible'})
