return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    {
      "<leader>fe",
      "<cmd>Oil<cr>",
      desc = "Oil: File Explorer",
    },
  },
  opts = function()
    return {
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = { "<cmd>w<cr>" },
        ["<C-l>"] = { "actions.select" },
        ["<C-p>"] = "actions.preview",
        ["<M-p>"] = "actions.preview",
        ["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
      },
    }
  end,
}
