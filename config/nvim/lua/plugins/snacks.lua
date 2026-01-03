-- stylua: ignore
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {},
    explorer = {},
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files({ show_empty = true, hidden = true, }) end, desc = "[f]ind [f]iles" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[f]ind [b]uffers" },
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep Search" },
    { "-", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[f]ind [c]onfig File" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>fp", function()
      Snacks.picker.projects({
        dev = { "P:\\", "W:\\", }, -- Win32
        projects = { "F:\\Fede\\Google Drive\\notes" }, -- Win32
        -- dev = { "~/dev"  }, -- Linux
        confirm = "load_session",
        recent = false,
      }) end,
    desc = "[f]ind [p]rojects" },

    -- Git
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "[g]it [f]ind Files" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[g]it [s]tatus" },
    { "<leader>gll", function() Snacks.picker.git_log() end, desc = "[g]it [l]og" },
    { "<leader>glf", function() Snacks.picker.git_log_file() end, desc = "[g]it [l]og current [f]ile" },

    -- Search
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "[s]earch current [b]uffer" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[s]earch open [b]uffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[s]earch [w]ord or selection", mode = { "n", "x" } },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "[s]earch registers" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[s]earch [l]ocation list" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "[s]earch [m]arks" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[s]earch [q]uickfix list" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[s]earch [u]ndo history" },

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
