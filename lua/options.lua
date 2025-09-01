require "nvchad.options"

vim.o.shiftwidth = 4       -- ширина отступа для команды >>
vim.o.tabstop = 4          -- ширина таба
vim.o.softtabstop = 4      -- кол-во пробелов при нажатии <Tab>
vim.o.expandtab = true     -- использовать пробелы, не табы
vim.o.smartindent = true
vim.o.autoindent = true

vim.o.cursorlineopt ='both'

vim.opt.relativenumber = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- for mini.surround
vim.keymap.set({ "n", "x" }, "s", "<Nop>", { desc = "mini.surround prefix" })

-- generate Markdown with mappings
vim.api.nvim_create_user_command("DumpKeymaps", function() require("utils.dump_keymaps").run() end, {})

