return {
  "folke/twilight.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Twilight", "TwilightEnable" },
  opts = function()
    local map = vim.keymap.set
    map("n", "<leader>tw", "<cmd>Twilight<cr>", { desc = "Toggle Twilight mode" })

    return {}
  end,
}
