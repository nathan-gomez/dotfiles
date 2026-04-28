local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd("FileType", {
  pattern = { "c", "cpp", "zig" },
  callback = function()
    vim.opt_local.matchpairs:append("=:;")
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "c"
  end,
})


-- Set tralinig whitespaces
vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })

local function add_trailing_ws_match()
  if not vim.w.trailing_ws_match then
    vim.w.trailing_ws_match = vim.fn.matchadd("TrailingWhitespace", [[\s\+$]])
  end
end

local function del_trailing_ws_match()
  if vim.w.trailing_ws_match then
    pcall(vim.fn.matchdelete, vim.w.trailing_ws_match)
    vim.w.trailing_ws_match = nil
  end
end

autocmd({ "BufWinEnter", "WinNew" }, { pattern = "*", callback = add_trailing_ws_match })
autocmd("InsertEnter", { pattern = "*", callback = del_trailing_ws_match })
autocmd("InsertLeave", { pattern = "*", callback = add_trailing_ws_match })

----------------
-- User Commands
----------------

usercmd("DumpCmd", function()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event
  local submit_handler = function(value)
    if value == "" then
      return
    end

    local exec_result = vim.api.nvim_exec2(value, { output = true })
    if exec_result == nil or exec_result.output == "" then
      return
    end

    local lines = vim.split(exec_result.output, "\n")
    vim.api.nvim_put(lines, "l", false, false)
  end

  local popup_opts = {
    position = "50%",
    size = { width = 50 },
    border = {
      style = "single",
      text = {
        top = "[Enter Command]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local input = Input(popup_opts, {
    on_submit = submit_handler,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end, { desc = "Dump the Vim command output to current buffer" })

usercmd("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true, desc = "Format current buffer or visual selection" })
