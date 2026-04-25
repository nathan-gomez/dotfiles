return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  main = "nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSInstallInfo", "TSInstall" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        if not pcall(vim.treesitter.start) then
          return
        end
      end,
    })

    local ok, treesitter_config = pcall(require, "nvim-treesitter.config")
    if not ok then
      return
    end

    local ensureInstalled = {
      "go",
      "cpp",
      "zig",
      "bash",
      "make",
      "typescript",
      "css",
      "html",
    }
    local alreadyInstalled = treesitter_config.get_installed()

    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()

    require("nvim-treesitter").install(parsersToInstall)
  end,
}
