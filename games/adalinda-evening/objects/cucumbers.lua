local ids = require "ids"
local NunchucksElement = require "objects.nunchucks_element"

---@class Cucumber: Obj
local Cucumber = std.class({
  __cucumber_type = true
}, obj)

---@param obj Obj
---@return boolean
function Cucumber.is_cucumber(obj)
  ---@diagnostic disable-next-line: undefined-field
  return type(obj) == "table" and obj.__cucumber_type ~= nil
end

---@param id ObjId
---@param name string
---@param is_spawn_ex_boyfriend boolean
---@return Cucumber
function Cucumber:new(id, name, is_spawn_ex_boyfriend)
  local instance = obj {
    nam = id,
    disp = function (this)
      if NunchucksElement.is_nunchucks_element(this:where()) then
        return false
      end
      return name
    end,
    dsc = function (this)
      local where = this:where()
      if where.nam == ids.fridge_inner then
        return "В лотке для овощей спрятан {"..name.."}."
      elseif where.nam == ids.bowl.id then
        return false
      end
      return "На полу валяется {"..name.."}."
    end,
    tak = function ()
      pn "Вооружаюсь боевыми огурцами."
      if is_spawn_ex_boyfriend then
        local ex_boyfriend = ids.ex_boyfriend:get()
        place(ex_boyfriend, _(ids.corridor.id))
        pn "Кажется, кто-то приперся..."
      end
    end,
    inv = "Хороший огурец, крепкий. Была бы цепь, сделала бы из него нунчаки.",
    use = function (this, another)
      -- todo: если бывший, то "Он только этого и ждет, но не дождется."
      pn(another.disp.." получает кия!")
    end
  }
  return setmetatable(instance, self) --[[@as Cucumber]]
end

return Cucumber
