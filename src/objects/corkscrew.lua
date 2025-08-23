local ids = require "ids"
local Cucumber = require "objects.cucumbers"
local NunchucksElement = require "objects.nunchucks_element"

local nunchucks_element_id = (function ()
  local element = ids.nunchucks_element1:try_get()
  if not element then
    return "nunchucks_element1 занят!"
  end
  return ids.nunchucks_element1.id
end)()
local nunchucks_element = NunchucksElement:new(nunchucks_element_id)
ids.nunchucks_element1:init()

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
      take(nunchucks_element)
      place(this, nunchucks_element)
      place(another, nunchucks_element)
      return "Вкручиваю штопор в огурец..."
    end
    return "Могу вкрутить, конечно, но потом же придется выкручивать."
  end,
}
