local ids = require "ids"
local utils = require "utils"

obj {
  nam = ids.kitchen_table.id,
  disp = "Кухонный стол",
  dsc = function (this)
    -- local bowl = ids.bowl:get()
    -- local salad = ids.salad:get()

    if not empty(this) then
      p "На {кухонном столе} стоит: "
      this:for_each(function (obj)
        p (utils.to_interact(obj)..",")
      end)
      p "."
      return
      -- if utils.has(this, bowl) then
      --   return utils.to_interact(bowl).." стоит ."
      -- elseif utils.has(this, salad) then
      --   return "{"..salad.nam.."|Готовый салатик} стоит на {кухонном столе}."
      -- end
    end
    return "{Кухонный стол}."
  end,
  act = "Он слегка грязный, но я все равно его люблю таким, какой он есть.",
}:with {
  ids.bowl.id,
  ids.sausage.id,
  ids.cucumbers.id,
  ids.canned_peas.id,
}
