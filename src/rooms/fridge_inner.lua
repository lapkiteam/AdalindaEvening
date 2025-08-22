local ids = require "ids"
local Cucumbers = require "src.objects.cucumbers"

room {
  nam = ids.fridge_inner.id,
  disp = "В холодильнике",
  decor = function (this)
    local objs = this.obj --[[@as Obj[] ]]
    local objs_length = #objs
    if objs_length == 0 then
      return "Внутри повесилась мышь."
    end
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
  Cucumbers:new(ids.cucumbers.id),
  ids.eggs.id,
  ids.mayo.id,
}
