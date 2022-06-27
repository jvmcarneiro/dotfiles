-- Install packer if missing
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_Bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- Auto source when there are changes
local group = vim.api.nvim_create_augroup("PackerGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer_init.lua",
    callback = function()
        SaveProfiling = function()
            local total_path = vim.fn.stdpath("config")
                .. "/.plugin/profiling_total.out"
            local total_file = assert(io.open(total_path, "w"))
            local prof_string = vim.inspect(_G._packer.profile_output)
            local total_time = 0.0
            for match in string.gmatch(prof_string, "%d+%.%d+[^(ms)]") do
                total_time = total_time + tonumber(match)
            end
            total_file:write(string.format("%.3f", total_time))
            total_file:close()
        end
        vim.api.nvim_exec("source <afile>", false)
        vim.api.nvim_exec("PackerCompile profile=true", false)
        vim.api.nvim_exec(
            "autocmd User PackerCompileDone lua SaveProfiling()",
            false
        )
    end,
    group = group,
})

-- Load packages
return require("packer").startup({
    function(use)
        -- packer.nvim: package manager
        use("wbthomason/packer.nvim")

        -- planary.nvim: ksync lua functions extension
        use("nvim-lua/plenary.nvim")

        -- nvim-treesitter: universal language parser
        use({
            "nvim-treesitter/nvim-treesitter",
            requires = "plenary.nvim",
            run = ":TSUpdate",
        })

        -- nvim-lsp-installer: automatic LSP download
        use("williamboman/nvim-lsp-installer")

        -- nvim-lspconfig: LSP configuration
        use({
            "neovim/nvim-lspconfig",
            requires = "nvim-lsp-installer",
        })

        -- null-ls: extra LSP features
        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = "nvim-lua/plenary.nvim",
        })

        -- nvim-cmp: completion
        use({
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/luasnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "dmitmel/cmp-cmdline-history",
            "lukas-reineke/cmp-rg",
            "quangnguyen30192/cmp-nvim-tags",
        })

        -- cmp-fuzzy: nvim-cmp fzf extensions
        use({
            "tzachar/fuzzy.nvim",
            "tzachar/cmp-fuzzy-buffer",
            "tzachar/cmp-fuzzy-path",
            requires = {
                "hrsh7th/nvim-cmp",
                "nvim-telescope/telescope-fzf-native.nvim",
            },
        })

        -- telescope: multi-use fuzzy finder
        use({
            "nvim-telescope/telescope.nvim",
            requires = "nvim-lua/plenary.nvim",
        })

        -- telescope-fzf: telescope sorter extension
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            requires = "nvim-telescope/telescope.nvim",
            run = "make",
        })

        -- telescope-frecency: frequency + recency telescope extension
        use({
            "nvim-telescope/telescope-frecency.nvim",
            requires = {
                "tami5/sqlite.lua",
                "nvim-telescope/telescope.nvim",
            },
        })

        -- telescope-repo: search the fs for repos
        use({
            "cljoly/telescope-repo.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
                "airblade/vim-rooter",
            },
        })

        -- telescope-lsp-handlers: telescope extension to handle lsp commands
        use({ "gbrlsnchs/telescope-lsp-handlers.nvim" })

        -- neoclip: clipboard telescope extension
        use({
            "AckslD/nvim-neoclip.lua",
            requires = { "nvim-telescope/telescope.nvim" },
        })

        -- cheatsheet: kayboard mappings cheat sheet
        use({
            "sudormrfbin/cheatsheet.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
            },
        })

        -- trouble: pretty diagnostics
        use({ "folke/trouble.nvim" })

        -- indent-o-matic: dumb (fast) indent detection
        use("Darazaki/indent-o-matic")

        -- github-nvim-theme: current color theme
        use({ "projekt0n/github-nvim-theme" })

        -- nvim-colorizer: colorizer for names and hex codes
        use({
            "norcalli/nvim-colorizer.lua",
            requires = "github-nvim-theme",
        })

        -- nvim-tree: file tree explorer sidebar
        use({
            "kyazdani42/nvim-tree.lua",
            requires = "github-nvim-theme",
        })

        -- lualine: fancy status line
        use({
            "nvim-lualine/lualine.nvim",
            requires = "github-nvim-theme",
        })

        -- vim-repeat: improved repeat for most keybindings
        use("tpope/vim-repeat")

        -- surround: bindings for surrounding stuff
        use({ "ur4ltz/surround.nvim" })

        -- gitsigns: git visualization (blame and more)
        use({
            "lewis6991/gitsigns.nvim",
            requires = "github-nvim-theme",
            config = function()
                require("gitsigns").setup()
            end,
        })

        -- diffview: git diff tool
        use({ "sindrets/diffview.nvim", requires = "plenary.nvim" })

        -- toggleterm: terminal configuration
        use({
            "akinsho/toggleterm.nvim",
            requires = "github-nvim-theme",
        })

        -- vim-slime: run text to repl
        use({ "jpalardy/vim-slime" })

        -- nvim-lastplace: remember last cursor position
        use({ "ethanholz/nvim-lastplace" })

        -- alpha: greeter ui
        use({ "goolord/alpha-nvim" })

        -- auto-session: save and load prev sessions
        use({
            "rmagatti/auto-session",
        })

        -- Load config after cloning packer
        if Packer_Bootstrap then
            require("packer").sync()
        end
    end,

    config = {
        compile_path = vim.fn.stdpath("config")
            .. "/.plugin/packer_compiled.lua",
        log = { level = "trace" },
        profile = {
            enable = true,
            threshold = 0,
        },
    },
})
