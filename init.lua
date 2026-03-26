-- Compatibility: alias vim.uv to vim.loop for Neovim <0.10
if vim.uv == nil and vim.loop ~= nil then
  vim.uv = vim.loop
end

require("config.options")
require("config.plugins")
require("config.plugin_config")
require("config.appearance")
require("config.nerdtree")   -- defines _G helpers used by keymaps
require("config.coc")
require("config.autocmds")
require("config.keymaps")
