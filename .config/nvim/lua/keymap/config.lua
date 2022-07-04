-- Core keymaps

local keymap = require("core.keymap")
local map, silent, noremap = keymap.map, keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Leader key
vim.g.mapleader = " "

map({
    -- Free space key for Leader
    { "n", " ", "", opts(noremap) },
    { "x", " ", "", opts(noremap) },

    -- Close buffer
    { "n", "<C-x>k", cmd("bdelete"), opts(noremap, silent) },

    -- Buffer jump
    { "n", "]b", cmd("bp"), opts(noremap) },
    { "n", "[b", cmd("bp"), opts(noremap) },

    -- Window jump
    { "n", "<C-h>", "<C-w>h", opts() },
    { "n", "<C-l>", "<C-w>l", opts() },
    { "n", "<C-j>", "<C-w>j", opts() },
    { "n", "<C-k>", "<C-w>k", opts() },

    -- Insert mode backspace
    { "i", "<C-h>", "<Bs>", opts(noremap) },

    -- Display lines
    { "n", "k", "gk", opts(noremap, silent) },
    { "n", "j", "gj", opts(noremap, silent) },
    { "n", "0", "g0", opts(noremap, silent) },
    { "n", "$", "g$", opts(noremap, silent) },

    -- Clear selection
    { "n", "<C-\\>", cmd("noh"), opts(noremap) },
})
