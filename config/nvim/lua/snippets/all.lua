local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmt_angle = ls.extend_decorator.apply(fmt, { delimiters = "<>" })
local snippet = ls.snippet
local insert_node = ls.insert_node

local todo_snippet = snippet({ trig = "todo", desc = "TODO annotation" }, fmt("// TODO: {}", { insert_node(1, "todo") }))
local target_filetypes = { "c", "cpp", "zig" }

for _, ft in ipairs(target_filetypes) do
    ls.add_snippets(ft, { todo_snippet })
end

ls.filetype_extend("cpp", { "c" })

ls.add_snippets("c", {
  snippet(
    {
      trig = "region",
      snippetType = "snippet",
      desc = "Region header",
      wordTrig = true,
    },
    fmt(
      [[
        //
        // region {}
        //
        {}
        ]],
      {
        insert_node(1, "region"),
        insert_node(0),
      }
    )
  ),
})

ls.add_snippets("zig", {
  snippet(
    {
      trig = "disc",
      snippetType = "snippet",
      desc = "Discard value",
      wordTrig = true,
    },
    fmt("_ = {};", {
      insert_node(1, "value"),
    })
  ),
  snippet(
    {
      trig = "dalloc",
      snippetType = "snippet",
      desc = "Debug allocator",
      wordTrig = true,
    },
    fmt_angle(
      [[
        var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
        const allocator = debug_allocator.allocator();
      ]],
      {}
    )
  ),
})

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
