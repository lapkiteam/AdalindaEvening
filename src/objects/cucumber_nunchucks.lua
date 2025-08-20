local ids = require "ids"

obj {
  nam = ids.cucumber_nunchucks.id,
  disp = "Огуречные нунчаки",
  tak = "Теперь они у меня *зловещий смех*",
  dsc = "На полу валяются {огуречные нунчаки}.",
  inv = "Крайне опасная штука, если так подумать.",
  use = function (this, another)
    if another.nam == ids.ex_boyfriend.id then
      another:remove()
      this:remove()
      return "Бывший улепетывает от моего перфоманса. Я — за ним. Пару раз успеваю огреть его прежде, чем он покидает квартиру. Похоже, огурцы ему больше не нужны — придется оставить себе."
    end
    return "Не хочу это сломать."
  end,
}
