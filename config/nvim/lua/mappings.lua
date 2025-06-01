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

-- Telescope

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fs", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
map("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true initial_mode=normal<CR>", { desc = "Open file browser" })
map("n", "<leader>fb", "<cmd>Telescope buffers initial_mode=normal<CR>", { desc = "Find buffers" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR> initial_mode=normal", { desc = "Find marks" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })

------------

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

map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

------

-- Lazygit

map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

----------
