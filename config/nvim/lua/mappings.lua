vim.g.mapleader = " "

local utils = require("utils")
local map = vim.keymap.set

-- Make Ctrl+c trigger InsertLeave
map("i", "<C-c>", "<Esc>", { desc = "Leave Insert mode" })

-- Clear highlight with Escape
map("n", "<Esc>", "<cmd>noh<cr>", { silent = true })

map("n", ";", ":", { desc = "Enter command mode" })

--Copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })

-- Replace all words under cursor
map(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[r]eplace [w]ord" }
)

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down", silent = true })

-- Keep cursor in the middle
map("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better indenting
map("v", "<", "<gv", { desc = "Indent line in", silent = true })
map("v", ">", ">gv", { desc = "Indent line out", silent = true })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Exit terminal mode" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<C-Left>", ":vertical resize -5<CR>", { silent = true, desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { silent = true, desc = "Increase window width" })
map("n", "<C-Up>", ":horizontal resize +5<CR>", { silent = true, desc = "Increase window height" })
map("n", "<C-Down>", ":horizontal resize -5<CR>", { silent = true, desc = "Decrease window height" })

map("n", "gf", function() utils.goto_file("<cfile>", true) end, { desc = "Open file under cursor" })
map("n", "<M-t>", require("transpose_words").transpose_words, { desc = "Transpose words" })
map("n", "<M-C-t>", require("transpose_words").transpose_exprs_prompt, { desc = "Transpose expressions" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true, desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })
map("n", "tj", "<cmd>tabnext<cr>", { silent = true, desc = "Next tab" })
map("n", "tk", "<cmd>tabprevious<cr>", { silent = true, desc = "Prev tab" })
map("n", "<C-PageDown>", "<cmd>tabnext<cr>", { silent = true, desc = "Next tab" })
map("n", "<C-PageUp>", "<cmd>tabprevious<cr>", { silent = true, desc = "Prev tab" })

-- Open terminal
map("n", "<leader>te", function()
  vim.cmd.tabnew()
  vim.cmd.term()
end, { desc = "Open terminal in new tab" })

map("n", "<leader>th", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end, { desc = "Open horizontal terminal" })

-- Quickfix list
map("n", "<leader>xq", function() vim.diagnostic.setqflist({ bufnr = 0 }) end, { silent = true, desc = "Buffer Diagnostics -> Quickfix" })
map("n", "<leader>xQ", function() vim.diagnostic.setqflist() end, { silent = true, desc = "Diagnostics -> Quickfix" })
map("n", "<leader>xc", function() vim.fn.setqflist({}, "r") end, { desc = "Clear Quickfix list" })

map("n", "<leader>xt", function()
  local config = vim.diagnostic.config() or {}
  local new_virtual_text = not config.virtual_text
  vim.diagnostic.config({ virtual_text = new_virtual_text })
  print("Virtual text: " .. (new_virtual_text and "ON" or "OFF"))
end, { desc = "Toggle diagnostics virtual text" })

-- Location list
map("n", "<leader>la", utils.append_current_to_loclist, { silent = true, desc = "Add line to Loc list" })
map("n", "<leader>lc", function() vim.fn.setloclist(0, {}, 'r') end, { desc = "Clear Loc list" })

-- Confrom Format
map({ "n", "v", "x" }, "<leader>fo", "<Cmd>Format<cr>", { desc = "Format file" })
