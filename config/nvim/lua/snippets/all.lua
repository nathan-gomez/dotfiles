local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmt_angle = ls.extend_decorator.apply(fmt, { delimiters = "<>" })
local snippet = ls.snippet
local insert_node = ls.insert_node

-- NOTE: Currently not populating this table.
local M = {}

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

return M
