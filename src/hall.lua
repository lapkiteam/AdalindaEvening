local couch = require "couch"

---@class Hall: Room
local hall = std.class({}, room)

---@param salad_place Obj
---@param salad Obj
---@param the_end Room
---@return Hall
function hall:new(salad_place, salad, the_end)
  local instance = room {
      nam = "зал",
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
          if salad_place == salad:where() then
            walk(the_end)
            return false
          else
            salad_place:enable()
          end
        end,
        on_pushed = function ()
          salad_place:disable()
        end,
      }:with {
        salad_place
      },
    }
  ---@cast instance Hall
  return setmetatable(instance, self)
end

return hall
