local M = {}

local keymap_utils = require("cyrillic-keymaps.mapping.utils")
local nvim_default_keymaps = require("cyrillic-keymaps.mapping.keyboard.nvim-default-keymaps")

function M.setup_cyrillic_keymaps(options)
	-- TODO add ignore options
	if nvim_default_keymaps then
		keymap_utils.set_cyrillic_keymaps(nvim_default_keymaps)
	end
end

return M
