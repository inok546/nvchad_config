
local M = {}

-- Пара тем под светлую/тёмную
local THEMES = {
  dark  = "nightfox",
  light = "one_light", -- замени при желании на onenord_light / everforest_light и т.п.
}

-- гарантируем, что base46 знает путь к кешу (обычно NvChad сам это ставит)
if not vim.g.base46_cache then
  vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
end

local function reload_base46()
  local ok, base46 = pcall(require, "base46")
  if not ok then return end
  base46.load_all_highlights()               -- правильный вызов для v3.0
  dofile(vim.g.base46_cache .. "defaults")   -- как в доке UI
  dofile(vim.g.base46_cache .. "statusline") -- "
end

local function apply(theme, bg)
  if bg then vim.o.background = bg end
  if vim.g.nvchad_theme == theme then return end

  -- синхронизируем NvChad, чтобы дальше всё компилилось в нужную тему
  vim.g.nvchad_theme = theme
  pcall(function() require("nvconfig").base46.theme = theme end)

  reload_base46()
end

function M.setup()
  require("auto-dark-mode").setup({
    update_interval = 1000,
    fallback = "dark",
    set_dark_mode  = function() apply(THEMES.dark,  "dark")  end,
    set_light_mode = function() apply(THEMES.light, "light") end,
  })

  -- первичная покраска, если автоопределение ещё не сработало
  vim.schedule(function()
    if vim.o.background == "light" then
      apply(THEMES.light, "light")
    else
      apply(THEMES.dark, "dark")
    end
  end)
end

return M

