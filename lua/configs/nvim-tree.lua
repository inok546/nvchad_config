require('nvim-tree').setup {
  filters = {
    dotfiles = false, -- Показать скрытые файлы
    custom = { "^.git$" } -- Исключить директорию .git
  },
}
