local ids = require "ids"

obj {
  nam = ids.canned_peas.id,
  disp = "Банка горошка",
  dsc = function (this)
    local where = this:where()
    if where.nam == ids.sink_cabinet_inner.id then
      return "В угол закатилась {жестяная банка с горошком}."
    elseif where.nam == ids.bowl.id then
      return false
    end
    return "На полу валяется {банка горошка}."
  end,
  tak = "Подхватываю горошек на лету.",
  inv = "Жестяная банка горошка плотно закрыта, но это мы еще посмотрим.",
  use = function (this, another)
    pn(another.disp.." не нуждается в банке гороха.")
  end
}
