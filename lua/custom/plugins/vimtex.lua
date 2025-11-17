return {
  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_compiler_latexmk = {
        executable = 'latexmk',
        options = {
          '-pdf',
          '-interaction=nonstopmode',
          '-synctex=1',
          '-pvc',
        },
      }
    end,
  },
}
