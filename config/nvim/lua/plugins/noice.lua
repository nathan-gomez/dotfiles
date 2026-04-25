return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>nh",
      function()
        require("noice").cmd("snacks")
      end,
      desc = "Open Notification History",
    },
  },
  opts = {
    cmdline = { enabled = false },
    messages = { enabled = false },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      lsp_doc_border = true,
      long_message_to_split = true,
    },
  },
}
