local ids = require "ids"

obj {
  nam = ids.fridge.id,
  disp = "Холодильник",
  dsc = "Возле стенки примостился {холодильник}.",
  act = function ()
    pn "Заглядываю в холодильник."
    walk(ids.fridge_inner.id)
  end,
}
