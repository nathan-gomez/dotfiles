---@type NvPluginSpec
return {
  {
    "stevearc/conform.nvim",
    opts = function()
      require "configs.conform"
    end,
  }
}
