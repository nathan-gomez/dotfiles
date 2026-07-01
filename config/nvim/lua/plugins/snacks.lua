-- stylua: ignore
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      exclude = { "node_modules" },
      layout = {
        preset = "telescope",
      },
      layouts = {
        telescope = {
          reverse = false,
          layout = {
            box = "horizontal",
            width = 0.9,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "input", height = 1, border = "single", title = "{title} {live} {flags}", title_pos = "center" },
              { win = "list", border = "single" },
            },
            { win = "preview", title = "{preview}", width = 0.67, border = "single" },
          },
        },
      },
    },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files({ show_empty = true, hidden = true, ignored = true }) end, desc = "[f]ind [f]iles" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[f]ind [b]uffers" },
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep Search" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "[f]ind [h]elp" },
    { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Show notifications" },

    -- Git
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "[g]it [f]ind Files" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[g]it [s]tatus" },

    -- Search
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "[s]earch current [b]uffer", mode = "n" },
    { "<leader>sb", function() Snacks.picker.lines({ pattern = require("utils").get_visual_selection() }) end, desc = "[s]earch current [b]uffer", mode = "x" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[s]earch open [b]uffers" },
    { "<leader>sw", function() Snacks.picker.grep({ search = vim.fn.expand("<cword>") }) end, desc = "[s]earch [w]ord", mode = "n" },
    { "<leader>sw", function() Snacks.picker.grep({ search = require("utils").get_visual_selection() }) end, desc = "[s]earch [w]ord", mode = "x" },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "[s]earch registers" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[s]earch [l]ocation list" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "[s]earch [m]arks" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[s]earch [q]uickfix list" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[s]earch [u]ndo history" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "[s]earch [j]umps" },

    { "<leader>cl", function() Snacks.picker.colorschemes() end, desc = "[c]olorschemes [l]ist" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "(LSP) [g]oto [d]efinition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "(LSP) [g]oto [D]eclaration" },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "(LSP) [d]ocument [s]ymbols" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "(LSP) [g]oto [r]eferences" },
    { "<F12>", function() Snacks.picker.lsp_references() end, nowait = true, desc = "(LSP) References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "(LSP) [g]oto [I]mplementation" },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "(LSP) [g]oto [t]ype definition" },

    -- Lazygit
    { "<leader>lg",  function() Snacks.lazygit() end, desc = "LazyGit" },
  },
}
