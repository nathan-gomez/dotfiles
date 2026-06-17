return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup({
        functionStyle = { bold = true },
        typeStyle = { italic = true },
        transparent = true,
        minimal = true,
      })

      -- vim.cmd.colorscheme("kanso-zen")
    end,
  },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      local black_metal = require("black-metal")

      black_metal.setup({
        theme = "gorgoroth",
        variant = "dark",
        term_colors = false,
        plain_float = true,
        transparent = false,
        code_style = {
          comments = "italic",
          conditionals = "none",
          functions = "bold",
          keywords = "italic",
          headings = "bold", -- Markdown headings
          operators = "none",
          keyword_return = "bold",
          strings = "none",
          variables = "none",
        },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = false,
        },
        colors = {
          -- bg = "#080808",
          bg = "#111111",
          property = "#778383",
          alt = "#6b8484",
          string = "#727a6e",
          diag_red = "#6e4c4c",
          diag_yellow = "#CFAA7E",
          diag_green = "#76946A",
        },
        highlights = {
          ["@function"] = { fg = "$type" },
          LineNrAbove = { fg = "$comment" },
          LineNrBelow = { fg = "$comment" },
          LineNr = { fg = "$fg" },
          Search = { fg = "$visual", bg = "$fg", fmt = "bold" },
          IncSearch = { fg = "$bg", bg = "$fg" },
          CurSearch = { fg = "$fg", bg = "$visual", fmt = "bold" },
          PmenuSel = { fg = "$fg", bg = "$visual", fmt = "bold" },
          Visual = { fg = "$fg", bg = "$visual" },
          ["@punctuation.delimiter"] = { fg = "$keyword" }, -- delimiters, like `; . , `
          ["@punctuation.bracket"] = { fg = "$keyword" }, -- brackets and parentheses

          -- plugins
          SnacksPickerListCursorLine = { fg = "$fg", bg = "$visual", fmt = "bold" },
          SnacksPickerMatch = { fg = "$visual", bg = "$fg", fmt = "bold,underline" },
        },
      })

      black_metal.load()
    end,
  },
}
