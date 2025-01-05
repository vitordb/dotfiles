return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- UI para depuração
		"theHamsta/nvim-dap-virtual-text", -- Variáveis inline
		"nvim-neotest/nvim-nio", -- Dependência necessária para nvim-dap-ui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- Configuração do DAP UI
		dapui.setup()

		-- Configuração do texto virtual
		dap_virtual_text.setup()

		-- Abrir UI automaticamente
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Atalhos globais para depuração
		local keymap = vim.keymap
		keymap.set("n", "<F5>", function()
			dap.continue()
		end, { desc = "Start/Continue Debugging" })
		keymap.set("n", "<F10>", function()
			dap.step_over()
		end, { desc = "Step Over" })
		keymap.set("n", "<F11>", function()
			dap.step_into()
		end, { desc = "Step Into" })
		keymap.set("n", "<F12>", function()
			dap.step_out()
		end, { desc = "Step Out" })
		keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })
		keymap.set("n", "<Leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Set Conditional Breakpoint" })
		keymap.set("n", "<Leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "Set Log Point" })
		keymap.set("n", "<Leader>dr", function()
			dap.repl.open()
		end, { desc = "Open Debug REPL" })
		keymap.set("n", "<Leader>dl", function()
			dap.run_last()
		end, { desc = "Run Last Debugging Session" })
	end,
}
