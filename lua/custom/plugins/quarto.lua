-- plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = 'all',
        languages = { 'r', 'python', 'rust' },
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        -- NOTE: setup your own keymaps:
        hover = 'H',
        definition = 'gd',
        rename = '<leader>rn',
        references = 'gr',
        format = '<leader>gf',
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten', -- "molten", "slime", "iron" or <function>
        --ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        -- never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
      },
    },
    config = function(_, opts)
      -- Apply your opts
      require('quarto').setup(opts)

      -- Safely load the runner
      local ok, runner = pcall(require, 'quarto.runner')
      if not ok then
        return
      end

      -- Helper to set buffer-local maps
      local function set_maps(bufnr)
        local base = { buffer = bufnr, silent = true }

        vim.keymap.set('n', '<localleader>rc', runner.run_cell, vim.tbl_extend('keep', { desc = 'run cell' }, base))

        vim.keymap.set('n', '<localleader>ra', runner.run_above, vim.tbl_extend('keep', { desc = 'run cell and above' }, base))

        vim.keymap.set('n', '<localleader>rA', runner.run_all, vim.tbl_extend('keep', { desc = 'run all cells' }, base))

        vim.keymap.set('n', '<localleader>rl', runner.run_line, vim.tbl_extend('keep', { desc = 'run line' }, base))

        vim.keymap.set('v', '<localleader>r', runner.run_range, vim.tbl_extend('keep', { desc = 'run visual range' }, base))

        vim.keymap.set('n', '<localleader>RA', function()
          runner.run_all(true)
        end, vim.tbl_extend('keep', { desc = 'run all cells (all langs)' }, base))
      end

      -- 1) Apply to CURRENT buffer if it’s already quarto/markdown
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo[bufnr].filetype
      if ft == 'quarto' or ft == 'markdown' then
        set_maps(bufnr)
      end

      -- 2) Apply to FUTURE quarto/markdown buffers
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'quarto', 'markdown' },
        callback = function(ev)
          set_maps(ev.buf)
        end,
      })
    end,
  },
}
