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
---@field initialized boolean
local obj_getter = std.class({})

---@param obj_id ObjId
---@param initialized boolean?
---@return ObjGetter
function obj_getter:new(obj_id, initialized)
  ---@type ObjGetter
  local instance = {
    id = obj_id,
    initialized = (function ()
      if initialized == nil then return true
      else return initialized
      end
    end)(),
  }
  return setmetatable(instance, self)
end

---@return Obj?
function obj_getter:try_get()
  if not self.initialized then
    return nil
  end
  return _(self.id) --[[@as Obj]]
end

---@return Obj
function obj_getter:get()
  return _(self.id) --[[@as Obj]]
end

function obj_getter:init()
  self.initialized = true
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
  cucumber1 = obj_getter:new("cucumber1"),
  cucumber2 = obj_getter:new("cucumber2"),
  cucumber3 = obj_getter:new("cucumber3"),
  canned_peas = obj_getter:new("canned_peas"),
  potato = obj_getter:new("potato"),
  eggs = obj_getter:new("eggs"),
  mayo = obj_getter:new("mayo"),
  cucumber_nunchucks = obj_getter:new("cucumber_nunchucks"),
  fridge = obj_getter:new("fridge"),
  sink_cabinet = obj_getter:new("sink_cabinet"),
  corkscrew = obj_getter:new("corkscrew"),
  nunchucks_element1 = obj_getter:new("nunchucks_element1", false),
  nunchucks_element2 = obj_getter:new("nunchucks_element2", false),
  screw = obj_getter:new("screw"),
  chain = obj_getter:new("chain"),
  -- characters
  ex_boyfriend = obj_getter:new("ex_boyfriend"),
  -- rooms
  hall = room_getter:new("hall"),
  the_end = room_getter:new("the_end"),
  kitchen = room_getter:new("кухня"),
  fridge_inner = room_getter:new("fridge_inner"),
  sink_cabinet_inner = room_getter:new("sink_cabinet_inner"),
  corridor = room_getter:new("corridor"),
}

return ids
