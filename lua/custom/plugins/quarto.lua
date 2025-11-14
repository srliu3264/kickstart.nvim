-- plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
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
  },
}
