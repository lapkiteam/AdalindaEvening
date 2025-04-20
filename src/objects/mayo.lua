local ids = require "ids"

obj {
  nam = ids.mayo.id,
  disp = "Майонез",
  tak = "Хватаю пачку майонеза.",
  inv = "Ммм, густой.",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.kitchen_table.id then
      return "На столе лежит {пачка майонеза}."
    elseif where.nam == ids.fridge_inner.id then
      return "На нижней полке дверцы прижимается к стенке {пачка майонеза}."
    elseif where.nam == ids.bowl.id then
      return false
    end
    return "На полу валяется {пачка майонез}."
  end,
  use = function (this, another)
    pn(another.disp.." не нуждается в майонезе.")
  end
}
