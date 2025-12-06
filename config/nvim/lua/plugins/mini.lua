return {
  "echasnovski/mini.nvim",
  lazy = false,
  config = function()
    require("mini.pairs").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup({ symbol = "|" })
    require("mini.indentscope").gen_animation.none()
  end,
}
