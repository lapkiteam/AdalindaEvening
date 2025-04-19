local ids = require "ids"
local utils = require "utils"

obj {
  nam = ids.kitchen_table.id,
  disp = "Кухонный стол",
  dsc = function (this)
    local objs = this.obj
    local objs_length = #objs
    if objs_length == 1 then
      return "На {столе} лежит "..utils.to_interact(this.obj[1]).."."
    elseif objs_length > 1 then
      pr ("На {столе} лежат: ")
      ---@type string[]
      local name_objs = {}
      for i = 1, objs_length, 1 do
        local obj = objs[i]
        table.insert(name_objs, utils.to_interact(obj))
      end
      pr(table.concat(name_objs, ", "))
      pr "."
      return
    end
    return "Пустой {стол} стоит рядом с окном."
  end,
  act = "Он слегка грязный, но я все равно его люблю таким, какой он есть.",
}:with {
  ids.bowl.id,
  ids.sausage.id,
  ids.cucumbers.id,
  ids.canned_peas.id,
}
