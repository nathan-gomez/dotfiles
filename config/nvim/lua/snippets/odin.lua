local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmt_angle = ls.extend_decorator.apply(fmt, { delimiters = "<>" })
local snippet = ls.snippet
local insert_node = ls.insert_node

return {
  snippet(
    {
      trig = "iferr",
      snippetType = "snippet",
      desc = "If error not nil",
      wordTrig = true,
    },
    fmt_angle(
      [[
        if err != nil {
          <>
        }
      ]],
      {
        insert_node(0),
      }
    )
  ),
  snippet(
    {
      trig = "disc",
      snippetType = "snippet",
      desc = "Discard value",
      wordTrig = true,
    },
    fmt("_ = {}", {
      insert_node(1, "value"),
    })
  ),
  snippet(
    {
      trig = "pack",
      snippetType = "snippet",
      desc = "Package line",
      wordTrig = true,
    },
    fmt("package {}", {
      insert_node(1, "main"),
    })
  ),
  snippet(
    {
      trig = "main",
      snippetType = "snippet",
      desc = "Main proc",
      wordTrig = true,
    },
    fmt_angle(
      [[
        main :: proc() {
          <>
        }
      ]],
      { insert_node(1) }
    )
  ),
}
