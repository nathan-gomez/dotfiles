return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      wrap = false,
      multi_window = false,
    },
    label = {
      rainbow = { enabled = false },
    },
    modes = {
      char = {
        enabled = false,
      },
      treesitter = {
        label = {
          rainbow = { enabled = true, shade = 5 },
        },
      },
      treesitter_search = {
        label = {
          rainbow = { enabled = true, shade = 5 },
        },
        search = { multi_window = false, wrap = true, incremental = false },
        highlight = { backdrop = true },
      },
    },
  },
  keys = {
    {
      "<leader><leader>s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { max_length = 1, wrap = true } })
      end,
      desc = "Flash: Buffer",
    },
    {
      "<leader><leader>f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = { forward = true, max_length = 1 },
        })
      end,
      desc = "Flash: Forward",
    },
    {
      "<leader><leader>w",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { wrap = true } })
      end,
      desc = "Flash: Search Pattern",
    },
    {
      "<leader><leader>t",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash: Select Treesitter Node",
    },
    {
      "<leader><leader>T",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash: Treesitter Search Node",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Flash: Remote",
    },
  },
}
