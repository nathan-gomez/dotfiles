local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.code_actions.gomodifytags,
	null_ls.builtins.diagnostics.golangci_lint,
}

null_ls.setup({ sources = sources })
