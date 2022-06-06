local events = {}
local unit = {}

function unit.events()
    return events
end

function unit.register(name)
    if events[name] == nil then
        events[name] = {id=0, listener={}}
    end
end

function unit.unregister(name)
    events[name] = nil
end

function unit.notify(name, data)
    if events[name] == nil then return end
    for k, v in pairs(events[name].listener) do
        v(data)
    end
end

function unit.subscribe(name, callback)
    if events[name] == nil then
        unit.register(name)
    end

    local e = events[name]
    e.id = e.id + 1
    e.listener[e.id] = callback
    return e.id
end

function unit.describe(name, id)
    if events[name] ~= nil then
        events[name].listener[id] = nil
    end
end


return unit

