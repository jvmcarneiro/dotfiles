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
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, diag_opts)

-- Plugin keymaps

-- nvim-tree: file tree sidebar
vim.keymap.set("n", "<leader>n", function()
    require("nvim-tree").toggle()
end, { noremap = true, silent = true })

-- toggleterm: terminal commands
local term_opt = { noremap = true }
vim.keymap.set("n", "<C-Home>", ":ToggleTerm direction=horizontal<CR>", term_opt)
vim.keymap.set("i", "<C-Home>", "<Esc>:ToggleTerm direction=horizontal<CR>", term_opt)
vim.keymap.set("t", "<C-Home>", "<C-\\><C-n>:ToggleTerm direction=horizontal<CR>", term_opt)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", term_opt)
vim.keymap.set("t", ":q", "<C-\\><C-n>:q!<CR>", term_opt)

-- sniprun: repl interpreter
local snip_opt = { silent = true }
vim.keymap.set("v", "<leader>f", "<Plug>SnipRun", snip_opt)
vim.keymap.set("n", "<leader>f", "<Plug>SnipRunOperator", snip_opt)
vim.keymap.set("n", "<leader>ff", "<Plug>SnipRun", snip_opt)
vim.keymap.set("n", "<leader>fq", "<Plug>SnipClose", snip_opt)

-- telescope: fzf interface
local tele_opt = { noremap = true }
vim.keymap.set("n", "<leader>tf", ":Telescope frecency<CR>", tele_opt)
vim.keymap.set("n", "<leader>tg", ":Telescope live_grep<CR>", tele_opt)

-- trouble: diagnostics window
local trbl_opt = { noremap = true }
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", trbl_opt)
vim.keymap.set("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", trbl_opt)
vim.keymap.set("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", trbl_opt)
vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<CR>", trbl_opt)
vim.keymap.set("n", "<leader>xl", ":TroubleToggle loclist<CR>", trbl_opt)
vim.keymap.set("n", "gR", ":TroubleToggle lsp_refereces<CR>", trbl_opt)
