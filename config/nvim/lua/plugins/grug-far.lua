return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  init = function()
    -- fix for which-key not recognizing the <localleader>
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function(ev)
        vim.schedule(function()
          local ok, wk_buf = pcall(require, "which-key.buf")

          if ok and vim.api.nvim_buf_is_valid(ev.buf) then
            wk_buf.clear({ buf = ev.buf })
          end
        end)
      end,
    })
  end,
  opts = {
    startInInsertMode = false,
    windowCreationCommand = "tab split",
    openTargetWindow = {
      preferredLocation = "below",
    },
    keymaps = {
      close = { n = "<localleader>q" },
    },
  },
  keys = {
    {
      "<leader>rs",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")

        grug.open({
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "x" },
      desc = "Find and Replace",
    },
    {
      "<leader>rr",
      function()
        require("grug-far").open({
          visualSelectionUsage = "operate-within-range",
        })
      end,
      mode = "x",
      desc = "Range Find and Replace",
    },
  },
}
