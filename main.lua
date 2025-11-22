local config = require("config")
local keybinds = require("keybinds")

-- https://stackoverflow.com/questions/22831701/lua-read-beginning-of-a-string
function string.starts(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

function handle(key)
  print("Handling " .. key)
  local help = false

  if config.helpKey ~= nil then
    if string.starts(key, config.helpKey) then
      help = true
      key = string.gsub(key, config.helpKey, "")
    end
  end

  if ximKeymap[ximMode] == nil then
    return
  end

  if ximKeymap[ximMode][key] == nil then
    return
  end

  local bind = ximKeymap[ximMode][key]

  local modeBefore = ximMode

  if help == false then
    ximKeymap[ximMode][key].call()
    print("Executing " .. key)
  else
    print("Printing help for " .. key)
    app.msgbox(
      "Xim Help\n\n[" .. config.map[ximMode].name .. "]: " .. bind.name,
      { "Ok" }
    )
  end

  if ximSticky == false and modeBefore == ximMode then
    ximMode = config.defaultMode
  end

  print("ximMode: " .. ximMode .. ", ximSticky: " .. tostring(ximSticky))
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
  registerCallbacks(ximKeymap)
end

function info()
  local mode = "Mode: " .. config.map[ximMode].name .. " (" .. ximMode .. ")"
  local state = "Sticky: " .. tostring(ximSticky)
  -- TODO: Move author and version somewhere else
  local author = "Author: CrumblyLiquid"
  local version = "Version: 0.1.0"
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

ximMode = config.defaultMode
ximKeymap = keybinds.generateKeymap(
  config.map,
  config.generateModeKeybinds,
  config.stickyKey
)
ximSticky = false
