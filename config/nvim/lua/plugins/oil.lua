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
    local detail_columns = false

    return {
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = {
          desc = "Save changes",
          callback = function()
            vim.cmd("w")
          end,
          mode = "n",
        },
        ["<C-l>"] = { "actions.select" },
        ["<C-p>"] = "actions.preview",
        ["<M-p>"] = "actions.preview",
        ["<M-r>"] = "actions.refresh",
        ["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
        ["<C-y>"] = "actions.yank_entry",
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail_columns = not detail_columns
            if detail_columns then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
        ["<leader>:"] = {
          "actions.open_cmdline",
          opts = {
            shorten_path = true,
            modify = ":h",
          },
          desc = "Open the command line with the current directory as an argument",
        },
      },
    }
  end,
}
