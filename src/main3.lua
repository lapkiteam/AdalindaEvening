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
include "objects/cucumber_nunchucks.lua"
include "objects/fridge.lua"
include "objects/sink_cabinet.lua"
include "objects/corkscrew.lua"
include "objects/screw.lua"
include "objects/chain.lua"
-- characters
include "objects/ex_boyfriend.lua"
-- rooms
include "rooms/kitchen.lua"
include "rooms/hall.lua"
include "rooms/fridge_inner.lua"
include "rooms/sink_cabinet_inner.lua"
include "rooms/corridor.lua"
include "rooms/the_end.lua"

local NunchucksElement = require "objects.nunchucks_element"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

NunchucksElement:new(ids.nunchucks_element1.id)
NunchucksElement:new(ids.nunchucks_element2.id)

function init()
  walk(ids.hall:get())
end
