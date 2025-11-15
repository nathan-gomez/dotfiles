vim.g.mapleader = " "

local map = vim.keymap.set

map("n", ";", ":", { desc = "Enter command mode" })

--Copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })

-- Replace all words under cursor
map(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace all words under cursor" }
)

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down" })

-- Keep cursor in the middle
map("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better indenting
map("v", "<", "<gv", { desc = "Indent line in" })
map("v", ">", ">gv", { desc = "Indent line out" })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Exit terminal mode" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<C-Left>", ":vertical resize -5<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { noremap = true, silent = true, desc = "Increase window width" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { noremap = true, silent = true, desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { noremap = true, silent = true, desc = "Close tab" })
map("n", "<leader>tj", "<cmd>tabnext<cr>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<C-PageDown>", "<cmd>tabnext<cr>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<leader>tk", "<cmd>tabprevious<cr>", { noremap = true, silent = true, desc = "Prev tab" })
map("n", "<C-PageUp>", "<cmd>tabprevious<cr>", { noremap = true, silent = true, desc = "Prev tab" })

-- Open terminal
map("n", "<leader>te", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
end, { desc = "Open vertical terminal" })

map("n", "<leader>th", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end, { desc = "Open horizontal terminal" })

-- Confrom Format

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

map({ "n", "v", "x" }, "<leader>fo", "<Cmd>Format<cr>", { desc = "Format file" })

-----------------

-- Oil

map("n", "<leader>fe", "<cmd>Oil<cr>", { desc = "Open parent directory" })

------
