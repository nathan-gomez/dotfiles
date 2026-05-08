local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmt_angle = ls.extend_decorator.apply(fmt, { delimiters = "<>" })
local snippet = ls.snippet
local insert_node = ls.insert_node

return {
  snippet(
    { trig = "iferr", snippetType = "snippet", desc = "If error not nil", wordTrig = true },
    fmt_angle(
      [[
        if err != nil {
          return err<>
        }
      ]],
      {
        insert_node(0),
      }
    )
  ),
}
