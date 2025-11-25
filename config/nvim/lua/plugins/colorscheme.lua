return {
  -- {
  --   "thesimonho/kanagawa-paper.nvim",
  --   lazy = false,
  --   init = function()
  --     vim.cmd.colorscheme("kanagawa-paper-ink")
  --   end,
  --   config = {
  --     undercurl = true,
  --     transparent = false,
  --     gutter = false,
  --     diag_background = true,
  --     dim_inactive = true,
  --     terminal_colors = true,
  --     cache = false,
  --     styles = {
  --       comment = { italic = true },
  --       functions = { italic = true },
  --       keyword = { italic = true, bold = true },
  --       statement = { italic = true, bold = true },
  --       type = { italic = true },
  --     },
  --   },
  -- },
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("vague").setup({
        transparent = false,
        colors = {
          bg = "#070708",
        },
        on_highlights = function(highlights, colors)
          print(highlights)
          highlights.CurSearch.fg = "#070708"
        end,
      })

      vim.cmd.colorscheme("vague")
    end,
  },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   opts = function()
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_foreground = "material"
  --     vim.g.gruvbox_material_enable_italic = 1
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_transparent_background = 1
  --
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
}
