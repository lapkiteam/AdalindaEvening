local ids = require "ids"
local utils = require "utils"

local function test_salad_ready(bowl)
  return utils.has(bowl, ids.sausage.id)
    and utils.has(bowl, ids.cucumbers.id)
    and utils.has(bowl, ids.canned_peas.id)
end

obj {
  nam = ids.bowl.id,
  disp = "Тазик",
  act = function (this)
    if not empty(this) then
      p "В тазике есть: "
      this:for_each(function (o)
        p(o.disp)
      end)
      return
    end
    pn "Знакомьтесь, это — тазик."
  end,
  dsc = function (this)
    local canned_peas = ids.canned_peas:get()
    if utils.has(this, canned_peas) then
      pn "В тазике есть горошек"
    end
  end,
  used = function(this, another)
    local function exec()
      place(another, this)
      if test_salad_ready(this) then
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
    elseif another.nam == ids.cucumbers.id then
      pn "Кладу огурец в тазик."
      exec()
      return true
    elseif another.nam == ids.sausage.id then
      pn "Колбаса летит в тазик."
      exec()
      return true
    end
    return false
  end,
}
