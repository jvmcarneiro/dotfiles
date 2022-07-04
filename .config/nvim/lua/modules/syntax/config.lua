-- Config syntax plugins

local config = {}

function config.nvim_treesitter()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python" },
        highlight = { enable = true },
        indent = { enable = true },
    })
end

function config.nvim_lspconfig()
    vim.diagnostic.config({ virtual_text = false })
    require("nvim-lsp-installer").setup({})
    local on_attach = function(client, bufnr)
        print("Hi")
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            bufopts
        )
        vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            bufopts
        )
        vim.keymap.set("n", "<space>wl", function()
            print(client.name)
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
    end

    local lsp_flags = {
        debounce_text_changes = 150,
    }

    require("lspconfig").pyright.setup({
        on_attach = on_attach,
        flags = lsp_flags,
    })

    require("lspconfig").sumneko_lua.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    enable = true,
                    globals = { "vim" },
                },
                workspace = {
                    preloadFileSize = 10000,
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

function config.null_ls()
    local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            bufnr = bufnr,
        })
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.isort,
            require("null-ls").builtins.formatting.stylua.with({
                extra_args = {
                    "--column-width",
                    "80",
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                },
            }),
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        lsp_formatting(bufnr)
                    end,
                })
            end
        end,
    })
end

return config
