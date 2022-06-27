-- alpha-nvim setup

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

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
    [[]],
    [[]],
    nvim_version,
}
dashboard.section.header.opts = {
    position = "center",
    hl = "SpecialKey",
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
        hl = "SpecialKey",
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
    button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    button("r", "  Recent", ":Telescope oldfiles<CR>"),
    button("t", "  Last session", ":RestoreSession<CR><CR>"),
    button("f", "  Find file", ":cd $HOME | Telescope frecency<CR>"),
    button("p", "  Projects", ":Telescope repo cached_list<CR>"),
    button(
        "s",
        "  Settings",
        ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"
    ),
}
dashboard.section.buttons.opts = { spacing = 1 }

-- Set footer
local function footer()
    local plugin_count = vim.fn.len(
        vim.fn.globpath(
            vim.fn.stdpath("data") .. "/site/pack/packer/start",
            "*",
            0,
            1
        )
    )
    local prof_path = vim.fn.stdpath("config") .. "/.plugin/profiling_total.out"
    local prof_file = assert(io.open(prof_path, "r"))
    local load_time = prof_file:read("*n")
    prof_file:close()
    return string.format(
        "%d plugins loaded in %.3f ms",
        plugin_count,
        load_time
    )
end
dashboard.section.footer.val = footer()
dashboard.section.footer.opts = {
    position = "center",
    hl = "SpecialKey",
}

-- Set configs
dashboard.config.layout = {
    { type = "padding", val = 1 },
    dashboard.section.header,
    { type = "padding", val = 1 },
    dashboard.section.buttons,
    { type = "padding", val = 0 },
    dashboard.section.footer,
}

-- Send config to alpha
alpha.setup(dashboard.opts)
