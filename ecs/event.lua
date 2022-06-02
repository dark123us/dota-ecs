local Logger = require("lib.dota-lua-debug.debug").logging
local log = nil
if Logger == nil then
    log = {debug = function(msg) end}
else
    log = Logger()
end

local unit = {}

local events = {}

function unit:register(name)
    log:debug("register " .. name)
    events[name] = {id=0, listener={}}
end

function unit:notify(name, data)
    log:debug("notify " .. name)
    for k, v in pairs(events[name].listener) do
        v(data)
    end
end

function unit:subscribe(name, callback)
    if events[name] ~= nil then
        local e = events[name]
        e.id = e.id + 1
        e.listener[e.id] = callback
        return e.id
    end
end

function unit:describe(name, id)
    if events[name] ~= nil then
        events[name].listener[id] = nil
    end
end


return unit

