-- Basic Options
local opt = vim.opt
opt.number = true            -- Show line numbers
vim.o.verbose = 0 -- suppress 'Sourcing ...' messages

-- Ensure verbose stays off for Handlebars buffers (html indent can re-enable it)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "handlebars", "html.handlebars" },
  callback = function()
    vim.o.verbose = 0
  end,
})
opt.relativenumber = true    -- Relative numbers
opt.autoindent = true
opt.smartindent = true       -- Automatic smarter indentation for code blocks
opt.cindent = true           -- More advanced C-like indentation
opt.expandtab = true         -- Use spaces instead of tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.softtabstop = 4
opt.shiftround = true        -- Round indent to multiple of shiftwidth
opt.mouse = "a"
opt.encoding = "utf-8"
opt.clipboard:append("unnamedplus")
opt.background = "dark"
opt.termguicolors = true
opt.modifiable = true

-- Compatibility: alias vim.uv to vim.loop for Neovim <0.10
if vim.uv == nil and vim.loop ~= nil then
  vim.uv = vim.loop
end

-- Advanced indentation settings
opt.breakindent = true       -- Preserve indentation in wrapped text
opt.showbreak = "↪ "         -- Show line break character
opt.linebreak = true         -- Break lines at word boundaries
opt.preserveindent = true    -- Preserve indent structure when re-indenting

-- Leader
vim.g.mapleader = ","

---------------------------------------------------------------------
-- Packer Bootstrap -------------------------------------------------
---------------------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

---------------------------------------------------------------------
-- Plugins ----------------------------------------------------------
---------------------------------------------------------------------
require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  -- Code completion / LSP Front-end --------------------------------
  use({ "neoclide/coc.nvim", branch = "release" })
  use({ "yaegassy/coc-typescript-vue-plugin", run = "yarn install --frozen-lockfile" })

  -- Language & syntax ---------------------------------------------
  use("pangloss/vim-javascript")
  use("vim-scripts/JavaScript-Indent")  -- Better JavaScript indentation
  use("leafgarland/typescript-vim")
  use("posva/vim-vue")
  use("leafOfTree/vim-vue-plugin")
  use("mustache/vim-mustache-handlebars")
  use("othree/html5.vim")
  use("hail2u/vim-css3-syntax")
  use("groenewege/vim-less")
  use("ap/vim-css-color")
  use("sheerun/vim-polyglot")

  -- Python development support -----------------------------------
  use("vim-python/python-syntax")
  use("Vimjas/vim-python-pep8-indent")
  use("tell-k/vim-autopep8")
  use("psf/black")
  use("fisadev/vim-isort")
  use("vim-scripts/indentpython.vim")

  -- Developer helpers ---------------------------------------------
  use("mattn/emmet-vim")
  use({ "prettier/vim-prettier", run = "npm install --frozen-lockfile --production" })
  use("eslint/eslint")
  use("vim-syntastic/syntastic")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("windwp/nvim-ts-autotag")
  use({
    "lukas-reineke/indent-blankline.nvim", -- Visual indentation guides
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
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  })

  -- Git ------------------------------------------------------------
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- Infrastructure as Code ----------------------------------------
  use("hashivim/vim-terraform")
  use("juliosueiras/vim-terraform-completion")

  -- UI & Navigation ------------------------------------------------
  use({ "junegunn/fzf", run = function() vim.fn["fzf#install"]() end })
  use("junegunn/fzf.vim")
  use("vim-airline/vim-airline")
  use("preservim/nerdtree")
  use("ryanoasis/vim-devicons")
  use("jistr/vim-nerdtree-tabs")

  -- Editing helpers ------------------------------------------------
  use("tpope/vim-surround")
  use("alvan/vim-closetag")
  use("m4xshen/autoclose.nvim")

  -- Appearance -----------------------------------------------------
  use({ "EdenEast/nightfox.nvim", tag = "v1.0.0" })
  use("rafi/awesome-vim-colorschemes")
  use("tribela/transparent.nvim")
  use("rafamadriz/neon")
  use("sainnhe/gruvbox-material")

  -- Discord Rich Presence ------------------------------------------
  use("andweeb/presence.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

---------------------------------------------------------------------
-- Plugin Config ----------------------------------------------------
---------------------------------------------------------------------
-- Transparent.nvim -------------------------------------------------
local ok, transparent = pcall(require, "transparent")
if ok then
  transparent.setup({
    extra_groups = {
      "NormalFloat", "StatusLine", "StatusLineNC", "VertSplit",
      "FloatBorder", "NonText", "SpecialKey", "Folded", "FoldColumn",
      "Pmenu", "CursorLine", "TabLine", "TabLineFill", "TabLineSel",
      "NvimTreeNormal", "TelescopeNormal", "WhichKeyFloat",
      "NightfoxNormal", "NightfoxFloat", "NightfoxStatusLine",
    },
    exclude_groups = {},
    enable = true,
  })
end

-- Treesitter -------------------------------------------------------
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
  treesitter.setup({
    ensure_installed = { 
      "html", "css", "scss", "javascript", "typescript", "tsx", "json", "jsonc",
      "python", "lua", "vim", "vimdoc", "yaml", "toml", "markdown", "vue",
      "bash", "dockerfile", "gitignore", "sql", "regex"
    },
    highlight = { 
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { 
      enable = true,
      disable = { "yaml" }, -- YAML indentation can be problematic with treesitter
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })
end

-- Gitsigns ---------------------------------------------------------
local ok, gitsigns = pcall(require, "gitsigns")
if ok then
  gitsigns.setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = { follow_files = true },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
    },
    update_debounce = 100,
    diff_opts = { internal = true },
  })
end

-- Discord Presence -------------------------------------------------
local ok, presence = pcall(require, "presence")
if ok then
  presence:setup({
    -- General options
    auto_update = true,                       -- Update activity based on autocmd events
    neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image = "neovim",                    -- Main image display (either "neovim" or "file")
    client_id = "793271441293967371",         -- Use your own Discord application client id
    log_level = nil,                          -- Log messages at or above this level (nil = no log)
    debounce_timeout = 10,                    -- Number of seconds to debounce events
    show_time = true,                         -- Show the timer

    -- Rich presence text options
    editing_text = "Editing %s",              -- Format string for currently editing
    file_explorer_text = "Browsing %s",       -- Format string for file explorer
    git_commit_text = "Committing changes",   -- Format string for commits
    plugin_manager_text = "Managing plugins", -- Format string for plugin manager
    reading_text = "Reading %s",              -- Format string for reading files
    workspace_text = "secret_workspace",      -- Static workspace name instead of actual workspace

    -- Rich presence emoji options
    line_number_text = "Line %s out of %s",   -- Format string for line number
    terminal_text = "Using Terminal",         -- Format string for terminal usage
  })
end

-- Autoclose.nvim ---------------------------------------------------
local ok, autoclose = pcall(require, "autoclose")
if ok then
  autoclose.setup()
end

-- nvim-ts-autotag --------------------------------------------------
local ok, autotag = pcall(require, "nvim-ts-autotag")
if ok then
  autotag.setup()
end

-- ibl configuration is set in the Packer `use` block above.

---------------------------------------------------------------------
-- Colourscheme -----------------------------------------------------
---------------------------------------------------------------------
-- Gruvbox material configuration (set before loading the colorscheme)
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_better_performance = 1

local colorscheme = "gruvbox-material"
local success = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not success then
  -- Fallback to default colorscheme
  vim.cmd("colorscheme default")
end

-- Extra transparency on top of theme ------------------------------
local function apply_transparent_highlights()
  local groups = {
    "Normal", "LineNr", "SignColumn", "EndOfBuffer", "NERDTreeNormal",
    "StatusLine", "StatusLineNC", "VertSplit", "Folded", "FloatBorder",
    "Pmenu", "CursorLine", "TabLine", "TabLineFill", "TabLineSel",
  }
  for _, grp in ipairs(groups) do
    vim.cmd("hi " .. grp .. " guibg=NONE ctermbg=NONE")
  end
  if vim.fn.exists(":TransparentEnable") == 2 then
    vim.cmd("TransparentEnable")
  end
end
apply_transparent_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_transparent_highlights,
})

---------------------------------------------------------------------
-- Keymaps ----------------------------------------------------------
---------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic ------------------------------------------------------------
map("n", "<leader>w", ":w<CR>", opts)          -- Save
map("i", "ii", "<Esc>", opts)                 -- ii -> Esc

-- Folding (space) --------------------------------------------------
map("n", "<Space>", function()
  return vim.fn.foldlevel(".") ~= 0 and "za" or "<Space>"
end, { expr = true })
map("v", "<Space>", "zf", opts)

-- Plugin Ops -------------------------------------------------------
map("n", "<leader>s", ":CocSearch ", { noremap = true })
map("n", "<leader>f", function()
  -- Store current window info before opening fzf
  local current_win = vim.api.nvim_get_current_win()
  vim.cmd("Files")
  -- Set up autocmd to handle post-fzf actions
  vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
      vim.defer_fn(function()
        -- If NERDTree is open, find the newly opened file
        if is_nerdtree_open() then
          find_current_file_in_nerdtree()
        end
        -- Refresh NERDTree state detection after fzf
        if vim.fn.exists("g:NERDTree") == 1 then
          vim.cmd("silent! doautocmd WinEnter")
        end
      end, 50)
    end,
  })
end, opts)
map("n", "<leader>g", function()
  vim.cmd("Rg")
  -- Similar handling for ripgrep results
  vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
      vim.defer_fn(function()
        if is_nerdtree_open() then
          find_current_file_in_nerdtree()
        end
      end, 50)
    end,
  })
end, opts)
map("n", "<leader>d", function()
  toggle_nerdtree_with_refresh()
end, opts)
map("n", "<leader>nf", function()
  if not find_current_file_in_nerdtree() then
    print("No file currently open or file not found")
  end
end, { noremap = true, silent = false, desc = "Find current file in NERDTree" })
map("n", "<leader><CR>", "<CR><C-w>h:q<CR>", opts)

-- Terminals --------------------------------------------------------
map("n", "<leader>tv", ":botright vnew | terminal<CR>", opts)
map("n", "<leader>th", ":botright new | terminal<CR>", opts)
map("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Window nav -------------------------------------------------------
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Undo/Redo --------------------------------------------------------
map("n", "<C-Z>", "u")
map("n", "<C-Y>", "<C-R>")
map("i", "<C-Z>", "<C-O>u")
map("i", "<C-Y>", "<C-O><C-R>")

-- Git/Gitsigns -----------------------------------------------------
map("n", "]h", ":Gitsigns next_hunk<CR>", opts)
map("n", "[h", ":Gitsigns prev_hunk<CR>", opts)
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>hb", ":Gitsigns toggle_current_line_blame<CR>", opts)

-- Vim-Fugitive -----------------------------------------------------
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gc", ":Git commit<CR>")
map("n", "<leader>gd", ":Gdiff<CR>")
map("n", "<leader>gb", ":Git blame<CR>")
map("n", "<leader>gl", ":Git log<CR>")
map("n", "<leader>gp", ":Git push<CR>")
map("n", "<leader>gf", ":Git fetch<CR>")
map("n", "<leader>gpl", ":Git pull<CR>")

-- Discord Presence --------------------------------------------------
map("n", "<leader>dp", function()
  if pcall(require, "presence") then
    vim.cmd("lua require('presence'):update()")
    print("Discord presence updated")
  else
    print("Discord presence not available")
  end
end, { desc = "Update Discord presence" })

---------------------------------------------------------------------
-- NERDTree Helpers -------------------------------------------------
---------------------------------------------------------------------
function _G.is_nerdtree_open()
  -- Simple and reliable method: check all windows for NERDTree
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    
    -- Check buffer name pattern
    if bufname:match("NERD_tree_") then
      return true
    end
    
    -- Also check filetype with error handling
    local success, filetype = pcall(vim.api.nvim_buf_get_option, buf, 'filetype')
    if success and filetype == "nerdtree" then
      return true
    end
  end
  return false
end

function _G.find_current_file_in_nerdtree()
  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    vim.cmd("NERDTreeFind")
    return true
  end
  return false
end

function _G.toggle_nerdtree_with_refresh()
  -- Behaviour:
  -- 1. If NERDTree is visible and the cursor is currently inside it, close it.
  -- 2. If NERDTree is visible but the cursor is in another window, jump to it.
  -- 3. If NERDTree is not visible, open it with NERDTreeFind and leave focus
  --    inside the tree.

  local function is_nerdtree_buffer(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    return name:match("NERD_tree_") ~= nil
  end

  if is_nerdtree_open() then
    local current_buf = vim.api.nvim_get_current_buf()
    if is_nerdtree_buffer(current_buf) then
      -- We are already in the tree -> close it (toggle behaviour)
      vim.cmd("NERDTreeClose")
    else
      -- Tree is open elsewhere → jump to its window
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if is_nerdtree_buffer(buf) then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
    end
    return
  end

  -- NERDTree not open → open and reveal current file
  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    vim.cmd("NERDTreeFind")
  else
    vim.cmd("NERDTree")
  end
end

-- NERDTree behaviour ------------------------------------------------
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeIgnore = { "^node_modules$", "^\\.git$", "^\\.DS_Store$" }
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1

-- NERDTree Tabs configuration
vim.g.nerdtree_tabs_open_on_console_startup = 0
vim.g.nerdtree_tabs_focus_on_files = 1
vim.g.nerdtree_tabs_meaningful_tab_names = 1

-- Auto-refresh NERDTree when files change
vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
  callback = function()
    -- Use pcall to safely check if NERDTree is open and refresh it
    local success, result = pcall(function()
      if is_nerdtree_open() then
        vim.cmd("silent! NERDTreeRefreshRoot")
      end
    end)
    if not success then
      -- If there's an error, silently ignore it to prevent spam
      -- This can happen during startup or plugin loading
    end
  end,
})

-- Fallback keybinding for NERDTree toggle (in case main one fails)
vim.keymap.set("n", "<leader>D", ":NERDTreeToggle<CR>", opts)

-- Refresh NERDTree root to the directory of the current file --------
local function nerdtree_refresh_root()
  local current_file = vim.fn.expand("%:p")
  if is_nerdtree_open() then
    vim.cmd("NERDTreeClose")
  end
  if current_file ~= "" then
    vim.cmd("NERDTree " .. vim.fn.fnameescape(vim.fn.fnamemodify(current_file, ":h")))
  else
    vim.cmd("NERDTree")
  end
  -- Return focus to the previously active window
  vim.cmd("wincmd p")
end
vim.keymap.set("n", "<leader>r", nerdtree_refresh_root, opts)

---------------------------------------------------------------------
-- CoC Global Variables --------------------------------------------
---------------------------------------------------------------------
vim.g.coc_start_at_startup = 1
vim.g.coc_global_extensions = {
  "coc-tsserver",
  "coc-html",
  "coc-css",
  "coc-emmet",
  "coc-prettier",
  "coc-eslint",
  "coc-pyright",
  "coc-json",
  "coc-yaml",
  "coc-snippets",
}
vim.g.coc_service_startup_timeout = 30000
vim.g.coc_default_semantic_highlight_groups = 1

---------------------------------------------------------------------
-- CoC Helpers ------------------------------------------------------
---------------------------------------------------------------------
local function coc_setup()
  vim.g.coc_disable_startup_warning = 1
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "html", "css", "less", "handlebars", "python" },
    callback = function()
      vim.api.nvim_buf_create_user_command(0, "Format", function()
        vim.fn["CocAction"]("format")
      end, {})
    end,
  })
end
vim.api.nvim_create_autocmd("VimEnter", { callback = coc_setup })

-- Check LS status and enable embedded languages -------------------
local function check_language_server_status()
  if vim.g.coc_service_initialized == 1 then
    vim.fn["coc#config"]("languageserver.html.initializationOptions.embeddedLanguages.css", true)
    vim.fn["coc#config"]("languageserver.html.initializationOptions.embeddedLanguages.javascript", true)
  end
end
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.timer_start(3000, check_language_server_status, { ["repeat"] = 6 })
  end,
})

-- Simplified Handlebars setup: just set the filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.hbs", "*.handlebars" },
  callback = function()
    vim.bo.filetype = "handlebars"
  end,
})

-- Associate filetypes ---------------------------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.less" },
  callback = function()
    vim.bo.filetype = "less"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tsx" },
  callback = function()
    vim.bo.filetype = "typescriptreact"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.jsx" },
  callback = function()
    vim.bo.filetype = "javascriptreact"
  end,
})

-- Enhanced web language indentation settings -----------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { 
    "html", "css", "less", "scss", "sass", "javascript", "javascriptreact", 
    "typescript", "typescriptreact", "vue", "json", "jsonc", "handlebars", "yaml"
  },
  callback = function()
    -- Web files typically use 2-space indentation
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
    
    -- Enhanced JavaScript/TypeScript specific settings
    if vim.bo.filetype:match("javascript") or vim.bo.filetype:match("typescript") then
      vim.bo.cindent = true
      -- Set JavaScript-specific indentation rules
      vim.bo.cinoptions = "j1,(0,ws,Ws,g0,t0"
      -- j1: Indent Java/JavaScript anonymous functions
      -- (0: Align with opening parenthesis
      -- ws: Indent after opening parenthesis if it's the last character
      -- Ws: Indent after opening parenthesis if it's not the last character
      -- g0: No extra indent for C++ scope declarations
      -- t0: No extra indent for function return type
    end
  end,
})

-- Python-specific settings ----------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
    vim.bo.cindent = false  -- Python doesn't need C-style indentation
    vim.bo.fileformat = "unix"
    -- PEP 8 compliance
    vim.wo.colorcolumn = "79"
    -- Python-specific keymaps
    vim.keymap.set("n", "<leader>pb", ":!python %<CR>", { buffer = true, desc = "Run Python file" })
    vim.keymap.set("n", "<leader>pf", ":Black<CR>", { buffer = true, desc = "Format with Black" })
    vim.keymap.set("n", "<leader>pi", ":Isort<CR>", { buffer = true, desc = "Sort imports" })
  end,
})

-- Enhanced indentation for specific languages --------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "vim" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Special handling for markdown and text files -------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
})

-- Global indentation helper functions -----------------------------
-- Function to fix indentation for the entire buffer
local function fix_indentation()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! gg=G")
  vim.fn.winrestview(view)
  print("Indentation fixed for entire buffer")
end

-- Function to set indentation to 2 spaces
local function set_indent_2()
  vim.bo.tabstop = 2
  vim.bo.softtabstop = 2
  vim.bo.shiftwidth = 2
  vim.bo.expandtab = true
  print("Indentation set to 2 spaces")
end

-- Function to set indentation to 4 spaces
local function set_indent_4()
  vim.bo.tabstop = 4
  vim.bo.softtabstop = 4
  vim.bo.shiftwidth = 4
  vim.bo.expandtab = true
  print("Indentation set to 4 spaces")
end

-- Add keymaps for indentation helpers
vim.keymap.set("n", "<leader>if", fix_indentation, { desc = "Fix indentation for entire buffer" })
vim.keymap.set("n", "<leader>i2", set_indent_2, { desc = "Set indentation to 2 spaces" })
vim.keymap.set("n", "<leader>i4", set_indent_4, { desc = "Set indentation to 4 spaces" })

-- Enhanced Enter key behavior for better indentation
vim.keymap.set("i", "<CR>", function()
  -- Get current line and its indentation
  local line = vim.api.nvim_get_current_line()
  local indent = line:match("^%s*")
  
  -- Check if we're in a JavaScript-like language
  local ft = vim.bo.filetype
  if ft:match("javascript") or ft:match("typescript") or ft:match("vue") then
    -- If line ends with opening brace, add extra indent
    if line:match("{%s*$") then
      return "<CR>" .. indent .. string.rep(" ", vim.bo.shiftwidth)
    -- If line ends with opening parenthesis or bracket, add extra indent
    elseif line:match("[(%[]%s*$") then
      return "<CR>" .. indent .. string.rep(" ", vim.bo.shiftwidth)
    end
  end
  
  -- Default behavior with smart indentation
  return "<CR>"
end, { expr = true, desc = "Smart Enter with indentation" })

-- User Commands ----------------------------------------------------
---------------------------------------------------------------------
vim.keymap.set("n", "<leader>cr", ":CocRestart<CR>", opts)

-- Python development commands -------------------------------------
vim.api.nvim_create_user_command("PyTest", function()
  vim.cmd("botright new | terminal python -m pytest")
end, { desc = "Run pytest in terminal" })

vim.api.nvim_create_user_command("PyREPL", function()
  vim.cmd("botright vnew | terminal python")
end, { desc = "Open Python REPL" })

vim.keymap.set("n", "<leader>pt", ":PyTest<CR>", opts)
vim.keymap.set("n", "<leader>pr", ":PyREPL<CR>", opts)