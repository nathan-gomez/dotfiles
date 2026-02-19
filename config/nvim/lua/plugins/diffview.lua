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
}
