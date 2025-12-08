return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function()
    local gitsigns = require("gitsigns")
    local map = vim.keymap.set

    local on_attach = function(bufnr)
      map("n", "<leader>gbb", gitsigns.blame, { noremap = true, desc = "[g]it [b]lame" })
      map("n", "<leader>glh", function()
        gitsigns.toggle_numhl()
        gitsigns.toggle_linehl()
      end, { noremap = true, desc = "[g]it [l]ine [h]ighlight" })

      -- Diffing
      map("n", "<leader>gd", gitsigns.diffthis, { noremap = true, desc = "[g]it [d]iff against the index" })
      map("n", "<leader>gwd", gitsigns.toggle_word_diff, { noremap = true, desc = "[g]it [w]ord [d]iff" })

      map("n", "<leader>gbs", gitsigns.stage_buffer, { noremap = true, desc = "[g]it [b]uffer [s]tage" })

      -- Chunks
      map({ "n", "v", "x" }, "<leader>gcs", gitsigns.stage_hunk, { noremap = true, desc = "[g]it [c]hunk [s]tage" })
      map("n", "<leader>gcp", gitsigns.preview_hunk_inline, { noremap = true, desc = "[g]it [c]hunk [p]review" })
      map("n", "<leader>gcr", gitsigns.reset_hunk, { noremap = true, desc = "[g]it [c]hunk [r]reset" })

      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Git Next Change" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Git Previous Change" })
    end

    gitsigns.setup({
      numhl = false,
      linehl = false,
      on_attach = on_attach,
      signs = {
        add = { text = "" },
        change = { text = "󰜥" },
        topdelete = { text = "‾" },
        delete = { text = "" },
        changedelete = { text = "󱕖" },
      },
    })
  end,
}
