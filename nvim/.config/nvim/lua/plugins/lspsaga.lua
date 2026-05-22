return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = true,
      },
      symbol_in_winbar = {
        enable = false, -- LazyVimのwinbarと競合しがちなので一旦OFF
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
