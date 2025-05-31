--Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--Line numbers / Relative lines
vim.opt.nu = true
vim.opt.relativenumber = true

--Tab width
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 100
vim.opt.linebreak = true
vim.opt.showmode = false

--Casing and spellchecking
vim.opt.ignorecase = true
vim.opt.smartcase = true
