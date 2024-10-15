local M = {}

function M.addKeybinds(keymap, mode, buttons, name, desc, callback)
  local bind = {
    name = name,
    desc = desc,
    call = callback
  }

  if keymap[mode] == nil then
    keymap[mode] = {}
  end

  for _, button in pairs(buttons) do
    keymap[mode][button] = bind
  end
end

function M.generateKeymap(config, generate_mode_keybinds, sticky_key)
  local keybinds = {}

  for mode_name, mode_config in pairs(config) do
    if generate_mode_keybinds then
      -- Add mode keybinds to every other mode
      for to_mode_name, to_mode_config in pairs(config) do
        M.addKeybinds(
          keybinds,
          mode_name,
          to_mode_config.buttons,
          to_mode_config.name,
          to_mode_config.desc,
          function()
            print("Setting mode " .. to_mode_name)
            ximMode = to_mode_name
            ximSticky = false
          end
        )

        if sticky_key then
          local sticky_buttons = {}
          for _, button in pairs(to_mode_config.buttons) do
            table.insert(sticky_buttons, sticky_key .. button)
          end

          M.addKeybinds(
            keybinds,
            mode_name,
            sticky_buttons,
            to_mode_config.name,
            to_mode_config.desc,
            function()
              ximMode = to_mode_name
              ximSticky = true
            end
          )
        end
      end
    end

    -- Add each command
    for _, command_config in pairs(mode_config.commands) do
      M.addKeybinds(
        keybinds,
        mode_name,
        command_config.buttons,
        command_config.name,
        command_config.desc,
        command_config.call
      )
    end
  end

  return keybinds
end

return M
