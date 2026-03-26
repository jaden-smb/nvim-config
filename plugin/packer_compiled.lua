-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jaden/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?.lua;/home/jaden/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?/init.lua;/home/jaden/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?.lua;/home/jaden/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jaden/.cache/nvim/packer_hererocks/2.1.1703358377/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["JavaScript-Indent"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/JavaScript-Indent",
    url = "https://github.com/vim-scripts/JavaScript-Indent"
  },
  ["autoclose.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/autoclose.nvim",
    url = "https://github.com/m4xshen/autoclose.nvim"
  },
  ["awesome-vim-colorschemes"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/awesome-vim-colorschemes",
    url = "https://github.com/rafi/awesome-vim-colorschemes"
  },
  black = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/black",
    url = "https://github.com/psf/black"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["coc-typescript-vue-plugin"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/coc-typescript-vue-plugin",
    url = "https://github.com/yaegassy/coc-typescript-vue-plugin"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  eslint = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/eslint",
    url = "https://github.com/eslint/eslint"
  },
  fzf = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n¥\2\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\4=\4\v\3B\1\2\1K\0\1\0\fexclude\14filetypes\1\0\0\1\v\0\0\thelp\nalpha\14dashboard\rneo-tree\fTrouble\tlazy\nmason\vnotify\15toggleterm\rlazyterm\nscope\1\0\5\fenabled\2\rpriority\3ô\3\23injected_languages\1\rshow_end\1\15show_start\2\vindent\1\0\0\1\0\2\rtab_char\bâ”‚\tchar\bâ”‚\nsetup\bibl\frequire\0" },
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["indentpython.vim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/indentpython.vim",
    url = "https://github.com/vim-scripts/indentpython.vim"
  },
  neon = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/neon",
    url = "https://github.com/rafamadriz/neon"
  },
  nerdtree = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["presence.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/presence.nvim",
    url = "https://github.com/andweeb/presence.nvim"
  },
  ["python-syntax"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/python-syntax",
    url = "https://github.com/vim-python/python-syntax"
  },
  syntastic = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/syntastic",
    url = "https://github.com/vim-syntastic/syntastic"
  },
  ["transparent.nvim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/transparent.nvim",
    url = "https://github.com/tribela/transparent.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-autopep8"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-autopep8",
    url = "https://github.com/tell-k/vim-autopep8"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-closetag",
    url = "https://github.com/alvan/vim-closetag"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-css-color",
    url = "https://github.com/ap/vim-css-color"
  },
  ["vim-css3-syntax"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-css3-syntax",
    url = "https://github.com/hail2u/vim-css3-syntax"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-isort"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-isort",
    url = "https://github.com/fisadev/vim-isort"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-less"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-less",
    url = "https://github.com/groenewege/vim-less"
  },
  ["vim-mustache-handlebars"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-mustache-handlebars",
    url = "https://github.com/mustache/vim-mustache-handlebars"
  },
  ["vim-nerdtree-tabs"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-nerdtree-tabs",
    url = "https://github.com/jistr/vim-nerdtree-tabs"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-prettier",
    url = "https://github.com/prettier/vim-prettier"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["vim-terraform-completion"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-terraform-completion",
    url = "https://github.com/juliosueiras/vim-terraform-completion"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-vue",
    url = "https://github.com/posva/vim-vue"
  },
  ["vim-vue-plugin"] = {
    loaded = true,
    path = "/home/jaden/.local/share/nvim/site/pack/packer/start/vim-vue-plugin",
    url = "https://github.com/leafOfTree/vim-vue-plugin"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n¥\2\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\4=\4\v\3B\1\2\1K\0\1\0\fexclude\14filetypes\1\0\0\1\v\0\0\thelp\nalpha\14dashboard\rneo-tree\fTrouble\tlazy\nmason\vnotify\15toggleterm\rlazyterm\nscope\1\0\5\fenabled\2\rpriority\3ô\3\23injected_languages\1\rshow_end\1\15show_start\2\vindent\1\0\0\1\0\2\rtab_char\bâ”‚\tchar\bâ”‚\nsetup\bibl\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
