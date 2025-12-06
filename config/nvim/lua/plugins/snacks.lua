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
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>fp", function()
      Snacks.picker.projects({
        dev = { "P:\\", "W:\\"  }, -- Win32
        -- dev = { "~/dev"  }, -- Linux
        confirm = "load_session",
        recent = false,
      }) end,
    desc = "Projects" },

    -- Git
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gll", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>glf", function() Snacks.picker.git_log_file() end, desc = "Git Log Current File" },

    -- Search
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Search Current Buffer" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- Lists
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>cl", function() Snacks.picker.colorschemes() end, desc = "Colorschemes List" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP Goto Declaration" },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "LSP Document Symbols" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP References" },
    { "<F12>", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP Goto T[y]pe Definition" },

    -- Lazygit
    { "<leader>lg",  function() Snacks.lazygit() end, desc = "LazyGit" },
  },
}
