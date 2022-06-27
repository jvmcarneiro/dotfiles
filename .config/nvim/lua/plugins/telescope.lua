-- nvim-telescope setup

require("telescope").setup({
    defaults = {
        dynamic_preview_title = true,
    },
    extensions = {
        frecency = {
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            workspaces = {
                ["conf"] = "/home/my_username/.config",
                ["data"] = "/home/my_username/.local/share",
            },
        },
        repo = {
            cached_list = {
                file_ignore_patterns = { "^/usr/", "/%.cache/", "/%.cargo/", "/%.local/" },
            },
        },
        lsp_handlers = {
            code_action = {
                telescope = require("telescope.themes").get_dropdown({}),
            },
        },
    },
})

require("telescope").load_extension("frecency")
require("telescope").load_extension("fzf")
require("telescope").load_extension("lsp_handlers")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("repo")

vim.cmd("cnoreabbrev T Telescope")

vim.g["rooter_cd_cmd"] = "lcd"
