-- Config util plugins

local config = {}

function config.telescope()
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
                    file_ignore_patterns = {
                        "^/usr/",
                        "/%.cache/",
                        "/%.cargo/",
                        "/%.local/",
                    },
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
    require("telescope").load_extension("lsp_handlers")
    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("repo")
    require("telescope").load_extension("fzf")

    vim.cmd("cnoreabbrev T Telescope")

    vim.g["rooter_cd_cmd"] = "lcd"
end

function config.surround()
    require("surround").setup({
        mappings_style = "sandwich",
    })
end

function config.git_conflict()
    require("git-conflict").setup()
end

function config.toggleterm()
    require("toggleterm").setup({
        direction = "horizontal",
        size = vim.o.lines * 0.3,
    })
end

function config.nvim_lastplace()
    require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
            "gitcommit",
            "gitrebase",
            "svn",
            "hgcommit",
        },
        lastplace_open_folds = true,
    })
end

function config.auto_session()
    require("auto-session").setup({
        auto_session_enable_last_session = true,
        auto_save_enabled = true,
        auto_restore_enabled = false,
        auto_session_use_git_branch = true,
    })
end
return config
