-- Module keymaps

require("keymap.config")
local keymap = require("core.keymap")
local map = keymap.map
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Plugins
map({
    -- Diagnostics
    { "n", "<Leader>d", vim.diagnostic.open_float, opts(noremap, silent) },
    { "n", "[d", vim.diagnostic.goto_prev, opts(noremap, silent) },
    { "n", "]d", vim.diagnostic.goto_next, opts(noremap, silent) },

    -- nvim-tree
    { "n", "<Leader>e", cmd("NvimTreeToggle"), opts(noremap, silent) },

    -- Telescope
    { "n", "<Leader>tf", cmd("Telescope frecency"), opts(noremap, silent) },
    { "n", "<Leader>tr", cmd("Telescope oldfiles"), opts(noremap, silent) },
    { "n", "<Leader>tg", cmd("Telescope live_grep"), opts(noremap, silent) },

    -- trouble
    {
        "n",
        "<Leader>xx",
        cmd("TroubleToggle"),
        opts(noremap, silent),
    },
    {
        "n",
        "<Leader>xw",
        cmd("TroubleToggle workspace_diagnostics"),
        opts(noremap, silent),
    },

    -- toggleterm
    {
        "n",
        "<Leader>gv",
        cmd("ToggleTerm"),
        opts(noremap, silent),
    },
    {
        "t",
        "<Leader>gv",
        "<C-\\><C-n>" .. cmd("ToggleTerm"),
        opts(noremap, silent),
    },
    {
        "t",
        "<Esc>",
        "<C-\\><C-n>",
        opts(noremap, silent),
    },
    {
        "t",
        ":q",
        "<C-\\><C-n>" .. cmd("q!"),
        opts(noremap, silent),
    },
    {
        "n",
        "<Leader>gg",
        cmd("ToggleTermSendCurrentLine"),
        opts(noremap, silent),
    },
    {
        "x",
        "<Leader>gg",
        cmd("ToggleTermSendVisualSelection"),
        opts(noremap, silent),
    },
})

-- Python
local group_python = vim.api.nvim_create_augroup("PyGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = group_python,
    callback = function()
        map({
            {
                "n",
                "<Leader>gf",
                cmd("TermExec cmd='ipython' go_back=1"),
                opts(noremap, silent),
            },
            {
                "n",
                "<Leader>gr",
                cmd("w") .. cmd(
                    string.format(
                        "TermExec cmd='\\%%run %s' go_back=0",
                        vim.fn.expand("<afile>")
                    )
                ),
                opts(noremap, silent),
            },
        })
    end,
})

-- Lua
local group_lua = vim.api.nvim_create_augroup("LuaGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    group = group_lua,
    callback = function()
        map({
            {
                "n",
                "<Leader>gf",
                cmd("TermExec cmd='lua' go_back=1"),
                opts(noremap, silent),
            },
            {
                "n",
                "<Leader>gr",
                cmd("w") .. cmd(
                    string.format(
                        "TermExec cmd=dofile('%s') go_back=0",
                        vim.fn.expand("<afile>")
                    )
                ),
                opts(noremap, silent),
            },
        })
    end,
})
