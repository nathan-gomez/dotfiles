local M = {}

function M.get_visual_selection()
  local mode = vim.fn.mode()
  local start_pos, end_pos

  if mode == "v" or mode == "V" or mode == "\22" then
    start_pos = vim.fn.getpos("v")
    end_pos = vim.fn.getpos(".")
    if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
      start_pos, end_pos = end_pos, start_pos
    end
  else
    start_pos = vim.fn.getpos("'<")
    end_pos = vim.fn.getpos("'>")
  end

  local ls, cs = start_pos[2], start_pos[3]
  local le, ce = end_pos[2], end_pos[3]
  local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)

  if #lines == 0 then
    return ""
  end

  local last = lines[#lines]
  ce = math.min(ce, #last)
  if #lines == 1 then
    return lines[1]:sub(cs, ce)
  end
  lines[1] = lines[1]:sub(cs)
  lines[#lines] = last:sub(1, ce)
  return table.concat(lines, " ")
end

return M
