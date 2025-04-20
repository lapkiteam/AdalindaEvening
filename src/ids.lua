---@class RoomGetter
---@field id RoomId
local room_getter = std.class({})

---@param room_id RoomId
---@return RoomGetter
function room_getter:new(room_id)
  ---@type RoomGetter
  local instance = {
    id = room_id,
  }
  return setmetatable(instance, self)
end

---@return Room
function room_getter:get()
  return _(self.id) --[[@as Room]]
end

---@class ObjGetter
---@field id ObjId
local obj_getter = std.class({})

---@param obj_id ObjId
---@return ObjGetter
function obj_getter:new(obj_id)
  ---@type ObjGetter
  local instance = {
    id = obj_id,
  }
  return setmetatable(instance, self)
end

---@return Obj
function obj_getter:get()
  return _(self.id) --[[@as Obj]]
end

local ids = {
  -- objects
  salad_place = obj_getter:new("место_для_салата"),
  salad = obj_getter:new("салат"),
  couch = obj_getter:new("диванчик"),
  kitchen_table = obj_getter:new("kitchen_table"),
  bowl = obj_getter:new("bowl"),
  recipe = obj_getter:new("recipe"),
  sausage = obj_getter:new("sausage"),
  cucumbers = obj_getter:new("cucumbers"),
  canned_peas = obj_getter:new("canned_peas"),
  potato = obj_getter:new("potato"),
  eggs = obj_getter:new("eggs"),
  -- rooms
  hall = room_getter:new("hall"),
  the_end = room_getter:new("the_end"),
  kitchen = room_getter:new("кухня"),
}

return ids
