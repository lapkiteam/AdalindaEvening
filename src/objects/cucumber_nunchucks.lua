local ids = require "ids"

obj {
  nam = ids.cucumber_nunchucks.id,
  disp = "Огуречные нунчаки",
  tak = function (this)
    if this:inroom().nam == ids.corridor.id then
      return false
    end
    return "Теперь они у меня, *зловещий смех*."
  end,
  act = function (this)
    if this:inroom().nam == ids.corridor.id then
      return "Красиво висят, болтаются. Отличное напоминание о моей победе."
    end
  end,
  dsc = function (this)
    if this:inroom().nam == ids.corridor.id then
      return "{Огуречные нунчаки} торчат в стене."
    end
    return "На полу валяются {огуречные нунчаки}."
  end,
  inv = "Крайне опасная штука, если так подумать.",
  use = function (this, another)
    if another.nam == ids.ex_boyfriend.id then
      another:remove()
      place(this)
      return "Бывший улепетывает от моего перфоманса. Я — за ним. Пару раз успеваю огреть его прежде, чем он покидает квартиру. Похоже, огурцы ему больше не нужны — придется оставить себе."
    end
    return "Не хочу это сломать."
  end,
}
