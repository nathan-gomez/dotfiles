return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    local markview = require("markview")

    vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "[m]arkdown [s]plit view" })
    vim.keymap.set("n", "<leader>mt", "<cmd>Markview<cr>", { desc = "[m]arkdown [t]oggle view" })

    markview.setup({
      preview = {
        icon_provider = "devicons",
      },
    })
  end,
}
