local ids = require "ids"
local utils = require "utils"

obj {
  nam = ids.kitchen_table.id,
  disp = "Кухонный стол",
  dsc = function (this)
    local objs = this.obj
    local objs_length = #objs
    if objs_length > 0 then
      if utils.has(this, ids.bowl.id) then
        return "На {столе} стоит {"..ids.bowl.id.."|тазик}."
      else
        return "{Стол} стоит рядом с окном."
      end
    end
    return "Пустой {стол} стоит рядом с окном."
  end,
  act = "Он слегка грязный, но я все равно его люблю таким, какой он есть.",
}:with {
  ids.bowl.id,
}
