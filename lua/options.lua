require "nvchad.options"

vim.o.cursorlineopt ='both'

vim.opt.relativenumber = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- for mini.surround
vim.keymap.set({ "n", "x" }, "s", "<Nop>", { desc = "mini.surround prefix" })

-- generate Markdown with mappings
vim.api.nvim_create_user_command("DumpKeymaps", function() require("utils.dump_keymaps").run() end, {})

