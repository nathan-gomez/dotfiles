return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  keys = {
    {
      "<leader>dv",
      "<cmd>DiffviewOpen<CR>",
      desc = "Diffview: Open",
    },
    {
      "<leader>dh",
      "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>",
      desc = "Diffview: Review against base branch",
    },
  },
  config = function()
    require("diffview").setup({
      file_panel = {
        listing_style = "list",
      },
      view = {
        default = {
          layout = "diff2_vertical",
        },
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
      },
      keymaps = {
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" } },
        },
      },
    })
  end,
}
