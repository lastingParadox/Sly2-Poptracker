function has_item(item, amount)
	local count = Tracker:ProviderCountForCode(item)
	amount = tonumber(amount)
	if not amount then
		return count > 0
	else
		return count >= amount
	end
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
