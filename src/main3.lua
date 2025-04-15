-- $Name:Adalinda Evening$
-- $Name(ru):Вечер Адалинды$
-- $Version: 0.1$
-- $Author: lapkiteam$
-- $Info: todo$

require "fmt"

local couch = require "couch"

fmt.para = true

game.act = "Не работает."
game.use = "Это не поможет."
game.inv = "Зачем мне это?"

local hall
---@type Obj
local salad

function init()
  take(salad)
  walk(hall)
end

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

---@type Room
local the_end

local couch = couch:new {
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
}

hall = room {
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
  couch,
}

the_end = room {
  disp = "Концовка",
  dsc = "Сижу на диване, смотрю передачу \"Кошка в 16\". В животе предательски бурчит. Это конец."
}
