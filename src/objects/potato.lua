local ids = require "ids"

obj {
  nam = ids.potato.id,
  disp = "Картошка",
  tak = "Взваливаю на свои хрупкие плечи пакет с картошкой.",
  inv = "Картошка могла быть лучше, если бы сразу родилась в приготовленном виде.",
  use = function (this, another)
    pn(another.disp.." не предназначен для картошки.")
  end
}
