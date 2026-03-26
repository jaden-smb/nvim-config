-- Gruvbox material must be configured before the colorscheme loads
vim.g.gruvbox_material_background        = "hard"
vim.g.gruvbox_material_enable_italic     = 1
vim.g.gruvbox_material_better_performance = 1

local colorscheme = "gruvbox-material"
local ok = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.cmd("colorscheme default")
end

-- Force transparent backgrounds on top of whatever theme is active
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
