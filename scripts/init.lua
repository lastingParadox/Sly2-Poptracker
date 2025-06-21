ScriptHost:LoadScript("scripts/items_import.lua")
ScriptHost:LoadScript("scripts/logic_helpers.lua")

Tracker:AddMaps("maps/maps.json")

-- Layout
Tracker:AddLayouts("layouts/item_grids.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/tracker.json")

-- Locations
ScriptHost:LoadScript("scripts/locations_import.lua")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
