local ids = require "ids"
local utils = require "utils"

room {
  nam = ids.fridge_inner.id,
  disp = "В холодильнике",
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
    return "Внутри повесилась мышь."
  end,
  way = {
    path {
      "Назад",
      function ()
        local fridge = _(ids.fridge.id) --[[@as Obj]]
        return fridge:inroom().nam
      end,
    },
  },
}:with {
  ids.sausage.id,
  ids.cucumbers.id,
  ids.eggs.id,
  ids.mayo.id,
}
