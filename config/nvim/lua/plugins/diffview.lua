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
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
      },
    })
  end,
}
