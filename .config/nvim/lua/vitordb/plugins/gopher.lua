return {
	"olexsmir/gopher.nvim",
	ft = "go", -- Ativa o plugin apenas para arquivos Go
	build = function()
		vim.cmd([[silent! GoInstallDeps]]) -- Instala as dependências Go automaticamente
	end,
	config = function(_, opts)
		-- Configura o plugin Gopher
		require("gopher").setup(opts)

		-- Adicione mapeamentos específicos para o Gopher
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true, desc = "Gopher" }

		-- Mapas personalizados (exemplo: adicionar GoTags, etc.)
		keymap.set("n", "<leader>ga", "<cmd>GoAddTags<CR>", vim.tbl_extend("keep", opts, { desc = "Add Go Tags" }))
		keymap.set(
			"n",
			"<leader>gr",
			"<cmd>GoRemoveTags<CR>",
			vim.tbl_extend("keep", opts, { desc = "Remove Go Tags" })
		)
		keymap.set("n", "<leader>gf", "<cmd>GoFillStruct<CR>", vim.tbl_extend("keep", opts, { desc = "Fill Struct" }))
		keymap.set(
			"n",
			"<leader>gi",
			"<cmd>GoImpl<CR>",
			vim.tbl_extend("keep", opts, { desc = "Generate Interface Implementation" })
		)
	end,
}
