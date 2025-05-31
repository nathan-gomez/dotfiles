return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
