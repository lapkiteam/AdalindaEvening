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
    use = function (this, another)
      if NunchucksElement.is_nunchucks_element(another) then
        ---@cast this NunchucksElement
        ---@cast another NunchucksElement
        if (this:is_full() and another:has_hook())
          or (another:is_full() and this:has_hook())
        then
          this:remove()
          another:remove()
          take(ids.cucumber_nunchucks.id)
          return "Скрепляю это всё безумие и получаются они — огуречные нунчаки! *зловещий смех*"
        end
        return "Чего-то не хватает в этой великолепной конструкции."
      end
      return "Не-е, это всё не то."
    end,
  }
  return setmetatable(instance, self) --[[@as NunchucksElement]]
end

function NunchucksElement:has_hook()
  return utils.has(self, ids.corkscrew.id)
    or utils.has(self, ids.screw.id)
end

function NunchucksElement:has_chain()
  return utils.has(self, ids.chain.id)
end

function NunchucksElement:is_full()
  return self:has_hook() and self:has_chain()
end

return NunchucksElement
