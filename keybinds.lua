local M = {}

---@class Keybind
---@field name string
---@field target_mode string
---@field desc string
---@field call fun()

---@alias Modemap table<string, Keymap>

---@alias Keymap table<string, Keybind>

--- Adds a new keybind to the specified keymap
---@param modemap Modemap
---@param mode string
---@param target_mode string
---@param buttons string[]
---@param name string
---@param desc string
---@param callback fun()
function M.addKeybinds(
  modemap,
  mode,
  target_mode,
  buttons,
  name,
  desc,
  callback
)
  ---@type Keybind
  local bind = {
    name = name,
    target_mode = target_mode,
    desc = desc,
    call = callback,
  }

  if modemap[mode] == nil then
    modemap[mode] = {}
  end

  for _, button in pairs(buttons) do
    modemap[mode][button] = bind
  end
end

---Generate a Keymap from config
---@param config MapConfig
---@param generate_mode_keybinds boolean
---@param sticky_key string
---@return Modemap
function M.generateKeymap(config, generate_mode_keybinds, sticky_key)
  ---@type Modemap
  local modemap = {}

  for mode_name, mode_config in pairs(config) do
    if generate_mode_keybinds then
      -- Add mode keybinds to every other mode
      for to_mode_name, to_mode_config in pairs(config) do
        M.addKeybinds(
          modemap,
          mode_name,
          to_mode_name,
          to_mode_config.buttons,
          to_mode_config.name,
          to_mode_config.desc,
          function()
            print("Setting mode " .. to_mode_name)
            XIM_MODE = to_mode_name
            XIM_STICKY = false
          end
        )

        if sticky_key then
          local sticky_buttons = {}
          for _, button in pairs(to_mode_config.buttons) do
            table.insert(sticky_buttons, sticky_key .. button)
          end

          M.addKeybinds(
            modemap,
            mode_name,
            to_mode_name,
            sticky_buttons,
            to_mode_config.name,
            to_mode_config.desc,
            function()
              XIM_MODE = to_mode_name
              XIM_STICKY = true
            end
          )
        end
      end
    end

    -- Add each command
    for _, command_config in pairs(mode_config.commands) do
      M.addKeybinds(
        modemap,
        mode_name,
        mode_name,
        command_config.buttons,
        command_config.name,
        command_config.desc,
        command_config.call
      )
    end
  end

  return modemap
end

return M
