local M = {}

function M.setup()
  local dap = require("dap")

  -- Go Adapter
  dap.adapters.delve = function(callback, config)
    if config.mode == "remote" and config.request == "attach" then
      callback({
        type = "server",
        host = config.host or "127.0.0.1",
        port = config.port or "38697",
      })
    else
      callback({
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
          detached = vim.fn.has("win32") == 0,
        },
      })
    end
  end

  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  -- Elixir Adapter
  local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
  if elixir_ls_debugger ~= "" then
    dap.adapters.mix_task = {
      type = "executable",
      command = elixir_ls_debugger,
    }

    dap.configurations.elixir = {
      {
        type = "mix_task",
        name = "phoenix server",
        task = "phx.server",
        request = "launch",
        projectDir = "${workspaceFolder}",
        exitAfterTaskReturns = false,
        debugAutoInterpretAllModules = false,
      },
    }
  end

  -- dap.adapters.mix_task = {
  --   type = "executable",
  --   command = "/path/to/elixir-ls/debug_adapter.sh", -- debug_adapter.bat for windows
  --   args = {},
  -- }
  -- dap.configurations.elixir = {
  --   {
  --     type = "mix_task",
  --     name = "mix test",
  --     task = "test",
  --     taskArgs = { "--trace" },
  --     request = "launch",
  --     startApps = true, -- for Phoenix projects
  --     projectDir = "${workspaceFolder}",
  --     requireFiles = {
  --       "test/**/test_helper.exs",
  --       "test/**/*_test.exs",
  --     },
  --   },
  -- }
end

return M
