-- stylua: ignore
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {},
    explorer = {},
    styles = {
      scratch = {
        width = 150,
        height = 40,
      }
    }
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files({ show_empty = true, hidden = true, }) end, desc = "Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "List Buffers" },
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep" },
    { "-", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

    -- Git
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

    -- Search
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Search Current Buffer" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- Lists
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>cl", function() Snacks.picker.colorschemes() end, desc = "Colorschemes List" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "(LSP) Document Symbols" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "<F12>", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },

    -- Scratch
    { "<leader>ss",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>sl",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- Lazygit
    { "<leader>lg",  function() Snacks.lazygit() end, desc = "LazyGit" },
  },
}
