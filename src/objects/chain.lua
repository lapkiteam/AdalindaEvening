local ids = require "ids"

obj {
  nam = ids.chain.id,
  disp = "Цепочка",
  tak = "Моё.",
  dsc = function (this)
    if this:inroom().nam == ids.hall.id then
      return "На ручке окна висит {цепочка}."
    end
    return "{Цепочка} валяется на полу."
  end,
  inv = "Цепочка от жалюзи. Когда-нибудь починю, но точно не сегодня."
}
