-- github-nvim-theme setup

require("github-theme").setup({
    theme_style = "dark_default",
    hide_end_of_buffer = true,
    hide_inactive_statusline = false,
    comment_style = "italic",
    function_style = "bold",
    keyword_style = "NONE",
    msg_area_style = "NONE",
    variable_style = "NONE",
    sidebars = { "qf", "vista_kind", "terminal", "packer", "NvimTree" },
})
