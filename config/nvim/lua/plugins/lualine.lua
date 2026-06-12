local function multicursor_status()
  local ok, mc = pcall(require, "multicursor-nvim")
  if not ok then
    return ""
  end

  local count = mc.numEnabledCursors()
  if count <= 1 then
    return ""
  end

  return "MC: " .. count
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = function()
    local icons = require("icons")

    return {
      extensions = { "oil", "quickfix", "trouble" },
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "b:gitsigns_head",
            icon = icons.git.branch,
          },
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
            symbols = {
              modified = icons.file_status.modified, -- Text to show when the file is modified.
              readonly = icons.file_status.readonly, -- Text to show when the file is non-modifiable or readonly.
              unnamed = icons.file_status.unnamed, -- Text to show for unnamed buffers.
              newfile = icons.file_status.newfile, -- Text to show for newly created file before first write
            },
          },
        },
        lualine_c = {
          {
            multicursor_status,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = icons.diagnostics,
          },
          {
            "fileformat",
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
        },
        lualine_y = { "lsp_status", "filetype" },
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
