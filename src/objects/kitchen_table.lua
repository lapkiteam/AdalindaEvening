local ids = require "ids"

obj {
  nam = ids.kitchen_table.id,
  disp = "Кухонный стол",
  dsc = function (this)
    local salad = ids.salad:get()
    if this == salad:where() then
      return "{"..salad.nam.."|Готовый салатик} стоит на {кухонном столе}."
    end
    return "{Кухонный стол}."
  end,
  act = "Он слегка грязный, но я все равно его люблю таким, какой он есть.",
}:with {
  ids.salad.id,
}
