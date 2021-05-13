--[[
    ShowChamberNumber
    Authors:
      Museus (Discord: Museus#7777)
      Ellomenop (Discord: ellomenop#2254)

    This version of ShowChamberNumber shows the Depth immediately upon starting a room,
    rather than waiting for the CombatUI to spawn. If that fails for some reason, fall back
    to showing the Depth during ShowCombatUI.
]]
ModUtil.RegisterMod("ShowChamberNumber")

local config = {
    ShowDepth = true,
}
ShowChamberNumber.config = config

-- Scripts/RoomManager.lua : 1874
ModUtil.WrapBaseFunction("StartRoom", function ( baseFunc, currentRun, currentRoom )
    if config.ShowDepth then
        ShowDepthCounter()
    end

    baseFunc(currentRun, currentRoom)
end, ShowChamberNumber)

-- Scripts/UIScripts.lua : 145
ModUtil.WrapBaseFunction("ShowCombatUI", function ( baseFunc, flag )
    if config.ShowDepth then
        ShowDepthCounter()
    end

    baseFunc(flag)
end, ShowChamberNumber)

-- Hiding Depth Counter doesn't actually do anything
ModUtil.WrapBaseFunction("HideDepthCounter", function ( baseFunc )
    if config.ShowDepth then
        return
    end

    baseFunc()
end, ShowChamberNumber)