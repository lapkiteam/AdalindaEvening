local ids = require "ids"

obj {
  nam = ids.salad_place.id,
  dsc = function (this)
    local salad = ids.salad:get()
    if this == salad:where() then
      return "За ним покоится {"..salad.nam.."|салатик}."
    else
      return "{Место для салата}."
    end
  end,
  act = function (this)
    pn "Обычное место для салата, расположенное за отодвинутым диваном."
  end,
  ini = function (this)
    this:disable()
  end,
}
