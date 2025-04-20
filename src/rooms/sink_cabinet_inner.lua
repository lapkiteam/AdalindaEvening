local ids = require "ids"
local utils = require "utils"

room {
  nam = ids.sink_cabinet_inner.id,
  disp = "В шкафчике под раковиной",
  decor = function (this)
    local objs = this.obj --[[@as Obj[] ]]
    local objs_length = #objs
    if objs_length == 1 then
      return "Внутри лежит "..utils.to_interact(objs[1]).."."
    elseif objs_length > 1 then
      pr ("Внутри лежат: ")
      ---@type string[]
      local name_objs = {}
      for i = 1, objs_length, 1 do
        local obj = objs[i]
        table.insert(name_objs, utils.to_interact(obj))
      end
      pr(table.concat(name_objs, ", "))
      pr "."
      return
    end
    return "Внутри пусто."
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
