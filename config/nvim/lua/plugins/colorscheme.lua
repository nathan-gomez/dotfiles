return {
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   config = {
  --     compile = true,
  --     undercurl = true,
  --     commentStyle = { italic = true },
  --     functionStyle = {},
  --     keywordStyle = { italic = true },
  --     statementStyle = { bold = true },
  --     typeStyle = { bold = true },
  --     transparent = true,
  --     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --     colors = {
  --       palette = {},
  --       theme = {
  --         all = {
  --           ui = {
  --             bg_gutter = "none",
  --             float = { bg = "none" },
  --           },
  --         },
  --       },
  --     },
  --     overrides = function(colors)
  --       local theme = colors.theme
  --
  --       return {
  --         NormalFloat = { bg = "none" },
  --         FloatBorder = { bg = "none" },
  --         FloatTitle = { bg = "none" },
  --         NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --         LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --         MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --         Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
  --         PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  --         PmenuSbar = { bg = theme.ui.bg_m1 },
  --         PmenuThumb = { bg = theme.ui.bg_p2 },
  --       }
  --     end,
  --     theme = "dragon",
  --   },
  -- },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    config = function()
      require("kanso").setup({
        functionStyle = { bold = true },
        transparent = true,
        colors = {
          palette = {},
          theme = { zen = {}, pearl = {}, ink = {}, all = {} },
        },
        overrides = function(colors)
          return {
            CurSearch = { bg = colors.palette.zenBg1, fg = colors.palette.red },
            IncSearch = { bg = colors.palette.zenBg1, fg = colors.palette.red },
            Search = { bg = colors.palette.zenBg1, fg = colors.palette.blue },
          }
        end,
        foreground = "default", -- "default" or "saturated" (can also be a table like background)
      })

      vim.cmd.colorscheme("kanso-ink")
    end,
  },
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("vague").setup({
        transparent = true,
        colors = {
          bg = "#070708",
        },
        on_highlights = function(highlights, colors)
          highlights.CurSearch.fg = "#070708"
        end,
      })

      -- vim.cmd.colorscheme("vague")
    end,
  },
}
