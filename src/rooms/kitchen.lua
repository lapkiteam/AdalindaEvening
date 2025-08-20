local ids = require "ids"

room {
  nam = ids.kitchen.id,
  disp = "Кухня",
  way = {
    path { "В холл", ids.hall.id },
    path { "В прихожую", ids.corridor.id },
  }
}:with {
  ids.kitchen_table.id,
  ids.recipe.id,
  ids.fridge.id,
  ids.sink_cabinet.id,
}
