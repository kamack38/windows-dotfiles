require("plugins.configs.others").lsp_handlers()

local function on_attach(_, bufnr)
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
   require("core.mappings").lspconfig()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp_installer = require "nvim-lsp-installer"

lsp_installer.settings {
   ui = {
      icons = {
         server_installed = "﫟",
         server_pending = "",
         server_uninstalled = "✗",
      },
   },
}

lsp_installer.on_server_ready(function(server)
  -- server options, so default options for all servers
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
       debounce_text_changes = 150,
    },
    settings = {},
  }

  -- below 2 if conditions are just examples of changing server options
  -- if you dont use those servers then remove them
  -- disabling inbuilt formatter of tsserver to use null-ls formatter for it
  if server.name == "tsserver" then
    opts.on_attach = function(client, bufnr)
       client.resolved_capabilities.document_formatting = false
       vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
    end
  end
  
  if server.name == "powershell_es" then
    opts.settings = {
      bundle = '%LocalAppData%/nvim-data/powershell_es/PowerShellEditorServices',
      shell = "pwsh",
      single_file_support = true
    }
  end
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)