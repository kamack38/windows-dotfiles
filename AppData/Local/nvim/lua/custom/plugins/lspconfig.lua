local M = {}
M.setup_lsp = function(attach, capabilities)
    local lspconfig = require "lspconfig"
    local lsp_installer = require "nvim-lsp-installer"
    
    lsp_installer.settings {
      ui = {
         icons = {
            server_installed = "﫟" ,
            server_pending = "",
            server_uninstalled = "✗",
         },
      },
    }

    local servers = {"html", "cssls", "ccls"}

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }
    end

    -- lspconfig.clangd.setup {
    --     -- cmd = { "clangd", "--background-index", "-std=c++14", "-target x86_64-w64-mingw64" },
    --     cmd = { "clangd", "--background-index" },
    --     on_attach = function(client, bufnr)
    --         client.resolved_capabilities.document_formatting = false
    --         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
    --     end
    -- }

    -- lspconfig.ccls.setup {
    --     init_options = {
    --         compilationDatabaseDirectory = "build";
    --         index = {
    --             threads = 0;
    --         };
    --         clang = {
    --             excludeArgs = { "-frounding-math"} ;
    --         };
    --     },
        -- on_attach = function(client, bufnr)
        --     client.resolved_capabilities.document_formatting = false
        --     vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        -- end
    -- }

    lspconfig.tsserver.setup {
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        end
    }

    lspconfig.powershell_es.setup {
        on_attach = attach,
        capabilities = capabilities,
        bundle = '%LocalAppData%/nvim-data/powershell_es/PowerShellEditorServices',
        shell = "pwsh",
        single_file_support = true
    }
end

return M
