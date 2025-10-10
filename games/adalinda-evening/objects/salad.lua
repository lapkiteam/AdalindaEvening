local ids = require "ids"

obj {
  nam = ids.salad.id,
  disp = "Салатик",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.kitchen_table.id then
      return "С краю стола расположен {вожделенный салатик}."
    elseif where.nam == ids.salad_place.id then
      return false
    end
    return "На полу валяется {салатик}."
  end,
  act = function (this)
    local salad_place = ids.salad_place:get()
    if this:where() == salad_place then
      pn "Красивый... был."
    else
      pn "Обычный салатик."
    end
  end,
  tak = function (this)
    local salad_place = ids.salad_place:get()
    if this:where() == salad_place then
      return false
    end
    pn "Беру салатик."
    return true
  end,
  inv = function ()
    pn "Ну-у, это салат."
  end,
  use = function(this, target)
    local salad_place = ids.salad_place:get()
    if target == salad_place then
      pn "Салатик улетает за диван."
      place(this, target)
      return true
    end
    local target_display = (function ()
      if not target.disp then
        return "Оно"
      end
      return target.disp
    end)()
    pn(target_display.." не хочет кушать в отличии от меня.")
  end,
}
