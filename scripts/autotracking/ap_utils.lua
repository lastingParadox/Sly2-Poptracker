local base_id = 123056

local episodes = {
    "black_chateau",
    "starry_eyed_encounter",
    "predator_awakes",
    "jailbreak",
    "tangled_web",
    "he_who_tames_the_iron_horse",
    "menace_from_the_north",
    "anatomy_for_disaster",
}

function handle_bottle_item(item_id)
    local offset = item_id - base_id

    local episode_name
    local bottle_amount

    if offset >= 0 and offset < #episodes then
        -- Single bottle item
        episode_name = episodes[offset + 1]
        bottle_amount = 1
    else
        -- Multi-bottle item
        local multi_offset = item_id - (base_id + #episodes)
        local episode_index = math.floor(multi_offset / 29)
        local bottle_index = multi_offset % 29 + 2 -- bottles 2–30

        episode_name = episodes[episode_index + 1]
        bottle_amount = bottle_index

        if not episode_name or bottle_amount > 30 then
            return -- Invalid item ID
        end
    end

    -- Lookup and increment tracker object
    local code = "bottle_" .. episode_name
    local object = Tracker:FindObjectForCode(code)
    if object then
        object.AcquiredCount = object.AcquiredCount + bottle_amount
        return code
    end
end
