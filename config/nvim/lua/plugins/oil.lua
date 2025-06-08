return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = function()
    vim.keymap.set("n", "<space>-", require("oil").toggle_float)

    return {
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = { "<cmd>w<CR>" },
        ["<C-l>"] = { "actions.select" },
        ["<C-p>"] = "actions.preview",
        ["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
      },
    }
  end,
}
