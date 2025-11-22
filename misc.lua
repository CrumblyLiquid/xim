-- https://stackoverflow.com/questions/22831701/lua-read-beginning-of-a-string
--- Checks if a given string starts with some substring
---@param self string
---@param substring string
---@return boolean
function string.starts_with(self, substring)
  return string.sub(self, 1, string.len(substring)) == substring
end

local M = {
  ---@type string
  author = "CrumblyLiquid",
  ---@type string
  version = "0.2.0",
}

return M
