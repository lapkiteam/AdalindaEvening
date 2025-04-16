-- $Name:Adalinda Evening$
-- $Name(ru):Вечер Адалинды$
-- $Version: 0.1$
-- $Author: lapkiteam$
-- $Info: todo$

require "fmt"
local ids = require "ids"
-- objects
require "objects.bowl"
require "objects.canned_peas"
require "objects.cucumbers"
require "objects.kitchen_table"
require "objects.recipe"
require "objects.salad_place"
require "objects.salad"
require "objects.sausage"
-- rooms
require "rooms.kitchen"
require "rooms.hall"
require "rooms.the_end"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

function init()
  walk(ids.hall:get())
end
