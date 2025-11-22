---@module 'actions'
local actions = require("actions")

---@class CommandConfig
---@field name string
---@field desc string?
---@field buttons string[]
---@field call fun()

---@class ModeConfig
---@field name string
---@field desc string?
---@field buttons string[]
---@field commands table<string, CommandConfig>

---@alias MapConfig table<string, ModeConfig>

---@class Config
---@field defaultMode string
---@field generateModeKeybinds boolean
---@field stickyKey string?
---@field helpKey string?
---@field map MapConfig

---@type Config
local M = {
  --- The default mode to return to
  --- after we execute an action in other mode
  --- (unless sticky mode is activated)
  defaultMode = "tools",
  --- Generate keybinds to switch modes
  --- in every other mode
  --- (you can configure this manually if you want)
  generateModeKeybinds = true,
}

--- Key to activate sticky mode
--- (Set to nil if you don't want sticky keys)
M.stickyKey = "<Alt>"

--- Help key (if used with another bind)
--- opens the help menu for specific keybinds
M.helpKey = "<Shift>"

--- Keybinds map

M.map = {
  ["tools"] = {
    name = "Tools",
    desc = "Switch between different tools",
    buttons = { "r" },
    commands = {
      ["pen"] = {
        name = "Pen",
        buttons = { "f" },
        call = function()
          actions.setTool("pen")
        end,
      },
      ["eraser"] = {
        name = "Eraser",
        buttons = { "d" },
        call = function()
          actions.setTool("eraser")
        end,
      },
      ["rect_sel"] = {
        name = "Select (rectangle)",
        buttons = { "s" },
        call = function()
          actions.setTool("rect_sel")
        end,
      },
      ["reg_select"] = {
        name = "Select (dynamic region)",
        buttons = { "a" },
        call = function()
          actions.setTool("reg_sel")
        end,
      },
    },
  },

  ["colors"] = {
    name = "Colors",
    desc = "Switch between predefined colors (can be set in colors.lua)",
    buttons = { "t" },
    commands = {
      ["black"] = {
        name = "Black",
        buttons = { "f" },
        call = function()
          actions.setColor("black")
        end,
      },
      ["blue"] = {
        name = "Blue",
        buttons = { "d" },
        call = function()
          actions.setColor("blue")
        end,
      },
      ["green"] = {
        name = "Green",
        buttons = { "s" },
        call = function()
          actions.setColor("green")
        end,
      },
      ["red"] = {
        name = "Red",
        buttons = { "a" },
        call = function()
          actions.setColor("red")
        end,
      },
    },
  },

  ["size"] = {
    name = "Size",
    desc = "Switch between different line widths",
    buttons = { "e" },
    commands = {
      ["0"] = {
        name = "Very Fine",
        buttons = { "a" },
        call = function()
          actions.setLineWidth(1)
        end,
      },
      ["1"] = {
        name = "Fine",
        buttons = { "s" },
        call = function()
          actions.setLineWidth(2)
        end,
      },
      ["2"] = {
        name = "Medium",
        buttons = { "d" },
        call = function()
          actions.setLineWidth(3)
        end,
      },
      ["3"] = {
        name = "Thick",
        buttons = { "f" },
        call = function()
          actions.setLineWidth(4)
        end,
      },
      ["4"] = {
        name = "Very Thick",
        buttons = { "g" },
        call = function()
          actions.setLineWidth(5)
        end,
      },
    },
  },

  ["shapes"] = {
    name = "Shapes",
    desc = "Switch between shapes to draw (rectangle, ellipse, arrow, etc.)",
    buttons = { "w" },
    commands = {
      ["plain"] = {
        name = "Plain Shape",
        buttons = { "f" },
        call = function()
          actions.setShape("plain")
        end,
      },
      ["rect"] = {
        name = "Rect Shape",
        buttons = { "d" },
        call = function()
          actions.setShape("rect")
        end,
      },
      ["ellipse"] = {
        name = "Ellipse Shape",
        buttons = { "s" },
        call = function()
          actions.setShape("ellipse")
        end,
      },
      ["arrow"] = {
        name = "Arrow Shape",
        buttons = { "a" },
        call = function()
          actions.setShape("arrow")
        end,
      },
    },
  },

  ["styles"] = {
    name = "Styles",
    desc = "Switch between line styles (plain, dotted, atc.)",
    buttons = { "q" },
    commands = {
      ["plain"] = {
        name = "Plain Style",
        buttons = { "f" },
        call = function()
          actions.setLineStyle("plain")
        end,
      },
      ["dash"] = {
        name = "Dash Style",
        buttons = { "d" },
        call = function()
          actions.setLineStyle("dash")
        end,
      },
      ["dash_dot"] = {
        name = "Dash-Dot Style",
        buttons = { "s" },
        call = function()
          actions.setLineStyle("dash_dot")
        end,
      },
      ["dot"] = {
        name = "Dash-Dot Style",
        buttons = { "a" },
        call = function()
          actions.setLineStyle("dot")
        end,
      },
    },
  },
}

return M
