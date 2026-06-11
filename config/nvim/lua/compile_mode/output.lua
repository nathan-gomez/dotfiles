---@class compile_mode.HlPos
---@field start_col integer 0-indexed byte col
---@field end_col integer 0-indexed byte col (exclusive)
---@field group_name string highlight group name

---@class compile_mode.Diagnostic
---@field filename string parsed file path
---@field row integer 1-indexed line
---@field col integer 1-indexed column; defaults to 1
---@field hl_list compile_mode.HlPos[] list of hl to apply

---@class compile_mode.MatchRule
---@field name string identifier for the rule
---@field pattern string Lua pattern capturing file, row, col in that order
---@field severity? fun(line: string): compile_mode.Severity per-rule severity classifier

---@class compile_mode.Output
---@field hl compile_mode.Highlight
---@field rules compile_mode.MatchRule[] lua patterns to test the buffer content, tried in order
---@field diagnostics table<integer, compile_mode.Diagnostic> 0-indexed buf line -> diagnostic
local output = {}

--- Resolve a captured filename to an existing file path, or nil if none exists.
---@param filename string
---@return string? path absolute/relative path to an existing file, or nil
local function resolve_file(filename)
  if vim.uv.fs_stat(filename) then
    return filename
  end

  return vim.fs.find(filename)[1]
end

---@param opts compile_mode.Opts
function output:setup(opts)
  self.diagnostics = {}
  self.rules = opts.rules

  self.hl = require("compile_mode.hl")
  self.hl:setup()
end

--- Parse a single buffer line against the rule set. On the first matching rule
--- the result is stored in `output.diagnostics` keyed by `linenr` and returned.
---@param line string raw line
---@param linenr integer 0-indexed buffer line
---@return compile_mode.Diagnostic? diagnostic the parsed diagnostic, or nil when no rule matched
function output:parse_diagnostic(line, linenr)
  for _, rule in ipairs(self.rules) do
    local file, row, col = line:match(rule.pattern)

    if file and resolve_file(file) then
      -- file pos
      local file_s, file_e = line:find(file, 1, true)
      assert(file_s ~= nil)
      assert(file_e ~= nil)

      self.diagnostics[linenr] = {
        filename = file,
        row = tonumber(row) or -1,
        col = tonumber(col) or 1,
        hl_list = {},
      }

      local default_hl = self.hl.hl_groups.info
      assert(default_hl ~= nil)

      ---@type compile_mode.HlPos
      local file_hl = {
        start_col = file_s - 1,
        end_col = file_e,
        group_name = default_hl,
      }

      if rule.severity then
        file_hl.group_name = self.hl.hl_groups[rule.severity(line)]
        assert(file_hl.group_name ~= nil)
      end

      table.insert(self.diagnostics[linenr].hl_list, file_hl)

      local search_from = file_e + 1
      local pos_hl_group = self.hl.hl_groups.pos
      assert(pos_hl_group ~= nil)

      if row then
        -- row pos
        local row_s, row_e = line:find(row, search_from, true)
        assert(row_s ~= nil)
        assert(row_e ~= nil)

        ---@type compile_mode.HlPos
        local row_hl = {
          start_col = row_s - 1,
          end_col = row_e,
          group_name = pos_hl_group,
        }

        table.insert(self.diagnostics[linenr].hl_list, row_hl)
        search_from = row_e + 1
      end

      if col then
        -- col pos
        local col_s, col_e = line:find(col, search_from, true)
        assert(col_s ~= nil)
        assert(col_e ~= nil)

        ---@type compile_mode.HlPos
        local col_hl = {
          start_col = col_s - 1,
          end_col = col_e,
          group_name = pos_hl_group,
        }

        table.insert(self.diagnostics[linenr].hl_list, col_hl)
      end

      return self.diagnostics[linenr]
    end
  end

  return nil
end

--- Clear all parsed diagnostics and their highlights from `bufnr`
---@param bufnr integer buffer id
function output:clear(bufnr)
  self.diagnostics = {}
  self.hl:clear_all(bufnr)
end

--- Open the file ref by the diagnostic
---@param diagnostic compile_mode.Diagnostic
---@param bufnr integer buffer id
---@return boolean ok true if diagnostic file found
function output:goto_diagnostic(diagnostic, bufnr)
  assert(diagnostic ~= nil)

  local filename = diagnostic.filename
  local file = resolve_file(filename)

  if not file then
    vim.notify("File not found: " .. filename, vim.log.levels.WARN)
    return false
  end

  local wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == ""
  end, vim.api.nvim_tabpage_list_wins(0))

  if #wins == 1 then
    vim.cmd("aboveleft split")
  elseif #wins > 1 then
    local curr_win = vim.api.nvim_get_current_win()

    for _, win in ipairs(wins) do
      if win ~= curr_win then
        vim.api.nvim_set_current_win(win)
        break
      end
    end
  end

  vim.cmd("edit " .. vim.fn.fnameescape(file))

  local ok = pcall(vim.api.nvim_win_set_cursor, 0, { diagnostic.row, (diagnostic.col - 1) })
  if ok then
    self.hl:hover_clear(bufnr)
  end

  return true
end

--- move the cursor to the diagnostic in linenr
---@param win integer window id
---@param linenr integer 0-indexed buf line
---@param bufnr integer 0-indexed buf line
function output:move_to(win, linenr, bufnr)
  local diagnostic = self.diagnostics[linenr]
  assert(diagnostic ~= nil)

  if #diagnostic.hl_list == 0 then
    return
  end

  self.hl:hover_clear(bufnr)
  local pos = diagnostic.hl_list[1]

  local ok = pcall(vim.api.nvim_win_set_cursor, win, { linenr + 1, pos.start_col })
  if ok then
    self.hl:hover_paint(bufnr, linenr, pos.start_col, pos.end_col)
  end
end

--- 0-indexed buf lines that hold a diagnostic, sorted asc
---@return integer[]
function output:diagnostic_lines()
  local lines = vim.tbl_keys(self.diagnostics)
  table.sort(lines)
  return lines
end

return output
