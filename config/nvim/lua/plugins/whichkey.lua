return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = false,
      },
    },
  },
}
