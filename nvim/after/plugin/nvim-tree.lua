local api = require("nvim-tree.api")

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  api.tree.focus()
end

local tree_actions = {
  {
    name = "Open in new tab",
    handler = require("nvim-tree.api").node.open.tab,
  },
  {
    name = "Create node",
    handler = require("nvim-tree.api").fs.create,
  },
  {
    name = "Remove node",
    handler = require("nvim-tree.api").fs.remove,
  },
  {
    name = "Trash node",
    handler = require("nvim-tree.api").fs.trash,
  },
  {
    name = "Rename node",
    handler = require("nvim-tree.api").fs.rename,
  },
  {
    name = "Fully rename node",
    handler = require("nvim-tree.api").fs.rename_sub,
  },
  {
    name = "Show node details",
    handler = require("nvim-tree.api").node.show_info_popup,
  },
  {
    name = "Copy node",
    handler = require("nvim-tree.api").fs.copy.node,
  },
  {
    name = "Paste node",
    handler = require("nvim-tree.api").fs.paste,
  },
  {
    name = "Cut node",
    handler = require("nvim-tree.api").fs.cut,
  },
}

local function tree_actions_menu(node)
  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name,
    }
  end

  local finder = require("telescope.finders").new_table({
    results = tree_actions,
    entry_maker = entry_maker,
  })

  local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

  local default_options = {
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require("telescope.actions")

      -- On item select
      actions.select_default:replace(function()
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        -- Closing the picker
        actions.close(prompt_buffer_number)
        -- Executing the callback
        selection.value.handler(node)
      end)
      return true
    end,
  }

  local current_buf = vim.fn.bufnr("%")
  local nvimtree_buf = vim.fn.bufnr("NvimTree")

  -- Opening the menu
  if current_buf == nvimtree_buf then
    require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
  end
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- copy default mappings here from defaults in next section
  api.config.mappings.default_on_attach(bufnr)

  -- add your mappings
  vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
  vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
  vim.keymap.set("n", "<C-Space>", tree_actions_menu, { buffer = buffer, noremap = true, silent = true })
end

require("nvim-tree").setup({
  on_attach = on_attach,
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false, -- Turn into false from true by default
  },
  filters = {
    dotfiles = false,
    exclude = {},
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
})

-- global
vim.api.nvim_set_keymap("n", "<leader>fe", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
