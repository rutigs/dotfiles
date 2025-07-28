vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.clipboard = unnamedplus -- use system clipboard
vim.o.winborder = "rounded"

vim.o.smartindent = true -- smart auto indenting
vim.o.autoindent = true  -- copy indent from current line

-- save undodir via file even after closing
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },

	-- neo-tree and deps
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },

	-- telescope and deps
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- lspconfig
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- tmux-nav
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- lualine
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- lspconfig
vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls", "pyright", "clangd", "ruff" })
vim.lsp.config('pyright', {
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Ignore all files for analysis to exclusively use Ruff for linting
				ignore = { "*" },
			},
		},
	},
})
vim.lsp.config('clangd', {
	filetypes = { "cpp", "hpp", "c", "h" },
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
	init_options = {
		fallbackFlags = { '-std=c++17' },
	},
})
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
vim.keymap.set('n', 'ge', ':lua vim.diagnostic.open_float() <CR>')
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- vague
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- neotree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {}) -- Ctrl-p to find files
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})  -- Ctrl-f to live grep / requires ripgrep
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
})
require("telescope").load_extension("ui-select")

-- treesitter
local treesitter_config = require("nvim-treesitter.configs")
treesitter_config.setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

-- vim-tmux-navigator
vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>')
vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>')
vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>')
vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>')

-- lualine
require("lualine").setup({
	options = {
		theme = "auto"
	}
})
