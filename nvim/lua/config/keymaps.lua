-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- 全選択
keymap.set("n", "<C-a>", "ggVG", opts)

-- バッファ
-- バッファ移動
keymap.set("n", "<tab>", ":BufferNext<Return>", opts)
keymap.set("n", "<s-tab>", ":BufferPrevious<Return>", opts)
-- バッファを閉じる
keymap.set("n", "<s-BS>", ":bd<Return>", opts)
-- バッファ整列
keymap.set("n", "<leader>bb", "BufferOrderByBufferNumber", opts)

-- ウィンドウ分割
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- ウィンドウリサイズ
keymap.set("n", "s<left>", "<C-w><", opts)
keymap.set("n", "s<right>", "<C-w>>", opts)
keymap.set("n", "s<up>", "<C-w>+", opts)
keymap.set("n", "s<down>", "<C-w>-", opts)

-- shift+Eでエラー全文表示
keymap.set("n", "E", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)

-- Telescopeの表示ファイルタイプを変更
-- keymap.set("n", "<leader> ", function()
--   require("telescope.builtin").find_files({
--     find_command = {
--       "fd",
--       "--hidden",
--       "--no-ignore",
--       "--exclude",
--       "node_modules",
--       "--exclude",
--       ".git",
--       "--type",
--       "f",
--     },
--   })
-- end)

-- dでブラックホール、cでヤンク&削除
-- keymap.set({ "n", "v" }, "c", "d")
-- keymap.set("n", "cc", "dd")
-- keymap.set({ "n", "v" }, "d", '"_d')

-- ブラックホールを-にマッピング
keymap.set({ "n", "v" }, "\\", '"_')

-- Oil起動
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- EscでTerminalMode解除
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Floatermの起動
-- keymap.set({ "v", "n" }, "<leader>t", "<CMD>FloatermToggle<CR>")
