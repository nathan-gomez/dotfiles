return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = {
    {
      "<leader>db",
      "<cmd>tabnew | DBUI<CR>",
      desc = "Open DB UI in new tab",
    },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      { name = "dev-postresdb", url = "postgres://admin:pMB&z87nze@srv-desa.nfg-tech.com:5432/postgres" },
      { name = "prod-postgresdb", url = "postgres://admin:5td$wM3pjUkj6i@srv-prod-2.nfg-tech.com:5432/postgres" },
    }
  end,
  config = function()
    local map = vim.keymap.set
    map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Open DB UI in new tab" })
  end,
}
