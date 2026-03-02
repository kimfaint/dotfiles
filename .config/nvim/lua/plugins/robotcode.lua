return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      robotcode = {
        cmd = function(dispatchers, config)
          local pythonpath = vim.env.PYTHONPATH or ""
          local local_cmd
          if vim.uv.fs_stat(config.root_dir .. "/uv.lock") then
            local_cmd = { "sh", "-c", string.format("DOC_ONLY=1 PYTHONPATH=%s uv --directory %s run robotcode --log --log-level TRACE language-server", pythonpath, config.root_dir) }
          elseif vim.uv.fs_stat(config.root_dir .. "/poetry.lock") then
            local_cmd = { "sh", "-c", string.format("DOC_ONLY=1 PYTHONPATH=%s poetry --directory %s run robotcode --log --log-level TRACE language-server", pythonpath, config.root_dir) }
          else
            local_cmd = { "sh", "-c", string.format("DOC_ONLY=1 PYTHONPATH=%s robotcode --log --log-level TRACE language-server", pythonpath) }
          end
          return vim.lsp.rpc.start(local_cmd, dispatchers)
        end,
      },
    },
  },
}
