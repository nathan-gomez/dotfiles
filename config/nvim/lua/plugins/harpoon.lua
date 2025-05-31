return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,

  opts = function()
    local map = vim.keymap.set
    local conf = require("telescope.config").values
    local harpoon = require("harpoon")
    harpoon:setup()

    map("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add buffer to Harpoon list" })
    map("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Open Harpoon" })

    -- Quick select
    map("n", "<C-b>", function()
      harpoon:list():select(1)
    end)
    map("n", "<C-n>", function()
      harpoon:list():select(2)
    end)
    map("n", "<C-m>", function()
      harpoon:list():select(3)
    end)

    return {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    }
  end,
}
