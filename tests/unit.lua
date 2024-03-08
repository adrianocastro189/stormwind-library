lu = require('luaunit')

dofile('./dist/stormwind-library.lua')
__ = StormwindLibrary_v0_0_4.new()

dofile('./tests/Facades/TargetTest.lua')

dofile('./tests/Support/ArrTest.lua')

os.exit(lu.LuaUnit.run())