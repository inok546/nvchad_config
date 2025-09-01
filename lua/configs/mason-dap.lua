local mason_dap = require "mason-nvim-dap"

require("dap").set_log_level "INFO"

mason_dap.setup {
  ensure_installed = {
    "codelldb",
  },
  handlers = {
    function(config)
      mason_dap.default_setup(config)
    end,
    codelldb = function(config)
      config.adapters = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      config.configurations = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            vim.cmd "write"

            local file = vim.fn.expand "%:p"
            local ft = vim.bo.filetype or ""
            local ext = vim.fn.expand "%:e"

            -- Выбор компилятора и стандарта "как в run.lua"
            local cc, std
            if ft == "c" or ext == "c" then
              cc, std = "gcc", "c17"
            else
              cc, std = "clang++", "c++20"
            end

            -- tmp-директория (кросс-платформенно для GNU/BusyBox mktemp)
            local td = vim.fn.systemlist("mktemp -d 2>/dev/null || mktemp -d -t nvim")[1]
            if not td or td == "" then
              td = "/tmp"
            end

            local out = td .. "/a.out"

            -- Сборка с отладочной инфой (-g), варнинги и линк math (-lm)
            local cmd = string.format(
              "silent !%s %s -g -O0 -Wall -Wextra -Werror -std=%s -lm -o %s",
              cc,
              vim.fn.shellescape(file),
              std,
              vim.fn.shellescape(out)
            )
            vim.cmd(cmd)

            return out
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
      }
      require("mason-nvim-dap").default_setup(config) -- don't forget this!
    end,
  },
}
