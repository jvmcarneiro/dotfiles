-- nvim-tree setup

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = { adaptive_size = false },
    diagnostics = { enable = true, show_on_dirs = true },
    filters = { dotfiles = true },
    renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        special_files = {},
        icons = {
            webdev_colors = false,
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    },
})
