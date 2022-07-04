-- Load ui plugins

local plugin = require("core.pack").register_plugin
local conf = require("modules.ui.config")

plugin({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = conf.trouble,
})

plugin({
    "projekt0n/github-nvim-theme",
    event = "VimEnter",
    config = conf.github_nvim_theme,
})

plugin({
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
})

plugin({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = conf.nvim_tree,
    requires = "kyazdani42/nvim-web-devicons",
})

plugin({
    "nvim-lualine/lualine.nvim",
    after = "github-nvim-theme",
    config = conf.lualine,
})

plugin({
    "akinsho/nvim-bufferline.lua",
    after = "github-nvim-theme",
    config = conf.nvim_bufferline,
    requires = "kyazdani42/nvim-web-devicons",
})

plugin({
    "goolord/alpha-nvim",
    after = "lualine.nvim",
    config = conf.alpha_nvim,
})
