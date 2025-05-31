return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = function()
      return {
        watch_for_changes = true,
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },
}
