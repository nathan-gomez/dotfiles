local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local snippet = ls.snippet
local insert_node = ls.insert_node

return {
  snippet(
    { trig = "region", snippetType = "snippet", desc = "Region header", wordTrig = true },
    fmt(
      [[
        //------------------------------------
        // region {}
        //------------------------------------
        {}
      ]],
      {
        insert_node(1, "region"),
        insert_node(0),
      }
    )
  ),
}
