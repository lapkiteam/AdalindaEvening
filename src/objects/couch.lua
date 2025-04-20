---@class CouchModel
---@field pulled boolean

local couch_model = {}

function couch_model.new()
  ---@type CouchModel
  local instance = {
    pulled = false,
  }
  return instance
end

---@param model CouchModel
function couch_model.pull(model)
  model.pulled = true
end

---@param model CouchModel
function couch_model.push(model)
  model.pulled = false
end

---@class Couch: Obj
local couch = std.class({}, obj)

---@param id ObjId
---@param events { on_pulled: (fun(): boolean?)?, on_pushed: (fun(): boolean?)? }
---@return Couch
function couch:new(id, events)
  local instance = obj {
    nam = id,
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
        couch_model.push(model)
      else
        if events.on_pulled then
          local handled = events.on_pulled()
          if handled ~= nil and not handled then
            return
          end
        end
        pn "Отодвигаю диван от стены."
        couch_model.pull(model)
      end
    end
  }
  ---@cast instance Couch
  return setmetatable(instance, self)
end

return couch
