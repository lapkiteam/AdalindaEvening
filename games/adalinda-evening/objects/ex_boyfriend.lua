local ids = require "ids"
local utils = require "utils"

---@class ExBoyfriendModel
---@field talked boolean
local model = {}

function model.new()
  ---@type ExBoyfriendModel
  local instance = {
    talked = false,
  }
  return instance
end

---@param model ExBoyfriendModel
function model.talk(model)
  model.talked = true
end

obj {
  nam = ids.ex_boyfriend.id,
  disp = "Бывший",
  state = model:new(),
  dsc = function (this)
    if this:inroom().nam == ids.corridor.id then
      local state = this.state --[[@type ExBoyfriendModel]]
      if state.talked then
        return "{"..ids.ex_boyfriend.id.."|Бывший} трындит по телефону со своей новой пассией."
      end
      return "У порога топчется {"..ids.ex_boyfriend.id.."|бывший}."
    end
  end,
  act = function (this)
    local state = this.state --[[@type ExBoyfriendModel]]
    if state.talked then
      return "Я ему в прошлый раз всё высказала."
    else
      model.talk(state)
      return "В ходе горячих объяснений выяснилось, что он пришел, видите ли, забрать свои огурцы, которые когда-то купил."
    end
  end
}
