---@class compile_mode.Keymap
---@field [1] string|string[] lhs — key sequence to bind
---@field [2] string|function rhs — command string or callback
---@field mode? string|string[] mode(s) for the mapping
---@field desc? string description

---@class compile_mode.Keys
---@field global compile_mode.Keymap[] mappings set globally on setup
---@field term compile_mode.Keymap[] mappings local to the compile terminal buffer

---@alias compile_mode.Severity "error" | "warning" | "info"

--- handles the parsing of the severity tag normally found in compiler outputs
---@param line string
---@return compile_mode.Severity
local function default_severity_scan(line)
  local line_l = line:lower()

  if line_l:match("error%s*:") then
    return "error"
  end

  if line_l:match("warning%s*:") then
    return "warning"
  end

  return "info"
end

---@class compile_mode.Opts
---@field win_opts vim.api.keyset.win_config window config for the compile terminal
---@field keys compile_mode.Keys keymaps
---@field rules compile_mode.MatchRule[]
local opts = {
  win_opts = { split = "below", height = 15, win = -1 },
  rules = {
    {
      name = "c",
      pattern = "^%s*(..-):(%d+):(%d+):",
      severity = default_severity_scan,
    },
    {
      name = "odin",
      pattern = "^%s*(..-)%((%d+):(%d+)%)",
      severity = default_severity_scan,
    },
    {
      name = "grep",
      pattern = "^%s*(..-):(%d+):",
      severity = nil,
    },
  },
  keys = {
    global = {
      {
       "<leader>cc",
       function() require("compile_mode").compile() end,
       mode = { "n", "v" },
       desc = "Compile mode",
      },
      {
        "<leader>co",
        function() require("compile_mode").term:toggle() end,
        mode = { "n", "v" },
        desc = "Toggle compile terminal",
      },
    },
    term = {
      {
        "q",
        function() require("compile_mode").term:toggle() end,
        mode = { "n", "v" },
        desc = "Hide compile terminal",
      },
      {
        "<cr>",
        function() require("compile_mode").term:goto_diagnostic() end,
        mode = "n",
        desc = "Go to diagnostic under cursor",
      },
      {
        "o",
        function()
          local compile_mode = require("compile_mode")

          if compile_mode.term:goto_diagnostic() then
            compile_mode.term:toggle()
          end
        end,
        mode = "n",
        desc = "Go to diagnostic under cursor and close the terminal",
      },
      {
        { "<S-Tab>", "<c-p>" },
        function() require("compile_mode").term:move_prev_diagnostic() end,
        mode = "n",
        desc = "Go to prev diagnostic",
      },
      {
        { "<Tab>", "<c-n>" },
        function() require("compile_mode").term:move_next_diagnostic() end,
        mode = "n",
        desc = "Go to next diagnostic",
      },
    },
  },
}

---@param keymap compile_mode.Keymap
---@param bufnr? integer buffer id to attach the keybinding
function opts.set_key(keymap, bufnr)
  local lhs = keymap[1]
  local rhs = keymap[2]
  local mode = keymap.mode or "n"

  ---@type vim.keymap.set.Opts
  local key_opts = {
    desc = keymap.desc,
    silent = true,
    buf = bufnr or nil
  }

  if type(lhs) == "table" then
    for _, val in ipairs(lhs) do
      vim.keymap.set(mode, val, rhs, key_opts)
    end
  else
    vim.keymap.set(mode, lhs, rhs, key_opts)
  end
end

return opts
