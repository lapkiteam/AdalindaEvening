local ids = require "ids"
local Cucumbers = require "objects.cucumbers"

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
  Cucumbers:new(ids.cucumber1.id, "Крепыш", true),
  Cucumbers:new(ids.cucumber2.id, "Пупырыш", false),
  Cucumbers:new(ids.cucumber3.id, "Хрустяш", false),
  ids.eggs.id,
  ids.mayo.id,
}
