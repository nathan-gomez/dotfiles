require "nvchad.mappings"

local map = vim.keymap.set

-- Disable mappings
-- local nomap = vim.keymap.del

map("n", ";", ":", { desc = "Enter command mode" })

--Replace all words under cursor
map(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace all words under cursor" }
)

--Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down" })

--Keep cursor in the middle
map("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- better indenting
map("v", "<", "<gv", { desc = "Indent line in" })
map("v", ">", ">gv", { desc = "Indent line out" })

--Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Exit terminal mode" })

-- nomap("i", "<C-k>")
