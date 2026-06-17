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

function M.append_current_to_loclist()
  local bufnr    = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local cursor   = vim.api.nvim_win_get_cursor(0)
  local line_num = cursor[1]
  local col_num  = cursor[2] + 1

  vim.fn.setloclist(0, {}, "a", {
    items = {
      { filename = filename, lnum = line_num, col = col_num, text = vim.fn.bufname(bufnr) },
    },
  })
end

---@param filepath string
---@param expand? boolean
function M.goto_file(filepath, expand)
  local filename = filepath

  if expand then
    filename = vim.fn.expand(filepath)
  end

  local file

  if vim.uv.fs_stat(filename) then
    file = filename
  else
    file = vim.fs.find(filename)[1]
  end

  if not file then
    vim.notify("File not found: " .. filename, vim.log.levels.WARN)
    return
  end

  local wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == ""
  end, vim.api.nvim_tabpage_list_wins(0))

  if #wins > 1 then
    local curr_win = vim.api.nvim_get_current_win()

    for _, win in ipairs(wins) do
      if win ~= curr_win then
        vim.api.nvim_set_current_win(win)
        break
      end
    end
  end

  vim.cmd("edit " .. vim.fn.fnameescape(file))
end

return M
