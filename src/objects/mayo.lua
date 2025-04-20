local ids = require "ids"

obj {
  nam = ids.mayo.id,
  disp = "Майонез",
  tak = "Хватаю пачку майонеза.",
  inv = "Ммм, густой.",
  use = function (this, another)
    pn(another.disp.." не нуждается в майонезе.")
  end
}
