lu = require('luaunit')

dofile('./dist/stormwind-library.lua')
function newLibrary() return StormwindLibrary_v0_0_6.new() end
    __ = newLibrary()

dofile('./tests/Core/FactoryTest.lua')

dofile('./tests/Facades/TargetTest.lua')

dofile('./tests/Models/MacroTest.lua')

dofile('./tests/Support/ArrTest.lua')
dofile('./tests/Support/StrTest.lua')

lu.ORDER_ACTUAL_EXPECTED=false

os.exit(lu.LuaUnit.run())