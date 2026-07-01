local detail_columns = true

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
    columns = {
      "icon",
      { "permissions", highlight = "OilPermissions" },
      { "size", highlight = "OilSize" },
      { "mtime", highlight = "OilMtime" },
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
            require("oil").set_columns({
              "icon",
              { "permissions", highlight = "OilPermissions" },
              { "size", highlight = "OilSize" },
              { "mtime", highlight = "OilMtime" },
            })
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
      ["rd"] = {
        callback = function()
          local prefills = { paths = require("oil").get_current_dir() }
          local grug_far = require("grug-far")

          if not grug_far.has_instance("explorer") then
            grug_far.open({
              instanceName = "explorer",
              prefills = prefills,
              staticTitle = "Explorer: Find and Replace",
            })
          else
            grug_far.get_instance("explorer"):open()
            grug_far.get_instance("explorer"):update_input_values(prefills, false)
          end
        end,
        desc = "Search in directory",
      },
    },
  },
}
