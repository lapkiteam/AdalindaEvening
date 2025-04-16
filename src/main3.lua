-- $Name:Adalinda Evening$
-- $Name(ru):Вечер Адалинды$
-- $Version: 0.1$
-- $Author: lapkiteam$
-- $Info: todo$

require "fmt"
local ids = require "ids"
-- objects
require "salad"
require "salad_place"
-- rooms
require "hall"
require "the_end"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

function init()
  take(ids.salad:get())
  walk(ids.hall:get())
end
