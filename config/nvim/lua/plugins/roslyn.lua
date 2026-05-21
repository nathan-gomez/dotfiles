return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  config = function()
    -- TODO: configure formatter
    require("roslyn").setup({})

    local handles = {}

    -- Restore progress with fidget
    vim.api.nvim_create_autocmd("User", {
      pattern = "RoslynRestoreProgress",
      callback = function(ev)
        local token = ev.data.params[1]
        local handle = handles[token]
        if handle then
          handle:report({
            title = ev.data.params[2].state,
            message = ev.data.params[2].message,
          })
        else
          handles[token] = require("fidget.progress").handle.create({
            title = ev.data.params[2].state,
            message = ev.data.params[2].message,
            lsp_client = {
              name = "roslyn",
            },
          })
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "RoslynRestoreResult",
      callback = function(ev)
        local handle = handles[ev.data.token]
        handles[ev.data.token] = nil

        if handle then
          handle.message = ev.data.err and ev.data.err.message or "Restore completed"
          handle:finish()
        end
      end,
    })
  end,
}
