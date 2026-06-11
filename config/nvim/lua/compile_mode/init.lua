---@class compile_mode
---@field term compile_mode.Term
---@field opts compile_mode.Opts
local M = {
  term = require("compile_mode.term"),
  opts = require("compile_mode.opts"),
}

-- TODO: pass working dir and/or environment for execution
-- BUG: resizing the terminal mess up the buffer and term data

function M.setup()
  M.term:setup(M.opts)

  for _, keymap in ipairs(M.opts.keys.global) do
    M.opts.set_key(keymap)
  end

  vim.api.nvim_create_user_command("CompileMode",
    function(opts)
      local args = table.concat(opts.fargs, " ")
      M.compile(args)
    end, { nargs = "+"})
end

---@param cmd? string The command to execute. When nil, the user is prompted
function M.compile(cmd)
  if not cmd then
    local ok, input = pcall(vim.fn.input, {
      prompt = "Compile command: ",
      completion = "shellcmdline",
    })

    if ok and input and input ~= "" then
      M.compile(input)
    end

    return
  end

  -- expand the command before executing
  local ok, expanded_cmd = pcall(vim.fn.expandcmd, cmd)
  local cmd_to_exec = ok and expanded_cmd or cmd

  M.term:exec_cmd(cmd_to_exec)
end

return M
