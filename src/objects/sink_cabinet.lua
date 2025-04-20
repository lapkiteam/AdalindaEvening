local ids = require "ids"

obj {
  nam = ids.sink_cabinet.id,
  disp = "Шкафчик под раковиной",
  dsc = "Под раковиной расположен {шкафчик}.",
  act = function ()
    pn "Заглядываю в шкафчик."
    walk(ids.sink_cabinet_inner.id)
  end,
}
