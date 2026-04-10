return {
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    config = function()
      local markview = require("markview")
      local presets = require("markview.presets")

      vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Markdown: split view" })
      vim.keymap.set("n", "<leader>mt", "<cmd>Markview<cr>", { desc = "Markdown: toggle view" })

      markview.setup({
        preview = {
          icon_provider = "devicons",
        },
        markdown = {
          headings = presets.headings.glow,
          horizontal_rules = presets.thick,
          code_blocks = {
            label_direction = "left",
          },
        },
      })
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    cmd = { "Obsidian" },
    version = "*", -- use latest release, remove to use latest commit
    keys = {
      {
        "<leader>oo",
        "<cmd>Obsidian open<CR>",
        desc = "Obsidian: Open Note",
      },
      {
        "<leader>ob",
        "<cmd>Obsidian backlinks<CR>",
        desc = "Obsidian: Backlinks",
      },
      {
        "<leader>ol",
        "<cmd>Obsidian links<CR>",
        desc = "Obsidian: Links",
      },
      {
        "<leader>oq",
        "<cmd>Obsidian quick_switch<CR>",
        desc = "Obsidian: Quick Switch",
      },
      {
        "<leader>ot",
        "<cmd>Obsidian tags<CR>",
        desc = "Obsidian: Tags",
      },
    },
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      picker = {
        name = "snacks.pick",
      },
      link = {
        style = "markdown",
      },
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "personal",
          path = "F:\\Fede\\gdrive\\notes",
        },
        {
          name = "work",
          path = "F:\\Work\\OneDrive - Certiverse\\Documents\\dev\\notes_work",
          overrides = {
            frontmatter = { enabled = false },
          },
        },
      },
    },
  },
}
