-- Native neovim options

local set = vim.opt

-- Enable mouse support
set.mouse = "a"

-- Set spelling languages
set.spelllang = { "pt_br", "en_us" }

-- Wrap navigation commands over lines
set.whichwrap:append({
    ["<"] = true,
    [">"] = true,
    ["["] = true,
    ["]"] = true,
    ["h"] = true,
    ["l"] = true,
})

-- Backup config
set.undofile = true
set.undodir = vim.fn.stdpath("config") .. "/.undo"
set.swapfile = true
set.directory = vim.fn.stdpath("config") .. "/.swp"
set.backup = true
set.writebackup = true
set.backupcopy = "auto"
set.backupdir = vim.fn.stdpath("config") .. "/.backup"

-- Session config
set.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
