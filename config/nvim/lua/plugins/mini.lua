local function indentscope_setup()
  require("mini.indentscope").setup({ symbol = "|" })

  -- disable in terminal buffers
  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

local function sessions_setup()
  local sessions = require("mini.sessions")
  local default_name = "Session.vim"
  sessions.setup({
    file = default_name,
  })

  -- Load local session upon start
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 then
        local session_file = vim.fn.getcwd() .. "/" .. default_name

        if vim.uv.fs_stat(session_file) then
          vim.schedule(function()
            sessions.read(default_name)
          end)
        end
      end
    end,
  })

  local function delete_session()
    local sessions_tbl = sessions.detected

    if vim.tbl_isempty(sessions_tbl) then
      vim.notify("No sessions found", vim.log.levels.WARN)
      return
    end

    local names = vim.tbl_map(function(s)
      return s.name
    end, sessions_tbl)
    vim.ui.select(vim.tbl_values(names), { prompt = "Delete session:" }, function(choice)
      if choice then
        sessions.delete(choice)
      end
    end)
  end

  vim.keymap.set("n", "<leader>qc", function()
    sessions.write(default_name)
  end, { desc = "Sessions: Write local" })
  vim.keymap.set("n", "<leader>ql", function()
    sessions.select()
  end, { desc = "Sessions: Select" })
  vim.keymap.set("n", "<leader>qd", delete_session, { desc = "Sessions: Delete" })
  vim.keymap.set("n", "<leader>qp", "<cmd>lua =vim.v.this_session<cr>", { desc = "Sessions: Print current session" })
end

local function pairs_setup()
  local pairs = require("mini.pairs")
  pairs.setup()

  pairs.unmap("i", '"', '""')
  pairs.unmap("i", "'", "''")
end

return {
  "nvim-mini/mini.nvim",
  lazy = false,
  config = function()
    require("mini.cursorword").setup()
    require("mini.surround").setup({
      mappings = {
        add = "<leader>sa", -- Add surrounding in Normal and Visual modes
        delete = "<leader>sd", -- Delete surrounding
        find = "<leader>sf", -- Find surrounding (to the right)
        find_left = "<leader>sF", -- Find surrounding (to the left)
        highlight = "<leader>sh", -- Highlight surrounding
        replace = "<leader>sr", -- Replace surrounding
      },
    })
    require("mini.align").setup()
    pairs_setup()
    indentscope_setup()
    sessions_setup()
  end,
}
