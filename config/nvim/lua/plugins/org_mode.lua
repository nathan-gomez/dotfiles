local org_dir = "F:/Fede/gdrive/orgfiles"

return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  keys = {
    {
      "<leader>od",
      function()
        vim.cmd.tabnew(org_dir)
        vim.cmd.tcd(org_dir)
      end,
      desc = "Open org directory",
    },
  },
  config = function()
    local theme_colors = require("kanso.colors").setup().palette

    require("orgmode").setup({
      org_agenda_files = org_dir .. "/**/*",
      org_default_notes_file = org_dir .. "/refile.org",
      org_todo_keywords = { "TODO(t)", "ACTIVE", "|", "DONE" },
      org_todo_keyword_faces = {
        TODO = ":foreground " .. theme_colors.red .. " :weight bold",
        ACTIVE = ":foreground " .. theme_colors.violet .. " :weight bold",
        DONE = ":foreground " .. theme_colors.green .. " :weight bold",
      },
    })
  end,
}
