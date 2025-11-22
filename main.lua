---@module 'config'
local config = require("config")
---@module 'keybinds'
local keybinds = require("keybinds")

-- https://stackoverflow.com/questions/22831701/lua-read-beginning-of-a-string
--- Checks if a given string starts with some substring
---@param self string
---@param substring string
---@return boolean
function string.starts_with(self, substring)
  return string.sub(self, 1, string.len(substring)) == substring
end

--- Handle key event
---@param key string
function handle(key)
  print("Handling " .. key)
  local help = false

  if config.helpKey ~= nil then
    if string.starts_with(key, config.helpKey) then
      help = true
      key = string.gsub(key, config.helpKey, "")
    end
  end

  if XIM_KEYMAP[XIM_MODE] == nil then
    return
  end

  if XIM_KEYMAP[XIM_MODE][key] == nil then
    return
  end

  local bind = XIM_KEYMAP[XIM_MODE][key]

  local modeBefore = XIM_MODE

  if help == false then
    XIM_KEYMAP[XIM_MODE][key].call()
    print("Executing " .. key)
  else
    print("Printing help for " .. key)

    local available_binds = ""

    local modeMap = config.map[bind.target_mode]
    for _, command in pairs(modeMap.commands) do
      local buttons = table.concat(command.buttons, ", ")
      available_binds = available_binds
        .. "    ["
        .. buttons
        .. "]: "
        .. command.name
        .. "\n"
    end

    app.msgbox(
      "Xim Help\n\nMode: "
        .. config.map[XIM_MODE].name
        .. "\n["
        .. key
        .. "]: "
        .. bind.name
        .. "\n\nBinds:\n"
        .. available_binds,
      { [1] = "Ok" }
    )
  end

  if XIM_STICKY == false and modeBefore == XIM_MODE then
    XIM_MODE = config.defaultMode
  end

  print("ximMode: " .. XIM_MODE .. ", ximSticky: " .. tostring(XIM_STICKY))
end

local function registerCallback(index, bind_name, button)
  local funct_name = "funct" .. tostring(index)
  -- Create a function callback dynamically
  local funct = funct_name .. ' = function() handle("' .. button .. '") end'

  local compiled, err = load(funct)
  if compiled ~= nil then
    compiled()

    local block = {
      ["menu"] = "Xim: " .. bind_name,
      ["callback"] = funct_name,
      ["accelerator"] = button,
    }

    app.registerUi(block)

    print("Registered: " .. funct)
  else
    print(
      "Failed to load .."
        .. funct_name
        .. ":\n"
        .. tostring(err)
        .. "\n"
        .. funct
    )
  end
end

--- Creates a dialog window with basic information about this plugin
--- Note: Has to be global so Xournal++ can call it by its (string) name
function info()
  local mode = "Mode: " .. config.map[XIM_MODE].name .. " (" .. XIM_MODE .. ")"
  local state = "Sticky: " .. tostring(XIM_STICKY)
  -- TODO: Move author and version somewhere else
  local author = "Author: CrumblyLiquid"
  local version = "Version: 0.2.0"
  app.msgbox(
    "        Xim Plugin\n\nXim State:\n    "
      .. mode
      .. "\n    "
      .. state
      .. "\n\n"
      .. author
      .. "\n"
      .. version,
    { [1] = "Ok" }
  )
end

local function registerCallbacks(keymap)
  app.registerUi({
    ["menu"] = "Xim: Info",
    ["callback"] = "info",
    ["accelerator"] = "F1",
  })

  local index = 0
  for _, mode in pairs(keymap) do
    for button, bind in pairs(mode) do
      registerCallback(index, bind.name, button)
      index = index + 1
      registerCallback(index, bind.name, config.helpKey .. button)
      index = index + 1
    end
  end
end

function initUi()
  registerCallbacks(XIM_KEYMAP)
end

--- The mode that Xim is currently in
--- (this affects what binds that will be active)
---@type string
XIM_MODE = config.defaultMode
XIM_KEYMAP = keybinds.generateKeymap(
  config.map,
  config.generateModeKeybinds,
  config.stickyKey
)
---@type boolean
XIM_STICKY = false
