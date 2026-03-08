function has_item(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function has_item_exactly(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return false
    else
        return count == amount
    end
end

function vault_check(episode, amount)
    local has_episode = episode == "anatomy_for_disaster" and anatomy_for_disaster_check(amount) or
        has_item("progressive_" .. episode, amount)
    local bottlesanity = has_item("bottlesanityon")

    if not has_episode then return false end
    if not bottlesanity then return true end

    return has_item("bottle_" .. episode, 30)
end

function anatomy_for_disaster_check(amount)
    local clockwerk_count = Tracker:ProviderCountForCode("clockwerkpart")
    local required_part_count = Tracker:ProviderCountForCode("episode_8_keys_required")
    amount = tonumber(amount)

    -- Setting: episode_8_keys_episode
    if has_item("episode_8_keys_episode") then
        return clockwerk_count >= required_part_count
    end

    -- Setting: episode_8_keys_first
    if has_item("episode_8_keys_first") then
        if amount == 1 then
            return clockwerk_count >= required_part_count
        else
            return has_item("progressive_anatomy_for_disaster", amount - 1)
        end
    end

    -- Setting: episode_8_keys_last
    if has_item("episode_8_keys_last") then
        if amount == 4 then
            return clockwerk_count >= required_part_count
        else
            return has_item("progressive_anatomy_for_disaster", amount)
        end
    end

    -- Setting: episode_8_keys_off (default/fallback)
    -- Progressive requirement scales with level 1–4
    return has_item("progressive_anatomy_for_disaster", amount)
end
