return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local icons = require("icons")
    vim.keymap.set("n", "<leader>tt", "<Cmd>TodoTelescope<CR>")

    return {
      keywords = {
        FIX = { icon = icons.todoComments.Fix, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = icons.todoComments.Todo, color = "info" },
        HACK = { icon = icons.todoComments.Hack, color = "warning" },
        WARN = { icon = icons.todoComments.Warn, color = "warning", alt = { "WARNING", "XXX", "IMPORTANT" } },
        PERF = { icon = icons.todoComments.Perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = icons.todoComments.Note, color = "#10B981", alt = { "INFO" } },
        TEST = { icon = icons.todoComments.Test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        STUDY = { icon = icons.todoComments.Study, color = "hint", alt = { "RESEARCH" } },
        MARK = { icon = icons.todoComments.Mark, color = "error" },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
    }
  end,
}
