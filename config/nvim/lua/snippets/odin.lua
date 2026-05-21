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
    },
    fmt("package {}", {
      insert_node(1, "main"),
    })
  ),
  snippet(
    {
      trig = "proc",
      snippetType = "snippet",
      desc = "Proc snippet",
    },
    fmt_angle(
      [[
        <> :: proc() {

        }
      ]],
      { insert_node(1) }
    )
  ),
  snippet(
    {
      trig = "struct",
      snippetType = "snippet",
      desc = "Struct snippet",
    },
    fmt_angle(
      [[
        <> :: struct {

        }
      ]],
      { insert_node(1) }
    )
  ),
  snippet(
    {
      trig = "region",
      snippetType = "snippet",
      desc = "Region",
    },
    fmt(
      [[
      //------------------------------------
      // {}
      //------------------------------------
      ]],
      { insert_node(0) }
    )
  ),
}
