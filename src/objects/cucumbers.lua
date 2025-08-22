local ids = require "ids"

---@class CucumbersData
---@field count integer
local cucumbers_model = {}

---@return CucumbersData
function cucumbers_model.new(count)
  ---@type CucumbersData
  local instance = {
    count = count,
  }
  return instance
end

---@class CucumbersModel
---@field data CucumbersData
local cucumbers_model = {}

function cucumbers_model:new(data)
  ---@type CucumbersModel
  local instance = {
    data = data
  }
  return setmetatable(instance, self)
end

function cucumbers_model:decrement()
  local model = self.data
  model.count = model.count - 1
  if model.count <= 0 then
    ids.cucumbers:get():remove()
  end
end

---@class Cucumbers: Obj
local Cucumbers = std.class({}, obj)

function Cucumbers:new(id)
  local instance = obj {
    nam = id,
    disp = function (this)
      ---@type CucumbersData
      local data = this.state
      local count = data.count
      if count == 1 then
        return "Огурец"
      elseif 2 <= count and count >= 4 then
        return count.." огурца"
      end
      return count.." огурцов"
    end,
    dsc = function (this)
      local where = this:where()
      if where.nam == ids.fridge_inner then
        return "В лотке для овощей спрятаны {огурцы}."
      elseif where.nam == ids.bowl.id then
        return false
      end
      return "На полу валяются {огурцы}."
    end,
    tak = function ()
      pn "Вооружаюсь боевыми огурцами."
      local ex_boyfriend = ids.ex_boyfriend:get()
      place(ex_boyfriend, _(ids.corridor.id))
      pn "Кажется, кто-то приперся..."
      place(ids.cucumber_nunchucks.id, ids.kitchen.id)
    end,
    inv = "Хорошие огурцы, крепкие. Была бы цепь, сделала бы из них нунчаки.",
    use = function (this, another)
      -- todo: если бывший, то "Он только этого и ждет, но не дождется."
      pn(another.disp.." получает кия!")
    end
  }
  return setmetatable(instance, self)
end

function Cucumbers:remove_one()
  local model = cucumbers_model:new(self.state)
  model:decrement()
end

return Cucumbers
