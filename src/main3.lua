-- $Name:Adalinda Evening$
-- $Name(ru):Вечер Адалинды$
-- $Version: 0.1$
-- $Author: lapkiteam$
-- $Info: todo$

require "fmt"

local ids = require "ids"
require "hall"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

---@type Obj
local salad

local salad_place

salad = obj {
  nam = "салат",
  disp = "Салатик",
  act = function (this)
    if this:where() == salad_place then
      pn "Красивый... был."
    else
      pn "Обычный салатик."
    end
  end,
  inv = function ()
    pn "Ну-у, это салат."
  end,
  use = function(this, target)
    if target == salad_place then
      pn "Салатик улетает за диван."
      place(this, target)
      return true
    end
    local target_display = (function ()
      if not target.disp then
        return "Оно"
      end
      return target.disp
    end)()
    pn(target_display.." не хочет кушать в отличии от меня.")
  end,
}

salad_place = obj {
  nam = "место_для_салата",
  dsc = function (this)
    if this == salad:where() then
      return "За ним покоится {"..salad.nam.."|салатик}."
    else
      return "{Место для салата}."
    end
  end,
  act = function (this)
    pn "Обычное место для салата, расположенное за отодвинутым диваном."
  end,
  ini = function (this)
    this:disable()
  end,
}

room {
  nam = ids.the_end.id,
  disp = "Концовка",
  dsc = "Сижу на диване, смотрю передачу \"Кошка в 16\". В животе предательски бурчит. Это конец."
}

function init()
  take(salad)
  walk(ids.hall:get())
end
