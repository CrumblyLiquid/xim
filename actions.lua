-- Helper functions for executing different actions
--
-- You can find a list of possible actions here:
-- https://github.com/xournalpp/xournalpp/blob/master/src/core/enums/Action.enum.h
-- and their mapping to string here:
-- https://github.com/xournalpp/xournalpp/blob/master/src/core/plugin/ActionBackwardCompatibilityLayer.cpp

local M = {}

function M.executeAction(prefix, action, enabled, options)
  local command = {}

  -- Prepend prefix if applicable
  if prefix ~= nil then
    command["action"] = "ACTION_" .. prefix .. "_" .. action
  else
    command["action"] = "ACTION_" .. action
  end

  -- Enabled option is true by default (if not specified)
  if enabled ~= nil then
    command["enabled"] = enabled
  end

  options = options or {}
  for name, value in pairs(options) do
    command[name] = value
  end

  app.uiAction(command)
end

function M.undo()
  M.executeAction(nil, "UNDO")
end

function M.redo()
  M.executeAction(nil, "REDO")
end

-- Set Tool
-- Implements only subset of available
-- tools, others can be implemented easily
function M.setTool(tool)
  local tools = {
    ["pen"] = "TOOL_PEN",
    ["eraser"] = "TOOL_ERASER",
    ["highlighter"] = "TOOL_HIGHLIGHTER",
    ["hand"] = "TOOL_HAND",

    ["rect_sel"] = "TOOL_SELECT_RECT",
    ["reg_sel"] = "TOOL_SELECT_REGION",

    ["text"] = "TOOL_TEXT",
    ["tex"] = "TEX",
  }

  M.executeAction(nil, tools[tool])
end

-- Set Line Width
-- width: 0 - 4 (0 = very fine, 4 = very thick)
function M.setLineWidth(width)
  local options = {
    "VERY_FINE",
    "FINE",
    "MEDIUM",
    "THICK",
    "VERY_THICK",
  }

  M.executeAction("SIZE", options[width])
end

function M.setShape(shape, enabled)
  -- Set default values
  shape = shape or "plain"
  enabled = enabled or true

  local shapes = {
    ["recognizer"] = "TOOL_SHAPE_RECOGNIZER",
    ["rect"] = "TOOL_DRAW_RECT",
    ["ellipse"] = "TOOL_DRAW_ELLIPSE",
    ["arrow"] = "TOOL_DRAW_ARROW",
    ["double_arrow"] = "TOOL_DRAW_DOUBLE_ARROW",
    ["coords_system"] = "TOOL_DRAW_COORDINATE_SYSTEM",
    ["spline"] = "TOOL_DRAW_SPLINE",
  }

  -- Disable all shapes
  if (shape == "plain") then
    for _, action in pairs(shapes) do
      M.executeAction(nil, action, false)
    end
    -- Set the desired shape
  else
    M.executeAction(nil, shapes[shape], enabled)
  end
end

function M.setLineStyle(style, enabled)
  enabled = enabled or true

  local styles = {
    ["plain"] = "PLAIN",
    ["dash"] = "DASH",
    ["dash_dot"] = "DASH_DOT",
    ["dot"] = "DOT",
  }

  M.executeAction("TOOL_LINE_STYLE", styles[style], enabled)
end

function M.setFill(enabled)
  enabled = enabled or true
  M.executeAction("TOOL", "FILL", enabled, { ["selection"] = true })
end

-- Sets colors
function M.setColor(color)
  local colors = {
    ["black"]  = 0x000000,
    ["blue"]   = 0x6272a4,
    ["green"]  = 0x50fa7b,
    ["purple"] = 0xbd93f9,
    ["red"]    = 0xff5555,
    ["orange"] = 0xffb86c,
    ["cyan"]   = 0x8be9fd,
    ["pink"]   = 0xff79c6,
    ["yellow"] = 0xf1fa8c,
    ["white"]  = 0xf8f8f2,
  }

  app.changeToolColor({ ["color"] = colors[color], ["selection"] = true })
end

return M
