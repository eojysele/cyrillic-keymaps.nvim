local U = {}

local LEADER = "<leader>"
local keyboard_map = require("cyrillic-keymaps.mapping.keyboard.cyrillic-map")

local function set(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs)
end

local function replace_symbols_from_keyboard_map(input)
	return (input:gsub(".", function(char)
		return keyboard_map[char] or char
	end))
end

local function set_single_cyrillic_keymap(keymap)
	local lhs = keymap.lhs
	local cyrillic_lhs = nil
	if string.match(lhs, "<.*>") then
		if string.match(lhs, LEADER) then
			local lhs_witout_leader = string.gsub(lhs, LEADER, "")
			cyrillic_lhs = LEADER .. replace_symbols_from_keyboard_map(lhs_witout_leader)
		else
			local modififcator = string.match(lhs, "<.*>")
			local lhs_without_modificator = string.gsub(lhs, modififcator, "")
			cyrillic_lhs = modififcator
				.. replace_symbols_from_keyboard_map(lhs_without_modificator)
		end
	else
		cyrillic_lhs = replace_symbols_from_keyboard_map(lhs)
	end

	if cyrillic_lhs then
		set(keymap.mode, cyrillic_lhs, keymap.rhs)
	end
end

function U.set_cyrillic_keymaps(keymaps)
	for _, keymap in ipairs(keymaps) do
		if keymap.rhs then
			set_single_cyrillic_keymap(keymap)
		else
			local keymap_without_rhs = {
				mode = keymap.mode,
				lhs = keymap.lhs,
				rhs = keymap.lhs,
			}
			set_single_cyrillic_keymap(keymap_without_rhs)
		end
	end
end

local function delete(mode, lhs, buffer)
	vim.keymap.del(mode, lhs, { buffer = buffer })
end

function U.delete_list_keymaps(keymaps)
	for _, keymap in ipairs(keymaps) do
		delete(keymap.mode, keymap.lhs, keymap.buffer)
	end
end

return U
