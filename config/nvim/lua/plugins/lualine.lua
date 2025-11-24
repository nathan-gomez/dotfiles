return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = function()
    local icons = require("icons")

    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = "|",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            icon = icons.git.branch,
          },
          {
            "diff",
            symbols = icons.git,
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = icons.diagnostics,
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            symbols = {
              modified = "󰜥", -- Text to show when the file is modified.
              readonly = "", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "", -- Text to show for unnamed buffers.
              newfile = "", -- Text to show for newly created file before first write
            },
          },
        },
        lualine_x = {
          {
            -- Show @recording messages
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
