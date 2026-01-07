-- require('goto-preview').setup {}

require('nvim-lightbulb').setup({
    autocmd = { enabled = true }
  })

if vim.fn.executable('nix') then
  require("lazy-lsp").setup({
      use_vim_lsp_config = true,
      excluded_servers = {
        "ccls",                            -- prefer clangd
        "denols",                          -- prefer eslint and ts_ls
        "docker_compose_language_service", -- yamlls should be enough?
        "flow",                            -- prefer eslint and ts_ls
        "ltex",                            -- grammar tool using too much CPU
        "quick_lint_js",                   -- prefer eslint and ts_ls
        "scry",                            -- archived on Jun 1, 2023
        "tailwindcss",                     -- associates with too many filetypes
        "biome",                           -- not mature enough to be default
        "oxlint",                          -- prefer eslint
      },
      preferred_servers = {
        markdown = {},
        python = { "ty", "basedpyright", "ruff" },
      },
  })
end
require("mason").setup()
vim.lsp.enable({"clangd", "texlab", "guile_ls", "julials", "ty", "rust_analyzer", "ocamllsp", "rescriptls", "vhdl_ls", "verible", "basedpyright", "ruff"})
