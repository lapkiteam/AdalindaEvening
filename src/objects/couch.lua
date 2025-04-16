---@class CouchModel
---@field pulled boolean
local couch_model = {}
couch_model.__index = couch_model

function couch_model:new()
  ---@type CouchModel
  local instance = {
    pushed_back = false,
  }
  return setmetatable(instance, self)
end

function couch_model:push_back()
  self.pulled = true
end

function couch_model:push()
  self.pulled = false
end

---@class Couch: Obj
local couch = std.class({}, obj)

---@param id ObjId
---@param events { on_pulled: (fun(): boolean?)?, on_pushed: (fun(): boolean?)? }
---@return Couch
function couch:new(id, events)
  local instance = obj {
    disp = "Диванчик",
    state = couch_model:new(),
    dsc = function (this)
      ---@type CouchModel
      local model = this.state
      if not model.pulled then
        return "Любимый {диванчик} стоит возле стены."
      else
        return "Любимый {диванчик} отодвинут от стены."
      end
    end,
    act = function (this)
      ---@type CouchModel
      local model = this.state
      if model.pulled then
        if events.on_pushed then
          local handled = events.on_pushed()
          if handled ~= nil and not handled then
            return
          end
        end
        pn "Толкаю диван к стене."
        model:push()
      else
        if events.on_pulled then
          local handled = events.on_pulled()
          if handled ~= nil and not handled then
            return
          end
        end
        pn "Отодвигаю диван от стены."
        model:push_back()
      end
    end
  }
  ---@cast instance Couch
  return setmetatable(instance, self)
end

return couch
