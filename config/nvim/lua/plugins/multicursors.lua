return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set
    local mc = require("multicursor-nvim")

    local function splitVisualToCursors(col)
      local mode = vim.fn.mode()
      local at_start = col == "^"
      mc.action(function(ctx)
        ctx:forEachCursor(function(cursor) cursor:splitVisualLines() end)
        ctx:forEachCursor(function(cursor)
          cursor:feedkeys(
            (cursor:atVisualStart() ~= at_start and "o" or "") .. "<esc>" .. (mode ~= "\22" and col or ""),
            { keycodes = true }
          )
        end)
      end)
    end

    mc.setup()

    map({ "n", "x" }, "<c-n>", function() mc.matchAddCursor(1) end, { desc = "Add Cursor on next matching word" })
    map({ "n", "x" }, "<c-p>", function() mc.matchAddCursor(-1) end, { desc = "Add Cursor on prev matching word" })

    map({ "n", "x" }, "<c-M-n>", function() mc.matchSkipCursor(1) end, { desc = "Skip Cursor on next matching word" })
    map({ "n", "x" }, "<c-M-p>", function() mc.matchSkipCursor(-1) end, { desc = "Skip Cursor on prev matching word" })

    map({ "x" }, "<leader>I", function() splitVisualToCursors("^") end, { desc = "Add cursors at start of each line" })
    map({ "x" }, "<leader>A", function() splitVisualToCursors("$") end, { desc = "Add cursors at end of each line" })

    map({ "n", "x" }, "<leader><c-b>", mc.matchAllAddCursors, { desc = "Add cursors to matching selection/word" })
    map("n", "<leader>mA", mc.searchAllAddCursors, { desc = "Add cursors to search results in buffer" })
    map({ "n", "x" }, "<c-b>", mc.toggleCursor, { desc = "Toggle cursor mode" })

    map("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors" })
    map("x", "<leader>M", mc.matchCursors, { desc = "Match by regex" })
    map("x", "<leader>S", mc.splitCursors, { desc = "Split by regex" })
    map({ "n", "x" }, "<c-x>", mc.deleteCursor)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "x", "n" }, "<right>", mc.nextCursor)
      layerSet({ "x", "n" }, "<left>", mc.prevCursor)
      layerSet({ "x", "n" }, "<tab>", mc.nextCursor)
      layerSet({ "x", "n" }, "<s-tab>", mc.prevCursor)

      layerSet("x", "<leader>T", function() mc.transposeCursors(-1) end, { desc = "Transpose cursors backwards" })
      layerSet("x", "<leader>t", function() mc.transposeCursors(1) end, { desc = "Transpose cursors forwards" })

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<c-x>", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
