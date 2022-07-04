-- Load syntax plugins
local plugin = require("core.pack").register_plugin
local conf = require("modules.syntax.config")

plugin({
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = ":TSUpdate",
    config = conf.nvim_treesitter,
})

plugin({
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    config = conf.nvim_lspconfig,
    requires = { { "williamboman/nvim-lsp-installer", event = "BufRead" } },
})

plugin({
    "williamboman/nvim-lsp-installer",
    cmd = { "LspInstallInfo", "LspInstall", "LspUninstall" },
})

plugin({
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "lua", "python" },
    config = conf.null_ls,
    requires = "nvim-lua/plenary.nvim",
})

plugin({
    "Darazaki/indent-o-matic",
    event = "BufEnter",
})
