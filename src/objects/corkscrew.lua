local ids = require "ids"

obj {
  nam = ids.corkscrew.id,
  disp = "Штопор",
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
  end
}
