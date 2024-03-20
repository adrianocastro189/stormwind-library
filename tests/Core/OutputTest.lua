TestOutput = {}
    --[[
    @covers Output:__construct()
    ]]
    function TestOutput:testCanInstantiate()
        lu.assertNotIsNil(__:new('Output'))
    end
-- end of TestOutput