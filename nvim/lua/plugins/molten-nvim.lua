-- ~/.config/nvim/lua/plugins/molten.lua みたいなファイルにしている想定
return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    lazy = false,    -- ★ Neovim 起動時に必ずロード
    priority = 1000, -- ★ 早めにロード（任意だが念のため）
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
    keys = {
      {
        "<leader>rc",
        function()
          vim.cmd("MoltenEvaluateOperator")
          vim.fn.feedkeys("V", "n")
        end,
        mode = "n",
        desc = "Run current cell",
      },
      {
        "<leader>rr",
        ":<C-u>MoltenEvaluateVisual<CR>",
        mode = "v",
        desc = "Run selection",
      },
    },
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
