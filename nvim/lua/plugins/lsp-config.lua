return {
    {
        "williamboman/mason.nvim",
        config = function() 
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_install = { "bashls", "gopls", "pyright", "rust_analyzer", "tflint", "clangd"}, -- "lua_ls" },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            -- lspconfig.lua_ls.setup({})
            -- lspconfig.bashls.setup({
            --     capabilities = capabilities
            -- })
            lspconfig.gopls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities
            })
            -- lspconfig.tflint.setup({
            --     capabilities = capabilities
            -- })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        end
    }
}
