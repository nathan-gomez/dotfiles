return {
  "easymotion/vim-easymotion",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local autocmd = vim.api.nvim_create_autocmd

    autocmd("User", {
      pattern = "EasyMotionPromptBegin",
      callback = function()
        vim.diagnostic.disable(0)
      end,
    })

    autocmd("User", {
      pattern = "EasyMotionPromptEnd",
      callback = function()
        vim.diagnostic.enable()
      end,
    })
    return {}
  end,
}
