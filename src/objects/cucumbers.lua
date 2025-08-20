local ids = require "ids"

obj {
  nam = ids.cucumbers.id,
  disp = "Огурцы",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.fridge_inner then
      return "В лотке для овощей спрятаны {огурцы}."
    elseif where.nam == ids.bowl.id then
      return false
    end
    return "На полу валяются {огурцы}."
  end,
  tak = function ()
    pn "Вооружаюсь боевыми огурцами."
    local ex_boyfriend = ids.ex_boyfriend:get()
    place(ex_boyfriend, _(ids.corridor.id))
    pn "Кажется, кто-то приперся..."
  end,
  inv = "Хорошие огурцы, крепкие. Была бы цепь, сделала бы из них нунчаки.",
  use = function (this, another)
    pn(another.disp.." получает кия!")
  end
}
