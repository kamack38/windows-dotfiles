local M = {}
M.setup_lsp = function(attach, capabilities)
    local lspconfig = require "lspconfig"

    local servers = {"html", "cssls", }

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }
    end

    lspconfig.clangd.setup {
        -- cmd = { "clangd", "--background-index", "--stdlib=libc++" },
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        end
    }

    lspconfig.tsserver.setup {
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        end
    }
end

return M
