# Neovim Configuration Setup Guide

This guide will help you set up Neovim with the included Lua configuration on both Windows 11 and Linux systems. This modern setup uses Packer as the plugin manager and includes various plugins for syntax highlighting, LSP-based code completion, file navigation, Git integration, and more.

## Prerequisites

### Common Requirements (Both Windows and Linux)
- [Neovim](https://neovim.io/) (version 0.8.0 or later recommended)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for CoC and related plugins)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- A terminal with a [Nerd Font](https://www.nerdfonts.com/) for icons
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for FZF text searching)

## Installation

### Linux

1. **Install Neovim:**
   ```bash
   # For Ubuntu/Debian
   sudo apt update
   sudo apt install neovim

   # For Arch Linux
   sudo pacman -S neovim

   # For Fedora
   sudo dnf install neovim
   ```

2. **Install ripgrep (for FZF searching):**
   ```bash
   # For Ubuntu/Debian
   sudo apt install ripgrep

   # For Arch Linux
   sudo pacman -S ripgrep

   # For Fedora
   sudo dnf install ripgrep
   ```

3. **Create Configuration Directory:**
   ```bash
   mkdir -p ~/.config/nvim/lua/config
   ```

4. **Clone or Copy Configuration Files:**
   Copy all files preserving the directory structure (see [Configuration Structure](#configuration-structure) below).

5. **Install Language Servers:**
   ```bash
   # HTML + CSS + JSON + ESLint language servers
   # (vscode-html-language-server and vscode-css-language-server
   # are NOT standalone packages — they ship together in this bundle)
   sudo npm install -g vscode-langservers-extracted

   # TypeScript language server
   sudo npm install -g typescript typescript-language-server
   ```

6. **Open Neovim and Install Plugins:**
   ```bash
   nvim
   ```
   Packer will automatically bootstrap itself on first run. After opening Neovim, run:
   ```
   :PackerSync
   ```

7. **Install CoC Extensions:**
   The configuration automatically installs CoC extensions, but you can manually install them with:
   ```
   :CocInstall coc-tsserver coc-html coc-css coc-emmet coc-prettier
   ```

### Windows 11

1. **Install Neovim:**
   - Download the latest release from [Neovim's GitHub](https://github.com/neovim/neovim/releases/latest)
   - Extract and add the binary to your PATH

   Alternatively, use a package manager like Chocolatey:
   ```powershell
   choco install neovim
   ```
   Or Scoop:
   ```powershell
   scoop install neovim
   ```

2. **Install ripgrep:**
   ```powershell
   # Using Chocolatey
   choco install ripgrep

   # Using Scoop
   scoop install ripgrep
   ```

3. **Create Configuration Directory:**
   ```powershell
   mkdir -p ~/AppData/Local/nvim/lua/config
   ```

4. **Clone or Copy Configuration Files:**
   Copy all files preserving the directory structure (see [Configuration Structure](#configuration-structure) below).

5. **Install Language Servers:**
   ```powershell
   # vscode-langservers-extracted bundles the HTML, CSS, JSON, and ESLint servers
   npm install -g vscode-langservers-extracted typescript typescript-language-server
   ```

6. **Open Neovim and Install Plugins:**
   ```powershell
   nvim
   ```
   Packer will automatically bootstrap itself on first run. After opening Neovim, run:
   ```
   :PackerSync
   ```

7. **Install CoC Extensions:**
   ```
   :CocInstall coc-tsserver coc-html coc-css coc-emmet coc-prettier
   ```

---

## Configuration Structure

The configuration is split into focused modules under `lua/config/`. Each file is responsible for one concern.

```
~/.config/nvim/
├── init.lua                  ← Entry point: loads all modules in order
├── coc-settings.json         ← CoC language server settings
└── lua/config/
    ├── options.lua           ← Editor options (indentation, line numbers, clipboard…)
    ├── plugins.lua           ← Packer bootstrap + all plugin declarations
    ├── plugin_config.lua     ← Setup calls for: transparent, treesitter, gitsigns,
    │                           presence, autoclose, autotag, bufferline
    ├── appearance.lua        ← Colorscheme (gruvbox-material) + transparency highlights
    ├── nerdtree.lua          ← NERDTree helper functions, settings, and keymaps
    ├── coc.lua               ← CoC settings, setup, and filetype associations
    ├── autocmds.lua          ← FileType indentation rules, indent helpers, user commands
    └── keymaps.lua           ← All general keymaps
```

To add a new plugin: declare it in `plugins.lua`, configure it in `plugin_config.lua`, then run `:PackerSync`.

---

## Included Plugins

### Core Functionality
- **Packer.nvim**: Plugin manager with automatic bootstrapping
- **CoC.nvim**: LSP-based completion and language server integration

### Language Support
- **vim-javascript**: JavaScript syntax highlighting
- **JavaScript-Indent**: Better JavaScript indentation
- **typescript-vim**: TypeScript syntax highlighting
- **vim-vue** / **vim-vue-plugin**: Vue.js component support
- **vim-mustache-handlebars**: Handlebars template support
- **html5.vim**: HTML5 syntax and omnicomplete
- **vim-css3-syntax**: CSS3 syntax highlighting
- **vim-less**: Less CSS preprocessor support
- **ap/vim-css-color**: Inline colour previews in CSS files
- **vim-polyglot**: Language pack for many languages
- **vim-terraform** / **vim-terraform-completion**: Terraform support

### Python Development
- **vim-python/python-syntax**: Enhanced Python syntax
- **vim-python-pep8-indent**: PEP 8 compliant indentation
- **vim-autopep8**: Auto-format with autopep8
- **black**: Opinionated Python formatter
- **vim-isort**: Sort Python imports
- **indentpython.vim**: Python-specific indentation

### Developer Tools
- **nvim-treesitter**: Modern syntax highlighting and code parsing
- **nvim-ts-autotag**: Auto-close and auto-rename HTML/XML tags
- **emmet-vim**: HTML/CSS abbreviation expansion
- **vim-prettier**: Code formatting with Prettier
- **syntastic**: Syntax checking
- **autoclose.nvim**: Auto-close brackets and quotes
- **indent-blankline.nvim**: Visual indentation guides

### Git Integration
- **vim-fugitive**: Full Git wrapper
- **gitsigns.nvim**: Git signs in the gutter with hunk actions

### UI & Navigation
- **fzf** & **fzf.vim**: Fuzzy file and text finder
- **vim-airline**: Status line
- **NERDTree**: File explorer sidebar
- **vim-devicons** / **nvim-web-devicons**: File type icons
- **vim-nerdtree-tabs**: NERDTree tab integration
- **bufferline.nvim**: Buffer tabs displayed at the top of the screen

### Editing Helpers
- **vim-surround**: Change/add/delete surrounding characters
- **vim-closetag**: Auto-close HTML tags
- **autoclose.nvim**: Auto-close brackets and quotes

### Appearance
- **gruvbox-material**: Default colorscheme (hard dark background)
- **nightfox.nvim**: Modern colorscheme alternative
- **awesome-vim-colorschemes**: Collection of colorschemes
- **transparent.nvim**: Terminal transparency support
- **neon**: Additional colorscheme option

### Other
- **presence.nvim**: Discord Rich Presence integration

---

## Key Mappings

The leader key is `,` (comma).

### General

| Key | Action |
|---|---|
| `,w` | Save file |
| `ii` | Exit insert mode (alternative to Escape) |
| `Space` | Toggle fold (normal) / Create fold (visual) |
| `Ctrl+Z` / `Ctrl+Y` | Undo / Redo (works in insert mode too) |

### Buffer Tabs (bufferline)

| Key | Action |
|---|---|
| `Tab` | Next tab |
| `Shift+Tab` | Previous tab |
| `,1` – `,9` | Jump to tab by position |
| `,bp` | Pick tab interactively (shows a letter on each) |
| `,bc` | Pick-to-close a tab |
| `:bd` | Close current buffer |

### File Navigation

| Key | Action |
|---|---|
| `,d` | Toggle NERDTree (smart: open/focus/close) |
| `,D` | Toggle NERDTree (simple fallback) |
| `,nf` | Reveal current file in NERDTree |
| `,r` | Re-root NERDTree to current file's directory |
| `,f` | Fuzzy find files (FZF) |
| `,g` | Ripgrep text search |
| `,s` | CoC search |

### NERDTree File Opening

| NERDTree key | Result |
|---|---|
| `Enter` / `o` | Open file → active bufferline tab |
| `s` | Open in vertical split |
| `i` | Open in horizontal split |

### Window Navigation

| Key | Action |
|---|---|
| `Ctrl+h/j/k/l` | Move between splits |

### Terminal

| Key | Action |
|---|---|
| `,tv` | Open terminal in vertical split |
| `,th` | Open terminal in horizontal split |
| `Esc` | Exit terminal mode |

### Indentation Helpers

| Key | Action |
|---|---|
| `,if` | Fix indentation for entire buffer (`gg=G`) |
| `,i2` | Set indentation to 2 spaces |
| `,i4` | Set indentation to 4 spaces |

### CoC (Language Server)

| Key | Action |
|---|---|
| `,cr` | Restart CoC server |

### Python

| Key | Action |
|---|---|
| `,pb` | Run current file with Python |
| `,pf` | Format with Black |
| `,pi` | Sort imports with isort |
| `,pt` | Run pytest in a terminal |
| `,pr` | Open Python REPL |

### Git / Gitsigns

| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `,hp` | Preview hunk |
| `,hs` | Stage hunk |
| `,hu` | Undo stage hunk |
| `,hr` | Reset hunk |
| `,hb` | Toggle current line blame |

### Vim-Fugitive

| Key | Action |
|---|---|
| `,gs` | Git status |
| `,gc` | Git commit |
| `,gd` | Git diff |
| `,gb` | Git blame |
| `,gl` | Git log |
| `,gp` | Git push |
| `,gf` | Git fetch |
| `,gpl` | Git pull |

### Discord Presence

| Key | Action |
|---|---|
| `,dp` | Update Discord presence manually |

---

## Troubleshooting

### Common Issues

1. **Missing Icons**
   - Install and configure a [Nerd Font](https://www.nerdfonts.com/) and set your terminal to use it.

2. **`npm ERR! 404` on `vscode-html-language-server` / `vscode-css-language-server`**
   - These are not standalone npm packages. Install `vscode-langservers-extracted` instead — it bundles the HTML, CSS, JSON, and ESLint servers in one package.

3. **BufferLine commands not found (`E492`)**
   - Run `:PackerSync` to install bufferline.nvim, then restart Neovim.

4. **CoC Language Server Issues**
   - Restart with `,cr` or check `:CocInfo`
   - Run `:checkhealth` for diagnostics

5. **Packer Plugin Issues**
   - Run `:PackerSync` to update and clean plugins
   - If plugins fail: `:PackerClean` then `:PackerInstall`
   - Delete `plugin/packer_compiled.lua` and restart if compilation errors occur

6. **Treesitter Issues**
   - Broken highlighting: `:TSUpdate`
   - Missing parser: `:TSInstall <language>`

7. **Transparency Issues**
   - Check if your terminal supports background transparency
   - Disable by commenting out the transparent plugin config in `lua/config/plugin_config.lua`

8. **Windows-specific Issues**
   - Ensure all binaries are in PATH
   - Run terminal as administrator if needed
   - PowerShell: `Set-ExecutionPolicy RemoteSigned`

---

## Updating

| What | Command |
|---|---|
| Plugins | `:PackerSync` |
| CoC extensions | `:CocUpdate` |
| Treesitter parsers | `:TSUpdate` |
| Neovim (Linux) | Use your package manager |
| Neovim (Windows) | `choco upgrade neovim` or `scoop update neovim` |
