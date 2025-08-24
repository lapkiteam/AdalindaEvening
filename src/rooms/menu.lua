require "fmt"
local ids = require "ids"
local utils = require "utils"

local authors_id = "authors"
local to_menu_id = "в_меню"

local to_menu = obj {
  nam = to_menu_id,
  disp = "Назад",
  act = function ()
    walk(ids.menu.id)
  end,
}

room {
  nam = authors_id,
  disp = "Авторы",
  decor = function (this)
    pn("- Агент Лапкин")
    pn("- Адалапка")
    pn ""
    pn("- "..utils.to_interact(to_menu))
  end,
}: with {
  to_menu
}

local to_authors_id = "to_authors_id"
local start_game_id = "start_game_id"

room {
  nam = ids.menu.id,
  disp = "Типичный вечер Адалинды",
  decor = function (this)
    pn(fmt.c "квест, повседневность, юмор, симулятор готовки")
    pn(fmt.c "Детям после 16 (а лучше вообще не надо)")
    pn(fmt.c "Проходится за ~13 минут (если знать, что делать)")
    pn ""
    pn "План прост: любимая передача и салатик — но салат не сделан, телевизор сломан, ещё и бывший припёрся..."
    pn ""
    pn "Создано специально на «Паровозик 9: Летняя ёлка» на Инстеде с болью, кровью и полыханиями. Приятного просмотра."
    pn ""
    pn("- "..utils.to_interact(_(start_game_id) --[[@as Obj]]))
    pn("- "..utils.to_interact(_(to_authors_id) --[[@as Obj]]))
  end,
}: with {
  obj {
    nam = start_game_id,
    disp = "Начать игру",
    act = function ()
      walk(ids.hall.id)
    end,
  },
  obj {
    nam = to_authors_id,
    disp = "Авторов!",
    act = function ()
      walk(authors_id)
    end,
  },
}
