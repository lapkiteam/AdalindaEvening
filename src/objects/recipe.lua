local ids = require "ids"

obj {
  nam = ids.recipe.id,
  disp = "Рецепт",
  dsc = "{Рецепт} весит на стене.",
  act = function ()
    pn "Низкокалорийный салатик:"
    pn "* Кусок колбасы"
    pn "* Пару огурцов"
    pn "* Банка горошка"
    pn "* Банка майонеза"
  end,
}
