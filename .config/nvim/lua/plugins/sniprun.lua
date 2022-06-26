-- sniprun setup

require("sniprun").setup({
    selected_interpreters = {
        "Lua_nvim",
    },
    display = {
        "Classic",
        "TerminalWithCode",
    },
    display_options = {
        terminal_width = 40,
    },
    show_no_output = {
        "Classic",
    },
    borders = "single",
})
