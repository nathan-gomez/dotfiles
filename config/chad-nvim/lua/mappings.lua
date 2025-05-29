require "nvchad.mappings"

local map = vim.keymap.set

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

-- Telescope
local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fs", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
map("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Open file browser" })
map("n", "<leader>pws", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({ search = word })
end, { desc = "Search word" })

-- Format
map({ "n", "x" }, "<leader>fo", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<leader>fa")
nomap("n", "<leader>fw")
nomap("n", "<leader>fm")
nomap("n", "<leader>n")
-- nomap("n", "<leader>fo")
-- nomap("n", "<leader>e")
