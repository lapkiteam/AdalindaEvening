local ids = require "ids"

obj {
  nam = ids.cucumber_nunchucks.id,
  disp = "Огуречные нунчаки",
  tak = "Теперь они у меня *зловещий смех*",
  dsc = "На полу валяются {огуречные нунчаки}.",
  inv = "Крайне опасная штука, если так подумать.",
  use = function (this, another)
    return "Не хочу это сломать."
  end,
}
