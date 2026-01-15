return {
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("solarized-osaka").setup({
  --       styles = {
  --         floats = "transparent",
  --       },
  --     })
  --     -- vim.cmd([[colorscheme solarized-osaka]])
  --   end,
  -- },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        transparent = true,
      })
      vim.cmd([[colorscheme vscode]])
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       color_overrides = {
  --         mocha = {
  --           base = "#12121a",
  --           mantle = "#12121a",
  --           crust = "#12121a",
  --         },
  --       },
  --       transparent_background = true,
  --     })
  --     vim.cmd.colorscheme("catppuccin-mocha")
  --     vim.cmd("highlight TelescopeSelection cterm=bold gui=bold guifg=#a6e3a1 guibg=#181825")
  --   end,
  -- },
}
