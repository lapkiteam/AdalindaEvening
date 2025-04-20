local ids = require "ids"

obj {
  nam = ids.cucumbers.id,
  disp = "Огурцы",
  tak = "Вооружаюсь боевыми огурцами.",
  inv = "Хорошие огурцы, крепкие. Была бы цепь, сделала бы из них нунчаки.",
  use = function (this, another)
    pn(another.disp.." получает кия!")
  end
}
