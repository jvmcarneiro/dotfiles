-- Load util plugins

local plugin = require("core.pack").register_plugin
local conf = require("modules.utils.config")

plugin({ "lewis6991/impatient.nvim" })

plugin({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        { "nvim-lua/popup.nvim", event = "VimEnter" },
        { "nhvim-lua/plenary.nvim", event = "VimEnter" },
        { "gbrlsnchs/telescope-lsp-handlers.nvim", event = "BufEnter" },
        { "AckslD/nvim-neoclip.lua", event = "BufEnter" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            event = "BufEnter",
            run = "make",
        },
        {
            "nvim-telescope/telescope-frecency.nvim",
            event = "BufEnter",
            requires = { { "tami5/sqlite.lua", event = "VimEnter" } },
        },
        {
            "cljoly/telescope-repo.nvim",
            event = "BufEnter",
            requires = { { "airblade/vim-rooter", event = "VimEnter" } },
        },
    },
})

plugin({
    "ur4ltz/surround.nvim",
    cmd = {
        "SurroundToggleBrackets",
        "SurroundToggleQuotes",
        "SurroundAddNormal",
        "SurroundAddVisual",
        "SurroundReplace",
        "SurroundDelete",
        "SurroundRepeat",
    },
    config = conf.surround,
})

plugin({
    "akinsho/git-conflict.nvim",
    after = "github-nvim-theme",
    config = conf.git_conflict,
})

plugin({
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    requires = {
        "plenary.nvim",
        "kyazdani42/nvim-web-devicons",
    },
})

plugin({
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = conf.toggleterm,
})

plugin({
    "ethanholz/nvim-lastplace",
    event = "BufEnter",
    config = conf.nvim_lastplace,
})

plugin({
    "rmagatti/auto-session",
    cmd = "RestoreSession",
    config = conf.auto_session,
})
