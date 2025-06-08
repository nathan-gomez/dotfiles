return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    {
      "jay-babu/mason-nvim-dap.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        ensure_installed = { "delve" },
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      lazy = false,
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle({})
          end,
          desc = "Dap UI",
        },
        {
          "<leader>dh",
          function()
            require("dap.ui.widgets").hover()
          end,
          desc = "Debugger Hover",
        },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local ui = require("dapui")
        ui.setup(opts)

        dap.listeners.before.attach.dapui_config = function()
          ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          ui.close()
        end
      end,
    },
  },

  keys = {
    {
      "<F9>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debugger: Run/Continue",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Debugger: Step Into",
    },
    {
      "<F23>", -- Shift+F11
      function()
        require("dap").step_out()
      end,
      desc = "Debugger: Step Out",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Debugger: Step Over",
    },
    {
      "<F17>", -- Shift+F5
      function()
        require("dap").terminate()
      end,
      desc = "Debugger: Terminate",
    },
    {
      "<leader>d=",
      function()
        require("dapui").eval(nil, { enter = true })
      end,
      desc = "Debugger: Evaluate Under Cursor",
    },
  },
  config = function()
    vim.fn.sign_define("DapBreakpoint", { text = "" })
    require("configs.dap").setup()
  end,
}
