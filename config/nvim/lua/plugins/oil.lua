local detail_columns = false

function _G.get_oil_cwd_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)

  if dir and detail_columns then
    return "CWD " .. vim.fn.getcwd(vim.g.statusline_winid)
  else
    -- If there is no current directory (e.g. over ssh)
    return ""
  end
end

return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "malewicz1337/oil-git.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>fe",
      "<cmd>Oil<cr>",
      desc = "Oil: File Explorer",
    },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      winbar = "%!v:lua.get_oil_cwd_winbar()",
    },
    keymaps = {
      ["<C-s>"] = {
        desc = "Save changes",
        callback = function()
          vim.cmd("w")
        end,
        mode = "n",
      },
      ["<C-p>"] = "actions.preview",
      ["<C-y>"] = "actions.yank_entry",
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail_columns = not detail_columns
          if detail_columns then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["<leader>:"] = {
        "actions.open_cmdline",
        opts = {
          shorten_path = true,
          modify = ":h",
        },
        desc = "Open the command line with the current directory as an argument",
      },
    },
  },
}
