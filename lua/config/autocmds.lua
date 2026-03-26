---------------------------------------------------------------------
-- Filetype-specific indentation ------------------------------------
---------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html", "css", "less", "scss", "sass", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "vue", "json", "jsonc", "handlebars", "yaml",
  },
  callback = function()
    vim.bo.tabstop     = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth  = 2
    vim.bo.expandtab   = true
    vim.bo.autoindent  = true
    vim.bo.smartindent = true

    if vim.bo.filetype:match("javascript") or vim.bo.filetype:match("typescript") then
      vim.bo.cindent    = true
      vim.bo.cinoptions = "j1,(0,ws,Ws,g0,t0"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop     = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth  = 4
    vim.bo.expandtab   = true
    vim.bo.autoindent  = true
    vim.bo.smartindent = true
    vim.bo.cindent     = false
    vim.bo.fileformat  = "unix"
    vim.wo.colorcolumn = "79"

    local buf_opts = { buffer = true }
    vim.keymap.set("n", "<leader>pb", ":!python %<CR>",  vim.tbl_extend("force", buf_opts, { desc = "Run Python file" }))
    vim.keymap.set("n", "<leader>pf", ":Black<CR>",      vim.tbl_extend("force", buf_opts, { desc = "Format with Black" }))
    vim.keymap.set("n", "<leader>pi", ":Isort<CR>",      vim.tbl_extend("force", buf_opts, { desc = "Sort imports" }))
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "vim" },
  callback = function()
    vim.bo.tabstop     = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth  = 2
    vim.bo.expandtab   = true
    vim.bo.autoindent  = true
    vim.bo.smartindent = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.bo.tabstop     = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth  = 2
    vim.bo.expandtab   = true
    vim.wo.wrap        = true
    vim.wo.linebreak   = true
  end,
})

---------------------------------------------------------------------
-- Indentation helper functions + keymaps --------------------------
---------------------------------------------------------------------
local function fix_indentation()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! gg=G")
  vim.fn.winrestview(view)
  print("Indentation fixed for entire buffer")
end

local function set_indent_2()
  vim.bo.tabstop = 2; vim.bo.softtabstop = 2
  vim.bo.shiftwidth = 2; vim.bo.expandtab = true
  print("Indentation set to 2 spaces")
end

local function set_indent_4()
  vim.bo.tabstop = 4; vim.bo.softtabstop = 4
  vim.bo.shiftwidth = 4; vim.bo.expandtab = true
  print("Indentation set to 4 spaces")
end

vim.keymap.set("n", "<leader>if", fix_indentation, { desc = "Fix indentation for entire buffer" })
vim.keymap.set("n", "<leader>i2", set_indent_2,    { desc = "Set indentation to 2 spaces" })
vim.keymap.set("n", "<leader>i4", set_indent_4,    { desc = "Set indentation to 4 spaces" })

---------------------------------------------------------------------
-- Smart Enter with indentation ------------------------------------
---------------------------------------------------------------------
vim.keymap.set("i", "<CR>", function()
  local line   = vim.api.nvim_get_current_line()
  local indent = line:match("^%s*")
  local ft     = vim.bo.filetype

  if ft:match("javascript") or ft:match("typescript") or ft:match("vue") then
    if line:match("{%s*$") or line:match("[(%[]%s*$") then
      return "<CR>" .. indent .. string.rep(" ", vim.bo.shiftwidth)
    end
  end

  return "<CR>"
end, { expr = true, desc = "Smart Enter with indentation" })

---------------------------------------------------------------------
-- Python user commands + keymaps ----------------------------------
---------------------------------------------------------------------
vim.api.nvim_create_user_command("PyTest", function()
  vim.cmd("botright new | terminal python -m pytest")
end, { desc = "Run pytest in terminal" })

vim.api.nvim_create_user_command("PyREPL", function()
  vim.cmd("botright vnew | terminal python")
end, { desc = "Open Python REPL" })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>pt", ":PyTest<CR>", opts)
vim.keymap.set("n", "<leader>pr", ":PyREPL<CR>", opts)
