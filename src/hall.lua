local ids = require "ids"
local couch = require "couch"

room {
  nam = ids.hall.id,
  disp = "Зал",
}:with {
  obj {
    disp = "Телевизер",
    dsc = "Включенный {телевизор} стоит на тумбе.",
    act = function ()
      pn "По телевизору скоро начнется моя любимая педерача \"Кошка в 16\", которую я всегда смотрю с салатиком."
    end
  },
  couch:new {
    on_pulled = function ()
      local salad_place = ids.salad_place:get()
      local salad = ids.salad:get()
      local the_end = ids.the_end:get()
      if salad_place == salad:where() then
        walk(the_end)
        return false
      else
        salad_place:enable()
      end
    end,
    on_pushed = function ()
      local salad_place = ids.salad_place:get()
      salad_place:disable()
    end,
  }:with {
    ids.salad_place.id,
  },
}
