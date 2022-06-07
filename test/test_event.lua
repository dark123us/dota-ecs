local lunatest = require "lunatest"
local assert_equal, assert_not_equal = lunatest.assert_equal, lunatest.assert_not_equal

-- local event = require('ecs.event')
local event = require('ecs').event

local unit = {}

local TEST1 = 'test1'
local TEST2 = 'test2'

local len = function(table)
    local c = 0
    for _ in pairs(table) do c = c + 1 end
    return c
end

local clear = function()
    local e = event:events()
    for name in pairs(e) do
        event:unregister(name)
    end
end

function unit:test_require ()
    assert_not_equal(event, nil)
end


function unit:test_register ()
    local e = event:events()
    assert_equal(len(e), 0)

    event:register(TEST1)
    assert_equal(len(e), 1)

    event:register(TEST2)
    assert_equal(len(e), 2)

    event:register(TEST2)
    assert_equal(len(e), 2)

    event:unregister(TEST1)
    event:unregister(TEST2)
    assert_equal(len(e), 0)
    clear()
end

function unit:test_subscribe()
    local e = event:events()
    event:register(TEST1)
    local res = {}
    local id = event:subscribe(TEST1, function(data) res[0] = data end)
    assert_equal(len(e[TEST1].listener), 1)
    assert_equal(id, 1)

    id = event:subscribe(TEST1, function(data) res[1] = data end)
    assert_equal(len(e[TEST1].listener), 2)
    assert_equal(id, 2)

    event:describe(TEST1, id)
    assert_equal(len(e[TEST1].listener), 1)
    assert_not_equal(e[TEST1].listener[1], nil)
    assert_equal(e[TEST1].listener[2], nil)

    clear()
end

function unit:test_notify()
    local REQ = "hello"
    local e = event:events()
    event:register(TEST1)
    local res = {}
    event:subscribe(TEST1, function(data) res[0] = data end)
    event:subscribe(TEST1, function(data) res[1] = data end)

    event:notify(TEST1, REQ)

    assert_equal(res[0], REQ)
    assert_equal(res[1], REQ)

    clear()
end

return unit

