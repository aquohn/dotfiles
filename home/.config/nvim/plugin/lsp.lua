if vim.fn.executable('nix') then
  require("lazy-lsp").setup {
      use_vim_lsp_config = true,
      excluded_servers = {
        "ccls",                            -- prefer clangd
        "denols",                          -- prefer eslint and ts_ls
        "docker_compose_language_service", -- yamlls should be enough?
        "flow",                            -- prefer eslint and ts_ls
        "ltex",                            -- grammar tool using too much CPU
        "quick_lint_js",                   -- prefer eslint and ts_ls
        "scry",                            -- archived on Jun 1, 2023 "tailwindcss",                     -- associates with too many filetypes
        "biome",                           -- not mature enough to be default
        "oxlint",                          -- prefer eslint
      },
      preferred_servers = {
        markdown = {},
        python = { "ty", "basedpyright", "ruff" },
      },
  }
end
vim.lsp.enable { 'guile_ls' }

vim.diagnostic.config {
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
  underline = true,
  float = {
    source = 'if_many'
  }
}

-- Utilities
require('nvim-lightbulb').setup {
  autocmd = { enabled = true }
}

-- Buffers to ignore
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local bufnr = args.buf
        local bufname = vim.api.nvim_buf_get_name(bufnr)

        -- Check if the buffer name starts with 'fugitive://'
        if bufname:match("^fugitive://") then
            -- We defer the detachment slightly to ensure the
            -- attachment process has finished before we sever it.
            vim.schedule(function()
                vim.lsp.buf_detach_client(bufnr, args.data.client_id)
            end)
        end
    end,
})


if vim.fn.has('nvim-0.11') == 0 then
  --- Default maps for LSP functions, for older versions of nvim
  do
    vim.keymap.set('n', 'grn', function()
      vim.lsp.buf.rename()
    end, { desc = 'vim.lsp.buf.rename()' })

    vim.keymap.set({ 'n', 'x' }, 'gra', function()
      vim.lsp.buf.code_action()
    end, { desc = 'vim.lsp.buf.code_action()' })

    vim.keymap.set('n', 'grr', function()
      vim.lsp.buf.references()
    end, { desc = 'vim.lsp.buf.references()' })

    vim.keymap.set('n', 'gri', function()
      vim.lsp.buf.implementation()
    end, { desc = 'vim.lsp.buf.implementation()' })

    vim.keymap.set('n', 'grt', function()
      vim.lsp.buf.type_definition()
    end, { desc = 'vim.lsp.buf.type_definition()' })

    vim.keymap.set({ 'x', 'o' }, 'an', function()
      vim.lsp.buf.selection_range(vim.v.count1)
    end, { desc = 'vim.lsp.buf.selection_range(vim.v.count1)' })

    vim.keymap.set({ 'x', 'o' }, 'in', function()
      vim.lsp.buf.selection_range(-vim.v.count1)
    end, { desc = 'vim.lsp.buf.selection_range(-vim.v.count1)' })

    vim.keymap.set('n', 'gO', function()
      vim.lsp.buf.document_symbol()
    end, { desc = 'vim.lsp.buf.document_symbol()' })

    vim.keymap.set({ 'i', 's' }, '<C-S>', function()
      vim.lsp.buf.signature_help()
    end, { desc = 'vim.lsp.buf.signature_help()' })
  end
end
