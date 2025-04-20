local ids = require "ids"

obj {
  nam = ids.canned_peas.id,
  disp = "Банка горошка",
  tak = "Подхватываю горошек на лету.",
  inv = "Жестяная банка горошка плотно закрыта, но это мы еще посмотрим.",
  use = function (this, another)
    pn(another.disp.." не нуждается в банке гороха.")
  end
}
