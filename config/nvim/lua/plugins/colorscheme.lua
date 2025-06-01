return {
  {
    "yardnsm/nvim-base46",
    lazy = false,
    priority = 1000,
    opts = function()
      -- vim.cmd.colorscheme("base46-nightlamp")
    end,
  },
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("vague").setup({
        transparent = false,
        colors = {
          -- bg = "#111112"
          bg = "#070708"
        }
      })

      vim.cmd.colorscheme("vague")
    end,
  },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   opts = function()
  --     vim.g.gruvbox_material_background = "medium"
  --     vim.g.gruvbox_material_foreground = "material"
  --     vim.g.gruvbox_material_enable_italic = 1
  --     vim.g.gruvbox_material_enable_bold = 1
  --     -- vim.g.gruvbox_material_transparent_background = 1
  --
  --     -- vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
  -- {
  --   "vague2k/vague.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = function()
  --     vim.cmd.colorscheme("vague")
  --   end,
  -- },
}
