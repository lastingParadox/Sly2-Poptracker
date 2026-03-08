-- Settings logic for conditional visibility
-- Disables certain settings based on other setting values

-- Grey out "Required Keys Goal" unless goal is set to "Clockwerk Hunt" (goal_6)
local function update_goal_required_keys_visibility()
    local required_keys_item = Tracker:FindObjectForCode("goal_required_keys")

    if required_keys_item then
        -- Check if goal_6 (Clockwerk Hunt) is active
        local is_clockwerk_hunt = Tracker:ProviderCountForCode("goal_6") > 0

        -- Grey out the item if not Clockwerk Hunt, show normally if it is
        if is_clockwerk_hunt then
            required_keys_item.Icon = ImageReference:FromPackRelativePath("images/system/goal_required_keys.png")
            required_keys_item.IgnoreUserInput = false
        else
            required_keys_item.Icon = ImageReference:FromImageReference("images/system/goal_required_keys.png",
                "@disabled")
            required_keys_item.IgnoreUserInput = true
        end
    end
end

-- Grey out "Required Keys Episode 8" if Episode 8 Keys is set to "Off"
local function update_episode_8_required_keys_visibility()
    local required_keys_item = Tracker:FindObjectForCode("episode_8_keys_required")

    if required_keys_item then
        -- Check if episode_8_keys is set to off (stage 3)
        local is_off = Tracker:ProviderCountForCode("episode_8_keys_off") > 0

        -- Grey out the item if Episode 8 Keys is Off
        if is_off then
            required_keys_item.Icon = ImageReference:FromImageReference("images/system/episode_8_required_keys.png",
                "@disabled")
            required_keys_item.IgnoreUserInput = true
        else
            required_keys_item.Icon = ImageReference:FromPackRelativePath("images/system/episode_8_required_keys.png")
            required_keys_item.IgnoreUserInput = false
        end
    end
end

-- Grey out Bottlesanity if bottle_location_bundle_size is 0
-- Track the previous stage so we can restore it when re-enabled
local bottlesanity_saved_stage = nil
local bottlesanity_currently_disabled = false

local function update_bottlesanity_visibility()
    local bottlesanity_item = Tracker:FindObjectForCode("bottlesanity")
    local bundle_size_item = Tracker:FindObjectForCode("bottle_location_bundle_size")

    if bottlesanity_item and bundle_size_item then
        local bundle_size = bundle_size_item.AcquiredCount

        -- Grey out bottlesanity if bundle size is 0
        if bundle_size == 0 then
            if not bottlesanity_currently_disabled then
                -- Save current stage before disabling
                bottlesanity_saved_stage = bottlesanity_item.CurrentStage
                bottlesanity_currently_disabled = true
            end
            -- Force to off stage and grey it out
            bottlesanity_item.CurrentStage = 0
            bottlesanity_item.Icon = ImageReference:FromImageReference("images/system/bottlesanity_off.png", "@disabled")
            bottlesanity_item.IgnoreUserInput = true
        else
            if bottlesanity_currently_disabled then
                -- Restore the saved stage when re-enabling
                if bottlesanity_saved_stage ~= nil then
                    bottlesanity_item.CurrentStage = bottlesanity_saved_stage
                    if bottlesanity_item.CurrentStage == 0 then
                        bottlesanity_item.Icon = ImageReference:FromPackRelativePath("images/system/bottlesanity_off.png")
                    else
                        bottlesanity_item.Icon = ImageReference:FromPackRelativePath("images/system/bottlesanity_on.png")
                    end
                end
                -- Restore normal appearance (stage-based icons will be used automatically)
                bottlesanity_item.IgnoreUserInput = false
                bottlesanity_currently_disabled = false
            end
        end
    end
end

-- Watch for changes to relevant settings
ScriptHost:AddWatchForCode("goal_visibility_watch", "goal", update_goal_required_keys_visibility)
ScriptHost:AddWatchForCode("episode_8_keys_visibility_watch", "episode_8_keys", update_episode_8_required_keys_visibility)
ScriptHost:AddWatchForCode("bottlesanity_visibility_watch", "bottle_location_bundle_size", update_bottlesanity_visibility)

-- Initialize on load
update_goal_required_keys_visibility()
update_episode_8_required_keys_visibility()
update_bottlesanity_visibility()
