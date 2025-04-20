local ids = require "ids"
local utils = require "utils"

room {
  nam = ids.sink_cabinet_inner.id,
  disp = "В шкафчике под раковиной",
  decor = function (this)
    local objs = this.obj --[[@as Obj[] ]]
    local objs_length = #objs
    if objs_length == 0 then
      return "Внутри пусто."
    end
  end,
  way = {
    path {
      "Назад",
      function ()
        local sink_cabinet = _(ids.sink_cabinet.id) --[[@as Obj]]
        return sink_cabinet:inroom().nam
      end,
    },
  },
}:with {
  ids.canned_peas.id,
  ids.potato.id,
}
