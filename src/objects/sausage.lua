local ids = require "ids"

obj {
  nam = ids.sausage.id,
  disp = "Колбаса",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.fridge_inner.id then
      return "На первой полке вальяжно возлегает {палка колбасы}."
    elseif where.nam == ids.bowl.id then
      return false
    end
    return "На полу валяется {палка колбасы}."
  end,
  tak = "Подбираю колбасу.",
  inv = function (this)
    pn "Живи, колбаса... пока что."
  end,
  use = function (this, another)
    pn(another.disp.." не хочет колбасу.")
  end,
}
