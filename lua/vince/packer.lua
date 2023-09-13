-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

local function intstall_plugins(use)
	-- Packer can manage itself
	use {
        'wbthomason/packer.nvim'
    }

    -- telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    -- tree sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		'nvim-treesitter/playground',
        "nvim-treesitter/nvim-treesitter-context",
	}

    -- harpoon
	use {
		'theprimeagen/harpoon'
	}

    -- undotree
	use {
		'mbbill/undotree'
	}

    -- git
	use {
		'tpope/vim-fugitive'
	}

    -- lsp
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'neovim/nvim-lspconfig'
    }

    -- cmp
    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
    }

    -- snippets
    use {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v1.2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    }

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- emmet
    use {
        'mattn/emmet-vim',
        setup = function () -- load stuff before the plugin is loaded
            vim.g.user_emmet_leader_key='<C-Z>'
        end
    }

    -- theme
	use {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	}

    -- nvim-jdtls
    use 'mfussenegger/nvim-jdtls'

end

packer.startup(intstall_plugins)
