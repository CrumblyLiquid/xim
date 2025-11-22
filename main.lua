---@module 'config'
local config = require("config")
---@module 'keybinds'
local keybinds = require("keybinds")
---@module 'misc'
local misc = require("misc")

---comment
---@param mode integer
---@param accelerator string
local function register_key(mode, accelerator)
  XIM_KEY_LOOKUP[mode] = accelerator
end

---comment
---@param mode integer
---@return string
local function get_key(mode)
  return XIM_KEY_LOOKUP[mode]
end

--- Get an optional Keybind for the spacified key
---@param key string
---@return Keybind?
local function get_binding(mode, key)
  if XIM_KEYMAP[mode] == nil then
    return nil
  end

  return XIM_KEYMAP[mode][key]
end

--- Creates a dialog window with basic information about this plugin
--- Note: Has to be global so Xournal++ can call it by its (string) name
function handle_info()
  local mode = "Mode: " .. config.map[XIM_MODE].name .. " (" .. XIM_MODE .. ")"
  local state = "Sticky: " .. tostring(XIM_STICKY)
  local author = "Author: " .. misc.author
  local version = "Version: " .. misc.version
  local issues =
    "Feel free to report any issues or bugs at https://github.com/CrumblyLiquid/xim"

  --- TODO: Migrate to openDialog when it comes in a stable version

  ---@diagnostic disable-next-line: deprecated
  app.msgbox(
    ---@diagnostic disable-next-line: redundant-parameter
    "        Xim Plugin\n\nXim State:\n    "
      .. mode
      .. "\n    "
      .. state
      .. "\n\n"
      .. author
      .. "\n"
      .. version
      .. "\n\n"
      .. issues,
    ---@diagnostic disable-next-line: redundant-parameter
    { [1] = "Ok" }
  )
end

--- Help command for a specific keybind
---@param mode integer
function handle_help(mode)
  local key = get_key(mode)
  local binding = get_binding(XIM_MODE, key)

  if binding == nil then
    return
  end

  print("Printing help for " .. key)

  local available_binds = ""
  local modeMap = config.map[binding.target_mode]
  for _, command in pairs(modeMap.commands) do
    local buttons = table.concat(command.buttons, ", ")
    available_binds = available_binds
      .. "    ["
      .. buttons
      .. "]: "
      .. command.name
      .. "\n"
  end

  ---@diagnostic disable-next-line: deprecated
  app.msgbox(
    ---@diagnostic disable-next-line: redundant-parameter
    "Xim Help\n\nMode: "
      .. config.map[XIM_MODE].name
      .. "\n["
      .. key
      .. "]: "
      .. binding.name
      .. "\n\nBinds:\n"
      .. available_binds,
    ---@diagnostic disable-next-line: redundant-parameter
    { [1] = "Ok" }
  )
end

--- Handle keybind trigger
---@param mode integer
function handle_key(mode)
  local key = get_key(mode)
  local binding = get_binding(XIM_MODE, key)

  if binding == nil then
    return
  end

  print("Handling " .. key)

  local modeBefore = XIM_MODE

  binding.call()
  print("Executing " .. key)

  if XIM_STICKY == false and modeBefore == XIM_MODE then
    XIM_MODE = config.defaultMode
  end

  print("ximMode: " .. XIM_MODE .. ", ximSticky: " .. tostring(XIM_STICKY))
end

local function registerCallback(index, callback, name, button)
  local block = {
    ["menu"] = "Xim: " .. name,
    ["callback"] = callback,
    ["mode"] = index,
    ["accelerator"] = button,
  }

  app.registerUi(block)

  print("Registered: " .. button)
end

local function registerCallbacks(keymap)
  app.registerUi({
    ["menu"] = "Xim: Info",
    ["callback"] = "handle_info",
    ["accelerator"] = "F1",
  })

  local index = 0
  for _, mode in pairs(keymap) do
    for button, bind in pairs(mode) do
      -- Register the index => button pairing
      register_key(index, button)
      -- Register normal key trigger
      registerCallback(index, "handle_key", bind.name, button)
      -- Register help option for this button
      registerCallback(
        index,
        "handle_help",
        bind.name .. " (Help)",
        config.helpKey .. button
      )

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
--- Lookup table from `mode` to `accelerator`
---@type table<integer, string>
XIM_KEY_LOOKUP = {}
---@type Modemap
XIM_KEYMAP = keybinds.generateKeymap(
  config.map,
  config.generateModeKeybinds,
  config.stickyKey
)
---@type boolean
XIM_STICKY = false
