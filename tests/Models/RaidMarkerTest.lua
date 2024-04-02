TestRaidMarker = BaseTestClass:new()
    -- @covers RaidMarker::getPrintableString()
    function TestRaidMarker:testGetPrintableString()
        lu.assertEquals('\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0\124t', __.raidMarkers['skull']:getPrintableString())
        lu.assertEquals('', __.raidMarkers[0]:getPrintableString())
    end

    -- @covers StormwindLibrary.raidMarkers
    function TestRaidMarker:testRaidMarkersIsSet()
        lu.assertIsTable(__.raidMarkers)

        lu.assertNotIsNil(__.raidMarkers['remove'])
        lu.assertNotIsNil(__.raidMarkers['star'])
        lu.assertNotIsNil(__.raidMarkers['circle'])
        lu.assertNotIsNil(__.raidMarkers['diamond'])
        lu.assertNotIsNil(__.raidMarkers['triangle'])
        lu.assertNotIsNil(__.raidMarkers['moon'])
        lu.assertNotIsNil(__.raidMarkers['square'])
        lu.assertNotIsNil(__.raidMarkers['x'])
        lu.assertNotIsNil(__.raidMarkers['skull'])

        for i = 0, 8 do lu.assertNotIsNil(__.raidMarkers[i]) end

        lu.assertIsNil(__.raidMarkers[9])
    end
-- end of TestRaidMarker