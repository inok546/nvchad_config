return {
  formatters_by_ft = {
    lua = { "stylua" },
    
    cpp = { "clang-format" },
    c = { "clang-format" },

    json  = { "prettier" },
    jsonc = { "prettier" },
  },

  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}
