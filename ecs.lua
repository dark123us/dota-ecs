local args = {...}
local directory = args[1] .. '.'

local event = require(directory .. 'event')

local units = {
    entity=entity,
    component=component,
    event = event
}

return units

