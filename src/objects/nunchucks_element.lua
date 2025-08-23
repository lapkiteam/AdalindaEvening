local ids = require "ids"
local utils = require "utils"

---@class NunchucksElement: Obj
local NunchucksElement = std.class({
  __nunchucks_element_type = true
}, obj)

---@param obj Obj
---@return boolean
function NunchucksElement.is_nunchucks_element(obj)
  ---@diagnostic disable-next-line: undefined-field
  return type(obj) == "table" and obj.__nunchucks_element_type ~= nil
end

---@param id ObjId
---@return NunchucksElement
function NunchucksElement:new(id)
  local instance = obj {
    nam = id,
    disp = function (this)
      local hook = (function ()
        if utils.has(this, ids.corkscrew.id) then
          return " со штопором"
        elseif utils.has(this, ids.screw.id) then
          return " с шурупом"
        end
        return ""
      end)()
      local chain = (function ()
        if utils.has(this, ids.chain.id) then
          return " и цепочкой"
        end
        return ""
      end)()
      return "Огурец"..hook..chain..""
    end,
    inv = "Странное изделие, я знаю.",
  }
  return setmetatable(instance, self) --[[@as NunchucksElement]]
end

return NunchucksElement
