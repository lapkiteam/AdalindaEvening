local ids = require "ids"

room {
  nam = ids.kitchen.id,
  way = {
    path { "В холл", ids.hall.id },
  }
}:with {
  ids.kitchen_table.id
}
