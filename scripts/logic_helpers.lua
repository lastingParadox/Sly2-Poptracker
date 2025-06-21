function has_item(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function vault_check(episode, amount)
    local has_episode = episode == "anatomy_for_disaster" and anatomy_for_disaster_check(amount) or
        has_item("progressive_" .. episode, amount)
    local bottlesanity = has_item("bottlesanityon")

    if not has_episode then return false end
    if not bottlesanity then return true end

    local bundle_size = Tracker:ProviderCountForCode("bottle_bundle_size")
    if bundle_size == 0 then return has_episode end

    local bundle_code = (bundle_size == 1 and "bottle_" or bundle_size .. "_bottles_") .. episode
    local required_bundle_amount = 30 // bundle_size
    local remainder = 30 % bundle_size

    local has_bundles = has_item(bundle_code, required_bundle_amount)
    if remainder ~= 0 then
        local remainder_code = (remainder == 1 and "bottle_" or bundle_size .. "_bottles_") .. episode
        return has_bundles and has_item(remainder_code)
    end

    return has_bundles
end

function anatomy_for_disaster_check(amount)
    local clockwerk_count = Tracker:ProviderCountForCode("clockwerkpart")
    local required_part_count = Tracker:ProviderCountForCode("episode8keysrequired")
    amount = tonumber(amount)

    -- Setting: episode8keysepisode
    if has_item("episode8keysepisode") then
        return clockwerk_count >= required_part_count
    end

    -- Setting: episode8keysfirst
    if has_item("episode8keysfirst") then
        if amount == 1 then
            return clockwerk_count >= required_part_count
        else
            return has_item("progressive_anatomy_for_disaster", amount - 1)
        end
    end

    -- Setting: episode8keyslast
    if has_item("episode8keyslast") then
        if amount == 4 then
            return clockwerk_count >= required_part_count
        else
            return has_item("progressive_anatomy_for_disaster", amount)
        end
    end

    -- Setting: episode8keysoff (default/fallback)
    -- Progressive requirement scales with level 1–4
    return has_item("progressive_anatomy_for_disaster", amount)
end
