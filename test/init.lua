-- https://github.com/silentbicycle/lunatest
local lunatest = require "lunatest"
local assert_equal, assert_not_equal = lunatest.assert_equal, lunatest.assert_not_equal

pcall(require, "luacov")
-- lunatest.suite("test_first")
-- lunatest.suite("test_second")
--lunatest.suite("test_ecs")
lunatest.suite("test.test_event")

lunatest:run()
