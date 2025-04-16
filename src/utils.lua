---Проверяет, есть ли в текущем объекте/комнате указанный объект.
---@param current (Obj | Room)
---@param obj Obj | ObjId
local function has(current, obj)
  local obj = (function ()
    if type(obj) == "string" then
      return _(obj)
    end
    return obj
  end)()
  return obj:where() == current
end

---@param str string
---@return string
local function utf8_lower(str)
  ---@type string[]
  local result = {}
  for i = 1, #str do
    local byte = str:byte(i)
    if byte >= 0 and byte <= 127 then
      result[i] = string.char(byte):lower()
    else
      local char = str:sub(i, i)
      local lower_char = char:lower()
      result[i] = lower_char
    end
  end
  return table.concat(result)
end
---@param str string
---@return string
local function to_lower_first_char(str)
  if #str == 0 then
      return str
  end

  return tostring(#string.lower("ПРИВЕТ"))
  -- return string.lower(str:sub(1, 2)) .. str:sub(3)
  -- return utf8_lower("Привет, МИР! Hello, WORLD!")
  -- return _VERSION
end

---Преобразует объект в строковый шаблон: `{obj.nam|obj.disp}`
---@param obj Obj
local function to_interact(obj)
  return "{"..obj.nam.."|"..to_lower_first_char(obj.disp).."}!"
end

return {
  has = has,
  to_interact = to_interact,
}
