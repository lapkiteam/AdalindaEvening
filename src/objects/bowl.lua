local ids = require "ids"
local utils = require "utils"
local Cucumber = require "objects.cucumbers"

---@param bowl Obj
---@return boolean
local function has_cucumber(bowl)
  return utils.has(bowl, ids.cucumber1.id)
    or utils.has(bowl, ids.cucumber2.id)
    or utils.has(bowl, ids.cucumber3.id)
end

local function test_salad_ready(bowl)
  return utils.has(bowl, ids.sausage.id)
    and has_cucumber(bowl)
    and utils.has(bowl, ids.canned_peas.id)
    and utils.has(bowl, ids.potato.id)
    and utils.has(bowl, ids.eggs.id)
    and utils.has(bowl, ids.mayo.id)
end

obj {
  nam = ids.bowl.id,
  disp = "Тазик",
  act = function (this)
    if not empty(this) then
      pr "В тазике есть: "
      ---@type string[]
      local name_objs = {}
      this:for_each(function (o)
        table.insert(name_objs, utils.to_lower_first_char(o.disp))
      end)
      pr (table.concat(name_objs, ", "))
      pr "."
      return
    end
    pn "Знакомьтесь, это — тазик."
  end,
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.kitchen_table.id then
      return false
    end
    return "На полу валяется {тазик}."
  end,
  used = function(this, another)
    local function exec()
      place(another, this)
      if test_salad_ready(this) then
        pn "Получается салатик!"
        this:remove()
        local kitchen_table = ids.kitchen_table:get()
        local salad = ids.salad:get()
        place(salad, kitchen_table)
      end
    end
    if another.nam == ids.canned_peas.id then
      pn "Вытряхиваю горошек в тазик."
      exec()
      return true
    elseif Cucumber.is_cucumber(another) then
      if has_cucumber(this) then
        pn "Одного огурца будет достаточно."
      else
        pn "Кладу огурец в тазик."
        exec()
      end
      return true
    elseif another.nam == ids.sausage.id then
      pn "Колбаса летит в тазик."
      exec()
      return true
    elseif another.nam == ids.potato.id then
      pn "Град картошин сыпется в тазик."
      exec()
      return true
    elseif another.nam == ids.eggs.id then
      pn "Яйца улетают в тазик."
      exec()
      return true
    elseif another.nam == ids.mayo.id then
      pn "Майонез с неприличными звуками просачивается в тазик."
      exec()
      return true
    end
    return false
  end,
}
