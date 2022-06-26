-- nvim-neoclip setup

require("neoclip").setup({
    enable_persistent_history = true,
    continuous_sync = true,
    default_register = { '"', "+", "*" },
    keys = {
        telescope = {
            i = {
                paste = "<c-P>",
            },
        },
    },
})
