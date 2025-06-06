return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        
        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.clang_format,
            },
            -- on_attach = function(client, bufnr)
            --     if client.supports_method("textDocument/formatting") then
            --         vim.api.nvim_clear_autocmds({
            --             group = augroup,
            --             buffer = bufnr,
            --         })
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             group = augroup,
            --             buffer = buf,
            --             callback = function()
            --                 vim.lsp.buf.format({ bufnr = bufnr })
            --             end,
            --         })
            --     end

            -- end,
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
}
