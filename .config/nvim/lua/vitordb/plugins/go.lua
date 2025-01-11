return {
	"ray-x/go.nvim",
	dependencies = { -- Dependências opcionais
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function(_, opts)
		-- Configura o plugin Go.nvim
		require("go").setup(opts)

		-- Adicione mapeamentos específicos para Go.nvim
		local keymap = vim.keymap
		local map_opts = { noremap = true, silent = true, desc = "Go.nvim" }

		-- Mapas personalizados para Go.nvim
		keymap.set(
			"n",
			"<leader>gd",
			"<cmd>GoDoc<CR>",
			vim.tbl_extend("keep", map_opts, { desc = "Go to Documentation" })
		)
		keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", vim.tbl_extend("keep", map_opts, { desc = "Run Go Tests" }))
		keymap.set(
			"n",
			"<leader>gb",
			"<cmd>GoBuild<CR>",
			vim.tbl_extend("keep", map_opts, { desc = "Build Go Project" })
		)

		-- Mapear <leader>gr para rodar o arquivo atual
		keymap.set("n", "<leader>gr", function()
			local file_path = vim.fn.expand("%:p") -- Obtém o caminho completo do arquivo atual
			vim.cmd("GoRun " .. file_path) -- Executa o comando GoRun com o caminho do arquivo
		end, vim.tbl_extend("keep", map_opts, { desc = "Run Current Go File" }))
	end,
	event = { "CmdlineEnter" }, -- Carregar quando o modo Cmdline for ativado
	ft = { "go", "gomod" }, -- Carregar apenas para arquivos Go
	build = ':lua require("go.install").update_all_sync()', -- Atualizar binários Go automaticamente
}
