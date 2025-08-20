vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.clipboard = unnamedplus -- use system clipboard
vim.o.termguicolors = true
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

	-- lspconfig and completions
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },  -- dep of luasnip
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- dep of luasnip
	{ src = "https://github.com/L3MON4D3/LuaSnip" },          -- used by cmp
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- passed into lspconfig
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- tmux-nav
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- lualine
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- lspconfig
local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls", "pyright", "clangd", "ruff" })
vim.lsp.config('pyright', {
	capabilities = default_capabilities,
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
	capabilities = default_capabilities,
	filetypes = { "cpp", "hpp", "c", "h" },
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
	init_options = {
		fallbackFlags = { '-std=c++17' },
	},
})
vim.lsp.config('gopls', {
	capabilities = default_capabilities
})
vim.lsp.config('rust_analyzer', {
	capabilities = default_capabilities
})

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
require("neo-tree").setup({
        filesystem = {
                follow_current_file = {
                        enabled = true,
                }
        }
})

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

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
