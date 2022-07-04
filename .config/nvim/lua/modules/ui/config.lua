-- Config ui plugins

local config = {}

function config.trouble()
    require("trouble").setup()
end

function config.github_nvim_theme()
    require("github-theme").setup({
        theme_style = "dark_default",
        dark_float = true,
        hide_end_of_buffer = true,
        hide_inactive_statusline = false,
        comment_style = "italic",
        function_style = "bold",
        keyword_style = "NONE",
        msg_area_style = "NONE",
        variable_style = "NONE",
        sidebars = { "qf", "vista_kind", "terminal", "packer", "NvimTree" },
        overrides = function(c)
            return {
                NvimTreeFolderName = { fg = "#8094b4" },
                NvimTreeFolderIcon = { fg = "#8094b4" },
                NvimTreeOpenedFolderName = { fg = "#8094b4", style = "bold" },
            }
        end,
    })
end

function config.nvim_tree()
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        respect_buf_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
        },
        diagnostics = { enable = true, show_on_dirs = true },
        filters = { dotfiles = true },
        renderer = {
            special_files = {},
            icons = {
                webdev_colors = false,
                git_placement = "signcolumn",
                show = {
                    folder_arrow = false,
                },
            },
        },
    })
end

function config.lualine()
    require("lualine").setup({
        options = {
            component_separators = "|",
            section_separators = "",
            disabled_filetypes = { "alpha" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },

        extensions = { "nvim-tree", "toggleterm" },
    })
end

function config.alpha_nvim()
    require("modules.ui.alpha_nvim")
end

return config
