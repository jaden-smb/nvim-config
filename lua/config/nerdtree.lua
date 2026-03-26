---------------------------------------------------------------------
-- NERDTree global settings -----------------------------------------
---------------------------------------------------------------------
vim.g.NERDTreeQuitOnOpen      = 1
vim.g.NERDTreeIgnore          = { "^node_modules$", "^\\.git$", "^\\.DS_Store$" }
vim.g.NERDTreeShowHidden      = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI       = 1
vim.g.NERDTreeDirArrows       = 1

vim.g.nerdtree_tabs_open_on_console_startup = 0
vim.g.nerdtree_tabs_focus_on_files          = 1
vim.g.nerdtree_tabs_meaningful_tab_names    = 1

---------------------------------------------------------------------
-- Helper functions (global so keymaps.lua can reference them) ------
---------------------------------------------------------------------
function _G.is_nerdtree_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf):match("NERD_tree_") then
      return true
    end
    local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
    if ok and ft == "nerdtree" then
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
  local function is_nerdtree_buffer(bufnr)
    return vim.api.nvim_buf_get_name(bufnr):match("NERD_tree_") ~= nil
  end

  if is_nerdtree_open() then
    local current_buf = vim.api.nvim_get_current_buf()
    if is_nerdtree_buffer(current_buf) then
      vim.cmd("NERDTreeClose")
    else
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

  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    vim.cmd("NERDTreeFind")
  else
    vim.cmd("NERDTree")
  end
end

---------------------------------------------------------------------
-- Auto-refresh NERDTree when files change --------------------------
---------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    pcall(function()
      if is_nerdtree_open() then
        vim.cmd("silent! NERDTreeRefreshRoot")
      end
    end)
  end,
})

---------------------------------------------------------------------
-- NERDTree keymaps -------------------------------------------------
---------------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>D", ":NERDTreeToggle<CR>", opts)

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
  vim.cmd("wincmd p")
end

vim.keymap.set("n", "<leader>r", nerdtree_refresh_root, opts)
