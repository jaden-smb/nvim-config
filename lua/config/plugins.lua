local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  -- Code completion / LSP Front-end
  use({ "neoclide/coc.nvim", branch = "release" })
  use({ "yaegassy/coc-typescript-vue-plugin", run = "yarn install --frozen-lockfile" })

  -- Language & syntax
  use("pangloss/vim-javascript")
  use("vim-scripts/JavaScript-Indent")
  use("leafgarland/typescript-vim")
  use("posva/vim-vue")
  use("leafOfTree/vim-vue-plugin")
  use("mustache/vim-mustache-handlebars")
  use("othree/html5.vim")
  use("hail2u/vim-css3-syntax")
  use("groenewege/vim-less")
  use("ap/vim-css-color")
  use("sheerun/vim-polyglot")

  -- Python development support
  use("vim-python/python-syntax")
  use("Vimjas/vim-python-pep8-indent")
  use("tell-k/vim-autopep8")
  use("psf/black")
  use("fisadev/vim-isort")
  use("vim-scripts/indentpython.vim")

  -- Developer helpers
  use("mattn/emmet-vim")
  use({ "prettier/vim-prettier", run = "npm install --frozen-lockfile --production" })
  use("eslint/eslint")
  use("vim-syntastic/syntastic")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("windwp/nvim-ts-autotag")
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local ibl = require("ibl")
      ibl.setup({
        indent = { char = "│", tab_char = "│" },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          injected_languages = false,
          priority = 500,
        },
        exclude = {
          filetypes = {
            "help", "alpha", "dashboard", "neo-tree", "Trouble",
            "lazy", "mason", "notify", "toggleterm", "lazyterm",
          },
        },
      })
    end,
  })

  -- Git
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- Infrastructure as Code
  use("hashivim/vim-terraform")
  use("juliosueiras/vim-terraform-completion")

  -- UI & Navigation
  use({ "junegunn/fzf", run = function() vim.fn["fzf#install"]() end })
  use("junegunn/fzf.vim")
  use("vim-airline/vim-airline")
  use("preservim/nerdtree")
  use("ryanoasis/vim-devicons")
  use("nvim-tree/nvim-web-devicons")
  use("jistr/vim-nerdtree-tabs")

  -- Buffer tabs
  use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

  -- Editing helpers
  use("tpope/vim-surround")
  use("alvan/vim-closetag")
  use("m4xshen/autoclose.nvim")

  -- Appearance
  use({ "EdenEast/nightfox.nvim", tag = "v1.0.0" })
  use("rafi/awesome-vim-colorschemes")
  use("tribela/transparent.nvim")
  use("rafamadriz/neon")
  use("sainnhe/gruvbox-material")

  -- Discord Rich Presence
  use("andweeb/presence.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
