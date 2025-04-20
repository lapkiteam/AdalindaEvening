local ids = require "ids"

obj {
  nam = ids.eggs.id,
  disp = "Яйца",
  tak = "Беру яйца в руки.",
  inv = "На вид довольно хрупкие.",
  use = function (this, another)
    pn(another.disp.." не нуждается в яйцах.")
  end
}
