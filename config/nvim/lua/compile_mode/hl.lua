---@class compile_mode.Highlight
---@field hl_namespace integer
---@field hover_namespace integer
---@field hl_groups table<string, string>
local hl = {}

function hl:setup()
  self.hl_namespace = vim.api.nvim_create_namespace("compile_mode_hl")
  self.hover_namespace = vim.api.nvim_create_namespace("compile_mode_hover_hl")
  self.hl_groups = {
    error   = "CompileModeError",
    warning = "CompileModeWarn",
    info    = "CompileModeInfo",
    pos     = "CompileModePosition",
    hover   = "CompileModeHover",
  }

  vim.api.nvim_set_hl(0, self.hl_groups.error,   { link = "DiagnosticError", default = true })
  vim.api.nvim_set_hl(0, self.hl_groups.warning, { link = "DiagnosticWarn", default = true })
  vim.api.nvim_set_hl(0, self.hl_groups.info,    { link = "DiagnosticInfo", default = true })
  vim.api.nvim_set_hl(0, self.hl_groups.pos,     { link = "Constant", default = true })
  vim.api.nvim_set_hl(0, self.hl_groups.hover,   { link = "CurSearch", default = true })
end

---@param bufnr integer buffer id
---@param linenr integer 0-indexed buffer line
---@param start_col integer 0-indexed
---@param end_col integer 0-indexed
function hl:hover_paint(bufnr, linenr, start_col, end_col)
  local end_pos = end_col

  if start_col == end_col then
    end_pos = end_col + 1
  end

  vim.api.nvim_buf_set_extmark(bufnr, self.hover_namespace, linenr, start_col, {
    end_col = end_pos,
    hl_group = self.hl_groups.hover,
  })
end

---@param bufnr integer
function hl:hover_clear(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, self.hover_namespace, 0, -1)
end

---@param bufnr integer
function hl:clear_all(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, self.hl_namespace, 0, -1)
  self:hover_clear(bufnr)
end

---@param diagnostic compile_mode.Diagnostic diagnostic data
---@param bufnr integer buffer id
---@param linenr integer 0-indexed buffer line
function hl:diagnostic_paint(diagnostic, bufnr, linenr)
  assert(diagnostic ~= nil)

  for _, pos in ipairs(diagnostic.hl_list) do
    vim.api.nvim_buf_set_extmark(bufnr, self.hl_namespace, linenr, pos.start_col, {
      end_col = pos.end_col,
      hl_group = pos.group_name,
    })
  end
end

return hl
