return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use 'Mofiqul/dracula.nvim'
  use "lunarvim/Onedarker.nvim"

  -- general language support
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'neovim/nvim-lspconfig'
  use { "williamboman/mason.nvim" }
  use({
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  })
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- UI improvements
  use 'rcarriga/nvim-notify'
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'nvim-tree/nvim-web-devicons'
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/vim-vsnip", "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lua", 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc', 'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    }
  }

  -- Version control
  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Editting goodies
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use({
    "kylechui/nvim-surround",
    tag = "*",
  })
  --
  -- Navigation
  use 'windwp/nvim-spectre'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }
end)
