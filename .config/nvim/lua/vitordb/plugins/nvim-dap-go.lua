return {
	"leoluz/nvim-dap-go",
	dependencies = {
		"mfussenegger/nvim-dap", -- nvim-dap é obrigatório
	},
	config = function()
		local dapgo = require("dap-go")

		-- Configurar nvim-dap-go
		dapgo.setup()

		-- Atalhos específicos para depuração Go (opcional, se quiser adicionar mais)
		local keymap = vim.keymap
		keymap.set("n", "<Leader>dt", function()
			dapgo.debug_test()
		end, { desc = "Debug Test" })
		keymap.set("n", "<Leader>dl", function()
			dapgo.debug_last()
		end, { desc = "Debug Last Test" })
	end,
}
