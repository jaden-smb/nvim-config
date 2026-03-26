-- transparent.nvim
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

-- nvim-treesitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
  treesitter.setup({
    ensure_installed = {
      "html", "css", "scss", "javascript", "typescript", "tsx", "json", "jsonc",
      "python", "lua", "vim", "vimdoc", "yaml", "toml", "markdown", "vue",
      "bash", "dockerfile", "gitignore", "sql", "regex",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = { "yaml" },
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

-- gitsigns.nvim
local ok, gitsigns = pcall(require, "gitsigns")
if ok then
  gitsigns.setup({
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
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

-- presence.nvim (Discord Rich Presence)
local ok, presence = pcall(require, "presence")
if ok then
  presence:setup({
    auto_update         = true,
    neovim_image_text   = "The One True Text Editor",
    main_image          = "neovim",
    client_id           = "793271441293967371",
    log_level           = nil,
    debounce_timeout    = 10,
    show_time           = true,
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "secret_workspace",
    line_number_text    = "Line %s out of %s",
    terminal_text       = "Using Terminal",
  })
end

-- autoclose.nvim
local ok, autoclose = pcall(require, "autoclose")
if ok then
  autoclose.setup()
end

-- nvim-ts-autotag
local ok, autotag = pcall(require, "nvim-ts-autotag")
if ok then
  autotag.setup()
end

-- bufferline.nvim
local ok, bufferline = pcall(require, "bufferline")
if ok then
  bufferline.setup({
    options = {
      mode              = "buffers",
      numbers           = "ordinal",       -- show 1-based index on each tab
      close_command     = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command  = "buffer %d",
      diagnostics       = "coc",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      show_buffer_close_icons = true,
      show_close_icon         = false,
      separator_style         = "slant",   -- "slant" | "slope" | "thick" | "thin"
      always_show_bufferline  = true,
      offsets = {
        {
          filetype   = "nerdtree",
          text       = "File Explorer",
          text_align = "center",
          separator  = true,
        },
      },
    },
  })
end
