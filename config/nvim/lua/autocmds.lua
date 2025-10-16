local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd("FileType", {
  pattern = { "c", "cpp", "zig" },
  callback = function()
    vim.opt_local.matchpairs:append("=:;")
  end,
})
