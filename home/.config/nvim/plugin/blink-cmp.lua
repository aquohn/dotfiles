local blink = require('blink.cmp')
blink.setup({
    cmdline = { enabled = false },

    sources = {
      default = { 'lsp', 'omni', 'path', 'snippets', 'buffer' },
      providers = {
        omni = {
          enabled = true,
          -- omnifuncs don't define trigger characters
          -- so we have to do it manually
          override = {
            -- vimtex
            get_trigger_characters = function()
              if vim.bo.filetype == 'tex' then
                return { '\\', '[', '{' }
              end
              return {}
            end
          }
        }
      }
    },

    completion = {
      documentation = {
        auto_show = true
      }
    }
  })
