local ids = require "ids"
local utils = require "utils"
local NunchucksElement = require "objects.nunchucks_element"

obj {
  nam = ids.chain.id,
  disp = function (this)
    if NunchucksElement.is_nunchucks_element(this:where()) then
      return false
    end
    return "Цепочка"
  end,
  tak = "Моё.",
  dsc = function (this)
    if this:inroom().nam == ids.hall.id then
      return "На ручке окна висит {цепочка}."
    end
    return "{Цепочка} валяется на полу."
  end,
  inv = "Цепочка от жалюзи. Когда-нибудь починю, но точно не сегодня.",
  use = function (this, another)
    if NunchucksElement.is_nunchucks_element(another) then
      place(this, another)
      if utils.has(another, ids.corkscrew.id) then
        return "Привязываю цепочку к штопору огурца..."
      elseif utils.has(another, ids.screw.id) then
        return "Привязываю цепочку к шурупу огурца..."
      end
      return "Привязываю к кольцу огурца..."
    end
    return "Можно намотать, конечно, но зачем?"
  end,
}
