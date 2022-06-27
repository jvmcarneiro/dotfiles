-- Keymaps for both native neovim and installed plugins

-- Native keymaps

-- Treat display lines as normal
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "0", "g0", { noremap = true, silent = true })
vim.keymap.set("n", "$", "g$", { noremap = true, silent = true })

-- Simplify window navigation
vim.keymap.set("", "<C-j>", "<c-w>j")
vim.keymap.set("", "<C-k>", "<c-w>k")
vim.keymap.set("", "<C-h>", "<c-w>h")
vim.keymap.set("", "<C-l>", "<c-w>l")

-- Maps Ctrl+\ to clear search highlighting
vim.keymap.set("n", "<C-\\>", ":noh<CR><CR>", { noremap = true })

-- Diagnostics
local diag_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, diag_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, diag_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, diag_opts)

-- Plugin keymaps

-- nvim-tree: file tree sidebar
vim.keymap.set("n", "<leader>n", function()
    require("nvim-tree").toggle()
end, { noremap = true, silent = true })

-- toggleterm: terminal commands
local term_opt = { noremap = true }
vim.keymap.set("n", "<C-Home>", ":ToggleTerm<CR>", term_opt)
vim.keymap.set("i", "<C-Home>", "<Esc>:ToggleTerm<CR>", term_opt)
vim.keymap.set("t", "<C-Home>", "<C-\\><C-n>:ToggleTerm<CR>", term_opt)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", term_opt)
vim.keymap.set("t", ":q", "<C-\\><C-n>:q!<CR>", term_opt)
vim.keymap.set("n", "<C-c><C-c>", ":ToggleTermSendCurrentLine<CR>", term_opt)
vim.keymap.set(
    "x",
    "<C-c><C-c>",
    ":ToggleTermSendVisualSelection<CR>",
    term_opt
)

-- telescope: fzf interface
local tele_opt = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>tf", ":Telescope frecency<CR>", tele_opt)
vim.keymap.set("n", "<leader>tr", ":Telescope oldfiles<CR>", tele_opt)
vim.keymap.set("n", "<leader>tg", ":Telescope live_grep<CR>", tele_opt)

-- trouble: diagnostics window
local trbl_opt = { noremap = true }
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", trbl_opt)
vim.keymap.set(
    "n",
    "<leader>xw",
    ":TroubleToggle workspace_diagnostics<CR>",
    trbl_opt
)
vim.keymap.set(
    "n",
    "<leader>xd",
    ":TroubleToggle document_diagnostics<CR>",
    trbl_opt
)
vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<CR>", trbl_opt)
vim.keymap.set("n", "<leader>xl", ":TroubleToggle loclist<CR>", trbl_opt)

-- FileType keymaps

-- Python
local group_python = vim.api.nvim_create_augroup("PyGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = group_python,
    callback = function()
        vim.keymap.set(
            "n",
            "<C-c><C-f>",
            ":TermExec cmd='ipython' go_back=1<CR>",
            term_opt
        )
        vim.keymap.set(
            "n",
            "<C-c><C-g>",
            ":w<CR>"
                .. string.format(
                    [[:TermExec cmd="\\%%run %s" go_back=0<CR>]],
                    vim.fn.expand("<afile>")
                ),
            term_opt
        )
    end,
})

-- Lua
local group_lua = vim.api.nvim_create_augroup("LuaGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    group = group_lua,
    callback = function()
        vim.keymap.set(
            "n",
            "<C-c><C-f>",
            ":TermExec cmd='lua' go_back=1<CR>",
            term_opt
        )
        vim.keymap.set(
            "n",
            "<C-c><C-g>",
            ":w<CR>"
                .. string.format(
                    [[:TermExec cmd=dofile("%s") go_back=0<CR>]],
                    vim.fn.expand("<afile>")
                ),
            term_opt
        )
    end,
})
