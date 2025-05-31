return {
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")
			local rule = require("nvim-autopairs.rule")

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" }, -- it will not add a pair on that treesitter node
					javascript = { "template_string" },
				},
			})

			local ts_conds = require("nvim-autopairs.ts-conds")

			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			-- 	local ok, autotag = pcall(require, "nvim-ts-autotag")
			--
			-- 	if not ok then
			-- 		return
			-- 	end
			--
			-- 	autotag.setup({})
			require("nvim-ts-autotag").setup()
		end,
	},
}
