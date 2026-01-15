-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd([[
  highlight LineNr guifg=#7aa2f7
  highlight LineNrAbove guifg=#565f89
  highlight LineNrBelow guifg=#565f89
]])

vim.g.autoformat = true

vim.g.lazyvim_picker = "snacks"

local options = {
  swapfile = false, --スワップファイルは作成しない
  helplang = "ja", --ヘルプファイルの言語は日本語
  number = true, --行番号を表示
  wrap = false, --画面の右端で改行しない
  autoindent = true, --新しい行を改行したとき、1つ上の行のインデントを引き継ぐ
  smartindent = true,
  cursorline = true, --カーソルが存在する行にハイライトを当ててくれます
  tabstop = 2, --TABキーを押したとき、2文字分の幅をとる
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true, --tabstopで指定した数の分の半角スペースが入力
  autoread = true, --vim以外でファイル変更したときに自動再読み込みする
  showmatch = true, --括弧の連携
  matchtime = -1,
  relativenumber = true, --相対行番号を表示
  mouse = "",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
