local ids = require "ids"

obj {
  nam = ids.eggs.id,
  disp = "Яйца",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.fridge_inner.id then
      return "В лотке на верхней полке дверцы распиханы {яйца}."
    elseif where.nam == ids.bowl.id then
      return false
    end
    return "На полу валяются {яйца}."
  end,
  tak = "Беру яйца в руки.",
  inv = "На вид довольно хрупкие.",
  use = function (this, another)
    pn(another.disp.." не нуждается в яйцах.")
  end
}
