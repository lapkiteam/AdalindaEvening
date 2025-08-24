local ids = require "ids"
local Cucumber = require "objects.cucumbers"
local NunchucksElement = require "objects.nunchucks_element"

obj {
  nam = ids.screw.id,
  disp = function (this)
    if NunchucksElement.is_nunchucks_element(this:where()) then
      return false
    end
    return "Шуруп"
  end,
  tak = "Вот ты и попался, маленький гаденыш!",
  inv = "Шуруп длинной в 16 мм с шагом резьбы в 2.75 мм и с полупотайной головкой диаметром в 8.5 мм. Сделан из углеродистой стали и покрыт фосфатом. Острый. Пару раз ловила подошвой. Теперь про этого гаденыша знаю всё.",
  dsc = function (this)
    if this:inroom().nam == ids.corridor.id then
      return "На половичке незаметно разлегся {шуруп}."
    end
    return "{Шуруп} валяется на полу."
  end,
  use = function (this, another)
    if Cucumber.is_cucumber(another) then
      local nunchucks_element = (function ()
        local nunchucks_element1 = ids.nunchucks_element1:get()
        if #nunchucks_element1.obj ~= 0 then
          return ids.nunchucks_element2:get()
        end
        return nunchucks_element1
      end)()
      take(nunchucks_element)
      place(this, nunchucks_element)
      place(another, nunchucks_element)
      return "Вкручиваю шуруп в огурец..."
    end
    return "Нет, тебя я никому не отдам, маленький паршивец."
  end,
}
