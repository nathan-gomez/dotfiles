local M = {}

---@class Span
---@field start_idx integer 1-indexed inclusive start byte
---@field end_idx integer 1-indexed inclusive end byte

local word_re = vim.regex([[\k\+]])

-- all word spans in a line, 1-indexed inclusive byte ranges
---@param line string
---@return Span[]
local function word_spans(line)
  ---@type Span[]
  local spans  = {}
  local offset = 0

  while offset < #line do
    local span_s, span_e = word_re:match_str(line:sub(offset + 1))

    if not span_s then
      break
    end

    table.insert(spans, { start_idx = offset + span_s + 1, end_idx = offset + span_e })
    offset = offset + span_e
  end

  return spans
end

---@param spans Span[]
---@param col0 integer cursor byte column, 0-based
---@return Span? w1
---@return Span? w2
local function pick(spans, col0)
  ---@type integer?
  local i1  = nil
  local pos = col0 + 1

  -- last span whose start is at/before point (inside-span or in trailing gap)
  for i, span in ipairs(spans) do
    if span.start_idx <= pos then
      i1 = i
    end
  end

  if not i1 then
    return nil
  end

  -- if it points at/after last span: swap the final two
  if i1 + 1 > #spans then
    i1 = i1 - 1
  end

  if i1 < 1 then
    return nil
  end

  return spans[i1], spans[i1 + 1]
end

-- swap two non-overlapping spans on the current line, preserving the text
-- between/around them; w1 must start before w2
---@param row integer
---@param line string
---@param w1 Span
---@param w2 Span
local function swap(row, line, w1, w2)
  local prefix = line:sub(1, w1.start_idx - 1)
  local a      = line:sub(w1.start_idx, w1.end_idx)
  local mid    = line:sub(w1.end_idx + 1, w2.start_idx - 1)
  local b      = line:sub(w2.start_idx, w2.end_idx)
  local suffix = line:sub(w2.end_idx + 1)

  line = prefix .. b .. mid .. a .. suffix
  local col = (#prefix + #b + #mid + #a) - 1

  vim.api.nvim_set_current_line(line)
  vim.api.nvim_win_set_cursor(0, { row, math.max(col, 0) })
end

-- swap the two spans pick() selects from spans_fn, preserving separators
---@param spans_fn fun(line: string): Span[]
local function transpose(spans_fn)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local w1, w2 = pick(spans_fn(line), col)

  if not w1 then
    return
  end

  assert(w2 ~= nil)

  swap(row, line, w1, w2)
end

function M.transpose_words()
  transpose(word_spans)
end

-- transpose the first match of each Lua pattern on the current line
---@param pat1 string Lua pattern for the first expression
---@param pat2 string Lua pattern for the second expression
function M.transpose_exprs(pat1, pat2)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  local s1, e1 = line:find(pat1)
  local s2, e2 = line:find(pat2)

  if not (s1 and s2) then
    vim.notify("both expressions must match", vim.log.levels.WARN)
    return
  end

  assert(e1 ~= nil)
  assert(e2 ~= nil)

  ---@type Span
  local w1 = { start_idx = s1, end_idx = e1 }
  ---@type Span
  local w2 = { start_idx = s2, end_idx = e2 }

  if w1.start_idx > w2.start_idx then
    w1, w2 = w2, w1
  end

  if w1.end_idx >= w2.start_idx then
    vim.notify("transpose: expressions overlap", vim.log.levels.WARN)
    return
  end

  swap(row, line, w1, w2)
end

-- prompt for two Lua patterns, then transpose their matches on the line
function M.transpose_exprs_prompt()
  vim.ui.input({ prompt = "Expr 1 (Lua pattern): " }, function(pat1)
    if not pat1 or pat1 == "" then
      return
    end
    vim.ui.input({ prompt = "Expr 2 (Lua pattern): " }, function(pat2)
      if not pat2 or pat2 == "" then
        return
      end
      M.transpose_exprs(pat1, pat2)
    end)
  end)
end

return M
