local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

---------------------------------------------------------------------
-- Basic ------------------------------------------------------------
---------------------------------------------------------------------
map("n", "<leader>w", ":w<CR>", opts)
map("i", "ii", "<Esc>", opts)

---------------------------------------------------------------------
-- Folding ----------------------------------------------------------
---------------------------------------------------------------------
map("n", "<Space>", function()
  return vim.fn.foldlevel(".") ~= 0 and "za" or "<Space>"
end, { expr = true })
map("v", "<Space>", "zf", opts)

---------------------------------------------------------------------
-- Plugin ops -------------------------------------------------------
---------------------------------------------------------------------
map("n", "<leader>s", ":CocSearch ", { noremap = true })

map("n", "<leader>f", function()
  vim.cmd("Files")
  vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
      vim.defer_fn(function()
        if is_nerdtree_open() then find_current_file_in_nerdtree() end
        if vim.fn.exists("g:NERDTree") == 1 then
          vim.cmd("silent! doautocmd WinEnter")
        end
      end, 50)
    end,
  })
end, opts)

map("n", "<leader>g", function()
  vim.cmd("Rg")
  vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
      vim.defer_fn(function()
        if is_nerdtree_open() then find_current_file_in_nerdtree() end
      end, 50)
    end,
  })
end, opts)

map("n", "<leader>d", function() toggle_nerdtree_with_refresh() end, opts)
map("n", "<leader>nf", function()
  if not find_current_file_in_nerdtree() then
    print("No file currently open or file not found")
  end
end, { noremap = true, silent = false, desc = "Find current file in NERDTree" })

map("n", "<leader><CR>", "<CR><C-w>h:q<CR>", opts)

---------------------------------------------------------------------
-- Terminals --------------------------------------------------------
---------------------------------------------------------------------
map("n", "<leader>tv", ":botright vnew | terminal<CR>", opts)
map("n", "<leader>th", ":botright new | terminal<CR>",  opts)
map("t", "<Esc>", [[<C-\><C-n>]], opts)

---------------------------------------------------------------------
-- Window navigation ------------------------------------------------
---------------------------------------------------------------------
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

---------------------------------------------------------------------
-- Undo / Redo ------------------------------------------------------
---------------------------------------------------------------------
map("n", "<C-Z>", "u")
map("n", "<C-Y>", "<C-R>")
map("i", "<C-Z>", "<C-O>u")
map("i", "<C-Y>", "<C-O><C-R>")

---------------------------------------------------------------------
-- Git / Gitsigns ---------------------------------------------------
---------------------------------------------------------------------
map("n", "]h", ":Gitsigns next_hunk<CR>",                opts)
map("n", "[h", ":Gitsigns prev_hunk<CR>",                opts)
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>",     opts)
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>",       opts)
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>",  opts)
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>",       opts)
map("n", "<leader>hb", ":Gitsigns toggle_current_line_blame<CR>", opts)

---------------------------------------------------------------------
-- Vim-Fugitive -----------------------------------------------------
---------------------------------------------------------------------
map("n", "<leader>gs",  ":Git<CR>")
map("n", "<leader>gc",  ":Git commit<CR>")
map("n", "<leader>gd",  ":Gdiff<CR>")
map("n", "<leader>gb",  ":Git blame<CR>")
map("n", "<leader>gl",  ":Git log<CR>")
map("n", "<leader>gp",  ":Git push<CR>")
map("n", "<leader>gf",  ":Git fetch<CR>")
map("n", "<leader>gpl", ":Git pull<CR>")

---------------------------------------------------------------------
-- Buffer tabs (bufferline) -----------------------------------------
---------------------------------------------------------------------
map("n", "<Tab>",   ":BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<leader>x", function()             -- close current buffer, keep window
  local bd = require("bufferline.commands").unpin_and_close
  local ok = pcall(bd)
  if not ok then vim.cmd("bdelete!") end
end, { desc = "Close buffer" })
-- Jump to tab by ordinal number (,1 … ,9)
for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    require("bufferline").go_to(i, true)
  end, { desc = "Go to tab " .. i })
end
map("n", "<leader>bp", ":BufferLinePick<CR>",      opts)  -- pick by letter
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)  -- pick-to-close

---------------------------------------------------------------------
-- Discord Presence -------------------------------------------------
---------------------------------------------------------------------
map("n", "<leader>dp", function()
  if pcall(require, "presence") then
    vim.cmd("lua require('presence'):update()")
    print("Discord presence updated")
  else
    print("Discord presence not available")
  end
end, { desc = "Update Discord presence" })
