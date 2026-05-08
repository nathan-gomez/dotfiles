local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local snippet = ls.snippet
local insert_node = ls.insert_node

local todo_snippet = snippet(
  { trig = "todo", desc = "TODO annotation" },
  fmt("// TODO: {}", { insert_node(1, "todo") })
)
local target_filetypes = { "c", "cpp", "zig", "svelte", "go", "odin" }

for _, ft in ipairs(target_filetypes) do
  ls.add_snippets(ft, { todo_snippet })
end

ls.filetype_extend("javascript", { "typescript" })
ls.add_snippets("typescript", {
  snippet(
    {
      trig = "todo",
      snippetType = "snippet",
      desc = "TODO annotation",
      wordTrig = true,
    },
    fmt("// TODO: (fede) {}", {
      insert_node(1, "todo"),
    })
  ),
})
