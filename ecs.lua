local args = {...}
local directory = args[1] .. '.'

local Logger = require("lib.dota-lua-debug.debug").logging
local log = nil
if Logger == nil then
    log = {debug = function(msg) end}
else
    log = Logger()
end

local event = require(directory .. 'event')
log:debug({event=event})

local units = {
    entity=entity,
    component=component,
    event = event

}

return units

