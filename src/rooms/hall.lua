local ids = require "ids"
local couch = require "objects.couch"

room {
  nam = ids.hall.id,
  disp = "Зал",
  way = {
    path { "На кухню", ids.kitchen.id },
    path { "В прихожую", ids.corridor.id },
  },
}:with {
  obj {
    disp = "Телевизер",
    dsc = "Включенный {телевизор} стоит на тумбе.",
    act = function ()
      pn "По телевизору скоро начнется моя любимая педерача \"Кошка в 16\", которую я всегда смотрю с салатиком."
    end
  },
  couch:new(
    ids.couch.id,
    {
      on_pulled = function ()
        local salad_place = ids.salad_place:get()
        local salad = ids.salad:get()
        local the_end = ids.the_end:get()
        if salad_place == salad:where() then
          local ex_boyfriend = ids.ex_boyfriend:get()
          local ex_boyfriend_location = ex_boyfriend:inroom()
          if ex_boyfriend_location ~= nil and ex_boyfriend_location.nam == ids.corridor.id then
            pn("\"Вы не можете сидеть на диванчике и смотреть «Кошка в 16», пока рядом враги.\"")
            return false
          end
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
    }
  ):with {
    ids.salad_place.id,
  },
}
