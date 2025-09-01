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
            local file = vim.fn.expand "%"
            local output = vim.fn.expand "%:p:r"
            local ft = vim.bo.filetype
            local cc = (ft == "c") and "clang" or "clang++"

            vim.cmd(
              string.format("silent !%s %s -g -O0 -fno-limit-debug-info -Wall -Wextra -Werror -o %s", cc, file, output)
            )
            return output
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
