-- alpha-nvim setup

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

-- Set header
dashboard.section.header.val = {
    [[      .            .      ]],
    [[    .,;'           :,.    ]],
    [[  .,;;;,,.         ccc;.  ]],
    [[.;c::::,,,'        ccccc: ]],
    [[.::cc::,,,,,.      cccccc.]],
    [[.cccccc;;;;;;'     llllll.]],
    [[.cccccc.,;;;;;;.   llllll.]],
    [[.cccccc  ';;;;;;'  oooooo.]],
    [['lllllc   .;;;;;;;.oooooo']],
    [['lllllc     ,::::::looooo']],
    [['llllll      .:::::lloddd']],
    [[.looool       .;::coooodo.]],
    [[  .cool         'ccoooc.  ]],
    [[    .co          .:o:.    ]],
    [[      .           .'      ]],
}
dashboard.section.header.opts = {
    position = "center",
    hl = "StatusLineNC",
}

-- Custom button function
local function button(sc, txt, keybind)
    local keybind_opts = { noremap = true, silent = true, nowait = true }
    local opts = {
        position = "center",
        shortcut = sc,
        keymap = { "n", sc, keybind, keybind_opts },
        cursor = 5,
        width = 45,
        align_shortcut = "right",
        hl = "FloatBorder",
        hl_shortcut = "Keyword",
    }
    local function on_press()
        local key = vim.api.nvim_replace_termcodes(
            sc .. "<Ignore>",
            true,
            false,
            true
        )
        vim.api.nvim_feedkeys(key, "t", false)
    end
    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

-- Set buttons
dashboard.section.buttons.val = {
    button("e", "  New file", "<Cmd>ene <Bar> startinsert <CR>"),
    button("r", "  Recent", "<Cmd>Telescope oldfiles<CR>"),
    button("f", "  Find file", "<Cmd>cd $HOME <Bar> Telescope frecency<CR>"),
    button("t", "  Last session", "<Cmd>RestoreSession<CR><CR>"),
    button("p", "  Projects", "<Cmd>Telescope repo cached_list<CR>"),
    button("q", "  Quit", "<cmd>qa<CR>"),
}
dashboard.section.buttons.opts = { spacing = 1 }

-- Get nvim version
local version = vim.api.nvim_exec(
    [[
    function! GetNVimVersion()
        redir => s
        silent! version
        redir END
        return s
    endfunction
    call GetNVimVersion()
    ]],
    true
)
local nvim_version = string.match(version, "NVIM [^%s]+")

-- Set footer
dashboard.section.footer.val = nvim_version
dashboard.section.footer.opts.hl = "StatusLineNC"

-- Set configs
dashboard.config.layout = {
    { type = "padding", val = 1 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
}

-- Send config to alpha
alpha.setup(dashboard.opts)
