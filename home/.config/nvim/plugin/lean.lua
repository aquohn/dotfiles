vim.api.nvim_create_autocmd("FileType", {
  pattern = ".lean",
  callback = function()
    require("lean").setup({
      mappings = true
    })
  end,
})
