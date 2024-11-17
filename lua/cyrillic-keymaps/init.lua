local C = {}

function C.setup(options)
	local mapping = require("cyrillic-keymaps.mapping")
	mapping.setup_cyrillic_keymaps(options)
end

return C
