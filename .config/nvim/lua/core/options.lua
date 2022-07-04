-- Vim options

local cache_dir = os.getenv("HOME") .. "/.cache/nvim/"
local set = vim.opt

-- Utils
set.mouse = "a" -- Mouse for all modes
set.visualbell = true -- Visual error indication
set.fileformats = "unix,mac,dos" -- Universal eol support
set.virtualedit = "block" -- Select empty spaces in visual mode
set.wildignorecase = true -- Ignore file and folder case
set.shortmess = "aoOTIcF" -- Abbreviate messages
set.shell = "/bin/bash" -- Faster shell
set.lazyredraw = true -- Speed up macros on large files

-- Backup and history
set.undofile = true
set.undodir = cache_dir .. "undo/"
set.swapfile = true
set.directory = cache_dir .. "swp/"
set.backup = true
set.writebackup = true
set.backupdir = cache_dir .. "backup/"
set.viewdir = cache_dir .. "view/"
set.spelllang = { "pt_br", "en_us" }
set.spellfile = cache_dir .. "spell/en.uft-8.add"
set.sessionoptions = "blank,buffers,curdir,help,winsize,winpos,terminal"
set.history = 2000

-- Timeouts
set.timeoutlen = 500
set.ttimeoutlen = 10
set.updatetime = 100
set.redrawtime = 1500

-- Search and completion
set.ignorecase = true
set.smartcase = true
set.infercase = true
set.incsearch = true
set.wrapscan = true
set.complete = ".,w,b,u,t,k"
set.completeopt = "menu,menuone,preview,noselect"
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --hidden --vimgrep --smart-case --"

-- Line behavior
set.startofline = true
set.whichwrap = "h,l,<,>,[,],~"
set.scrolloff = 2
set.sidescrolloff = 5
set.textwidth = 80
set.tabstop = 4
set.shiftwidth = 4
set.linebreak = true

-- Display
set.termguicolors = true
set.ruler = false
set.list = true
set.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
set.showbreak = "→→→ "
set.showtabline = 0
set.conceallevel = 2
set.concealcursor = "niv"

-- Window
set.winwidth = 30
set.winminwidth = 10
set.pumheight = 15
set.helpheight = 12
set.previewheight = 12
set.signcolumn = "yes"
