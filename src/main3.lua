-- $Name:Adalinda Evening$
-- $Name(ru):Вечер Адалинды$
-- $Version: 0.2$
-- $Author: lapkiteam$
-- $Info: todo$

require "fmt"
local ids = require "ids"
-- objects
include "objects/bowl.lua"
include "objects/canned_peas.lua"
include "objects/cucumbers.lua"
include "objects/kitchen_table.lua"
include "objects/recipe.lua"
include "objects/salad_place.lua"
include "objects/salad.lua"
include "objects/sausage.lua"
include "objects/potato.lua"
include "objects/eggs.lua"
include "objects/mayo.lua"
include "objects/fridge.lua"
include "objects/sink_cabinet.lua"
-- rooms
include "rooms/kitchen.lua"
include "rooms/hall.lua"
include "rooms/fridge_inner.lua"
include "rooms/sink_cabinet_inner.lua"
include "rooms/the_end.lua"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

function init()
  walk(ids.hall:get())
end
