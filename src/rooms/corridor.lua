local ids = require "ids"
local utils = require "utils"

room {
  nam = ids.corridor.id,
  disp = "Прихожая",
  dsc = function (this)
    if utils.has(this, ids.ex_boyfriend.id) then
      pn("У порога топчется {"..ids.ex_boyfriend.id.."|бывший}.")
    end
  end,
  way = {
    path { "На кухню", ids.kitchen.id },
    path { "В зал", ids.hall.id },
  },
}
