local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

local snippets = {}

ls.filetype_extend("cpp", { "c" })

ls.add_snippets("c", {
  s(
    {
      trig = "region",
      snippetType = "snippet",
      desc = "Region header",
      wordTrig = true,
    },
    fmt(
      [[
        //
        // {}
        //
        {}
        ]],
      {
        i(1, "region"),
        i(0),
      }
    )
  ),
})

return snippets
