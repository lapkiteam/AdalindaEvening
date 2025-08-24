local ids = require "ids"
local Cucumber = require "objects.cucumbers"
local NunchucksElement = require "objects.nunchucks_element"

obj {
  nam = ids.corkscrew.id,
  disp = function (this)
    if NunchucksElement.is_nunchucks_element(this:where()) then
      return false
    end
    return "Штопор"
  end,
  tak = function (this)
    if this:inroom().nam == ids.kitchen.id then
      return "На цыпочках достаю штопор."
    end
    return "Подбираю штопор."
  end,
  dsc = function (this)
    if this:inroom().nam == ids.kitchen.id then
      return "{Штопор} примостился наверху холодильника."
    end
    return "{Штопор] валяется на полу."
  end,
  use = function (this, another)
    if Cucumber.is_cucumber(another) then
      local nunchucks_element = (function ()
        local nunchucks_element1 = ids.nunchucks_element1:get()
        if #nunchucks_element1.obj ~= 0 then
          return ids.nunchucks_element2:get()
        end
        return nunchucks_element1
      end)()
      take(nunchucks_element)
      place(this, nunchucks_element)
      place(another, nunchucks_element)
      return "Вкручиваю штопор в огурец..."
    end
    return "Могу вкрутить, конечно, но потом же придется выкручивать."
  end,
}
