---------------------------------------------------------------------
-- CoC global variables ---------------------------------------------
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
vim.g.coc_service_startup_timeout      = 30000
vim.g.coc_default_semantic_highlight_groups = 1

---------------------------------------------------------------------
-- CoC setup --------------------------------------------------------
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

-- Enable embedded language support once the language server initialises
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

---------------------------------------------------------------------
-- Filetype associations --------------------------------------------
---------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.hbs", "*.handlebars" },
  callback = function() vim.bo.filetype = "handlebars" end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.less" },
  callback = function() vim.bo.filetype = "less" end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tsx" },
  callback = function() vim.bo.filetype = "typescriptreact" end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.jsx" },
  callback = function() vim.bo.filetype = "javascriptreact" end,
})

---------------------------------------------------------------------
-- CoC keymap -------------------------------------------------------
---------------------------------------------------------------------
vim.keymap.set("n", "<leader>cr", ":CocRestart<CR>", { noremap = true, silent = true })
