local blink = require('blink.cmp')
blink.setup({
    enabled = function()
      for _, value in ipairs{"AgenticInput", "Copilot"} do
        if string.find(vim.bo.filetype, value, 1, true) then
          return false
        end
      end
    end,

    cmdline = { enabled = false },
    sources = {
      default = { 'lsp', 'omni', 'path', 'snippets', 'buffer' },
      providers = {
        omni = {
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

require('fzf-lua').register_ui_select()
