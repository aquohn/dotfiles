require('blink.cmp').setup({
    cmdline = { enabled = false },

    sources = {
      providers = {
        omni = { enabled = true }
      }
    },

    completion = {
      documentation = {
        auto_show = true
      }
    }
  })
