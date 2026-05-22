local wezterm = require("wezterm")
local act = wezterm.action

--config.send_composed_key_when_left_alt_is_pressed = false
--config.send_composed_key_when_right_alt_is_pressed = false

return {
	keys = {
		-- リーダーキー
		-- ランチャー表示
		{ key = "p", mods = "LEADER", action = act.ShowLauncher },
		-- クイックセレクト起動
		{ key = "l", mods = "LEADER", action = act.QuickSelect },
		-- コピーモード起動
		{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
		-- 右に画面分割
		{ key = "s", mods = "LEADER", action = act.SplitHorizontal },
		-- 下に画面分割
		{ key = "v", mods = "LEADER", action = act.SplitVertical },
		-- ペインを選択
		{ key = "[", mods = "CTRL|SHIFT", action = act.PaneSelect },

		-- cmdキー
		-- コマンドパレット表示
		{ key = "p", mods = "SUPER", action = act.ActivateCommandPalette },

		-- ペインを移動
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

		-- optionなしで\を打てるように
		{ key = "¥", mods = "", action = act.SendString("\\") },

		-- ペインを閉じる
		{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },

		-- キーテーブル用
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},
	},
	key_tables = {
		-- Paneサイズ調整 leader + s
		resize_pane = {
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

			-- Cancel the mode by pressing escape
			{ key = "Enter", action = "PopKeyTable" },
		},
	},
}
