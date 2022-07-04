-- Load completion plugins

local plugin = require("core.pack").register_plugin
local conf = require("modules.completion.config")

plugin({
    "hrsh7th/nvim-cmp",
    after = { "nvim-lspconfig" },
    config = conf.nvim_cmp,
    requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "dmitmel/cmp-cmdline-history", after = "nvim-cmp" },
        { "quangnguyen30192/cmp-nvim-tags", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    },
})

plugin({
    "L3MON4D3/LuaSnip",
    after = "friendly-snippets",
})

plugin({
    "rafamadriz/friendly-snippets",
    event = "VimEnter",
})
