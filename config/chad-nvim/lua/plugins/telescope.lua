---@type NvPluginSpec
return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      require("telescope").load_extension("file_browser")
      local actions = require("telescope.actions")

      conf.defaults.mappings = {
        n = { ["q"] = actions.close },
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-l>"] = actions.select_default,
        },
      }
    end
  }
};
