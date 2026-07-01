return {
  "leath-dub/snipe.nvim",
  keys = {
    {
      "<leader>of",
      function() require("snipe").open_buffer_menu() end,
      desc = "Open Snipe buffer menu",
    },
  },
  opts = {
    ui = {
      preselect_current = true,
      position = "center",
      open_win_override = {
        title = "Buffers",
        border = "single",
      },
    },
    navigate = {
      close_buffer = "X",
      open_split = "S",
    },
  },
}
