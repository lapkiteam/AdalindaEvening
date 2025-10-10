local ids = require "ids"

room {
  nam = ids.corridor.id,
  disp = "Прихожая",
  way = {
    path { "На кухню", ids.kitchen.id },
    path { "В зал", ids.hall.id },
  },
}:with {
  ids.screw.id,
}
