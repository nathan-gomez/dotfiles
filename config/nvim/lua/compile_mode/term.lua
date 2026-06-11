---@class compile_mode.Term
---@field output compile_mode.Output handling of the terminal output
---@field win_opts vim.api.keyset.win_config window config for the terminal
---@field shell string|string[] command jobstart spawns
---@field clear_cmd string shell command that clears the screen
---@field buf_name string name set on the terminal buffer
---@field buf integer? terminal buffer id, nil until created
---@field win integer? terminal window id, nil while hidden
---@field channel integer? jobstart channel id, nil until created
---@field last_emitted table<integer, string> 0-indexed line - last dispatched text
---@field term_keys compile_mode.Keymap[]
local term = {}

--- shell that will spawn the cmd
---@return string|string[]
local function resolve_shell()
  if vim.fn.has("win32") == 1 then
    local shell = vim.o.shell:lower()

    if shell:match("pwsh") or shell:match("powershell") then
      return { vim.o.shell, "-NoLogo" }
    end
  end

  return vim.o.shell
end

-- command that clears the terminal screen
---@return string
local function resolve_clear_cmd()
  return vim.fn.has("win32") == 1 and "cls" or "clear"
end

---@param opts compile_mode.Opts
function term:setup(opts)
  self.win_opts = opts.win_opts
  self.term_keys = opts.keys.term
  self.shell = resolve_shell()
  self.clear_cmd = resolve_clear_cmd()
  self.buf_name = "compile_mode_term"
  self.buf = nil
  self.win = nil
  self.channel = nil
  self.last_emitted = {}

  self.output = require("compile_mode.output")
  self.output:setup(opts)
end

--- Jump to the file of the diagnostic under the cursor, if any.
---@return boolean ok true if diagnostic file found
function term:goto_diagnostic()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostic = self.output.diagnostics[row - 1]

  if not diagnostic then
    return false
  end

  return self.output:goto_diagnostic(diagnostic, self.buf)
end

--- Move the buffer cursor to the next diagnostic, wrapping to the first.
function term:move_next_diagnostic()
  local lines = self.output:diagnostic_lines()
  if #lines == 0 then
    return
  end

  self:show()
  local cur = vim.api.nvim_win_get_cursor(self.win)[1] - 1
  for _, nr in ipairs(lines) do
    if nr  > cur then
      return self.output:move_to(self.win, nr, self.buf)
    end
  end

  self.output:move_to(self.win, lines[1], self.buf)
end

--- Move the terminal cursor to the previous diagnostic, wrapping to the last.
function term:move_prev_diagnostic()
  local lines = self.output:diagnostic_lines()
  if #lines == 0 then
    return
  end

  self:show()
  local cur = vim.api.nvim_win_get_cursor(self.win)[1] - 1
  for i = #lines, 1, -1 do
    if lines[i] < cur then
      return self.output:move_to(self.win, lines[i], self.buf)
    end
  end

  self.output:move_to(self.win, lines[#lines], self.buf)
end

--- Parse and highlight the buffer lines in the range that changed.
---@param buf integer buffer id
---@param first_line integer 0-indexed first changed line (inclusive)
---@param last_line integer 0-indexed line just past the last changed line (exclusive)
function term:on_lines_fn(buf, first_line, last_line)
  local lines = vim.api.nvim_buf_get_lines(buf, first_line, last_line, false)

  for i, line in ipairs(lines) do
    local linenr = (first_line + i) - 1

    -- parse only lines that changed
    if line ~= "" and self.last_emitted[linenr] ~= line then
      self.last_emitted[linenr] = line

      local diagnostic = self.output:parse_diagnostic(line, linenr)

      if diagnostic then
        self.output.hl:diagnostic_paint(diagnostic, self.buf, linenr)
      end
    end
  end
end

--- Attach a line parser to the buffer.
function term:attach_parser()
  assert(self.buf ~= nil)

  vim.api.nvim_buf_attach(self.buf, false, {
    on_lines = function(_, b, _, firstline, _, new_lastline)
      if not vim.api.nvim_buf_is_loaded(b) then
        return true
      end

      return self:on_lines_fn(b, firstline, new_lastline)
    end,
  })
end

--- Creates terminal buffer and job if missing
function term:ensure()
  if self.buf and vim.api.nvim_buf_is_loaded(self.buf) then
    return
  end

  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(self.buf, self.buf_name)

  self.last_emitted = {}
  self:attach_parser()

  self.channel = vim.api.nvim_buf_call(self.buf, function()
    return vim.fn.jobstart(self.shell, { term = true })
  end)

  vim.api.nvim_set_option_value("buflisted", false, { scope = "local", buf = self.buf })

  for _, keymap in ipairs(self.term_keys) do
    require("compile_mode.opts").set_key(keymap, self.buf)
  end
end

--- Make terminal window visible
function term:show()
  self:ensure()

  if not self.win or not vim.api.nvim_win_is_valid(self.win) then
    self.win = vim.api.nvim_open_win(self.buf, true, self.win_opts)

    -- hide the line-number gutter
    vim.api.nvim_set_option_value("number", false, { scope = "local", win = self.win })
    vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = self.win })
  end
end

--- Toggle terminal visibility
function term:toggle()
  if self.win and vim.api.nvim_win_is_valid(self.win) then
    vim.api.nvim_win_hide(self.win)
    self.win = nil
  else
    self:show()
  end
end

--- Send a command to the terminal, opening the buffer if closed
---@param cmd string The command to execute.
function term:exec_cmd(cmd)
  assert(cmd ~= nil)

  self.last_emitted = {}
  self:show()

  assert(self.buf ~= nil)
  self.output:clear(self.buf)

  -- reset cursor to the top of the buffer
  assert(self.win ~= nil)
  pcall(vim.api.nvim_win_set_cursor, self.win, { 1, 0 })

  -- \x15 clears any half-typed line; clear the screen, then run cmd (\r = enter).
  vim.api.nvim_chan_send(self.channel, "\x15" .. self.clear_cmd .. "\r")
  vim.api.nvim_chan_send(self.channel, cmd .. "\r")
end

return term
