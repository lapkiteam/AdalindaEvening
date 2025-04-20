---Проверяет, есть ли в текущем объекте/комнате указанный объект.
---@param current (Obj | Room)
---@param obj Obj | ObjId
local function has(current, obj)
  local obj = (function ()
    if type(obj) == "string" then
      return _(obj) --[[@as Obj]]
    end
    return obj
  end)()
  return obj:where() == current
end

---@param str string
---@return string
local function to_lower_first_char(str)
  -- todo
  return str
end

---Преобразует объект в строковый шаблон: `{obj.nam|obj.disp}`
---@param obj Obj
local function to_interact(obj)
  return "{"..obj.nam.."|"..to_lower_first_char(obj.disp).."}"
end

return {
  has = has,
  to_interact = to_interact,
  to_lower_first_char = to_lower_first_char,
}
