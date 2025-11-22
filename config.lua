local actions = require("actions")

local M = {}

-- The default mode to return to
-- after we execute an action in other mode
-- (unless sticky mode is activated)
M.defaultMode = "tools"

-- Generate keybinds to switch modes
-- in every other mode
-- (you can configure this manually if you want)
M.generateModeKeybinds = true

-- Key to activate sticky mode
-- (Set to nil if you don't want sticky keys)
M.stickyKey = "<Alt>"

-- Help key (if used with another bind)
-- opens the help menu for specific keybinds
M.helpKey = "<Shift>"

-- Keybinds map
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
    description = "Switch between predefined colors (can be set in colors.lua)",
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
    description = "Switch between different line widths",
    buttons = { "e" },
    commands = {
      ["0"] = {
        name = "Very Fine",
        buttons = { "a" },
        call = function()
          actions.setLineWidth(0)
        end,
      },
      ["1"] = {
        name = "Fine",
        buttons = { "s" },
        call = function()
          actions.setLineWidth(1)
        end,
      },
      ["2"] = {
        name = "Medium",
        buttons = { "d" },
        call = function()
          actions.setLineWidth(2)
        end,
      },
      ["3"] = {
        name = "Thick",
        buttons = { "f" },
        call = function()
          actions.setLineWidth(3)
        end,
      },
      ["4"] = {
        name = "Very Thick",
        buttons = { "g" },
        call = function()
          actions.setLineWidth(4)
        end,
      },
    },
  },

  ["shapes"] = {
    name = "Shapes",
    description = "Switch between shapes to draw (rectangle, ellipse, arrow, etc.)",
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
    description = "Switch between line styles (plain, dotted, atc.)",
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
