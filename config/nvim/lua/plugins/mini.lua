return {
  "nvim-mini/mini.nvim",
  lazy = false,
  config = function()
    require("mini.pairs").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup({ symbol = "|" })
    require("mini.indentscope").gen_animation.none()
    require("mini.surround").setup({
      mappings = {
        add = "<leader>sa", -- Add surrounding in Normal and Visual modes
        delete = "<leader>sd", -- Delete surrounding
        find = "<leader>sf", -- Find surrounding (to the right)
        find_left = "<leader>sF", -- Find surrounding (to the left)
        highlight = "<leader>sh", -- Highlight surrounding
        replace = "<leader>sr", -- Replace surrounding
      },
    })
  end,
}
