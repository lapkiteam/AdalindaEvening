local ids = require "ids"

obj {
  nam = ids.sausage.id,
  disp = "Колбаса",
  dsc = "{Колбаса} валяется на полу.",
  tak = "Подбираю колбасу.",
  inv = function (this)
    pn "Живи, колбаса... пока что."
  end,
  use = function (this, another)
    pn(another.disp.." не хочет колбасу.")
  end,
}
