TestRaidMarker = {}
    -- @covers RaidMarker::getPrintableString()
    function TestRaidMarker:testGetPrintableString()
        local raidMarker = __.TEMPORARY_RAID_MARKER

        lu.assertEquals('\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0\124t', raidMarker:getPrintableString())
    end
-- end of TestRaidMarker