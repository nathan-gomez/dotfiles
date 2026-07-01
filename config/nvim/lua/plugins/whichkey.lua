return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    presets = "classic",
    filter = function(mapping)
      -- exclude mappings without a description
      return mapping.desc and mapping.desc ~= ""
    end,
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    ---@type wk.Win.opts
    win = {
      border = "single",
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
  },
}
