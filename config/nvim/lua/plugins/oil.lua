return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
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
