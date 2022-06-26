-- lualine.nvim setup

require("lualine").setup({
    options = {
        component_separators = "|",
        section_separators = "",
        disabled_filetypes = { "alpha" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename", "[%s]", { require("auto-session-library").current_session_name } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },

    extensions = { "nvim-tree", "toggleterm" },
})
