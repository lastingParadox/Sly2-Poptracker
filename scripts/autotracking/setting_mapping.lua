SLOT_CODES = {
    episode_8_keys = {
        code = "episode_8_keys",
        type = "progressive",
        mapping = {
            [0] = 0, -- First Section
            [1] = 1, -- Last Section
            [2] = 2, -- Whole Episode
            [3] = 3, -- Off
        }
    },
    required_keys_episode_8 = {
        code = "episode_8_keys_required",
        type = "consumable"
    },
    bottlesanity = {
        code = "bottlesanity",
        type = "progressive",
        mapping = {
            [0] = 0, -- Bottlesanity off
            [1] = 1  -- Bottlesanity on
        }
    },
    bottle_item_bundle_size = {
        code = "bottle_bundle_size",
        type = "consumable"
    },
    bottle_location_bundle_size = {
        code = "bottle_location_bundle_size",
        type = "consumable"
    },
    include_vaults = {
        code = "include_vaults",
        type = "progressive",
        mapping = {
            [0] = 0, -- Vaults off
            [1] = 1  -- Vaults on
        }
    },
    include_pickpocketing = {
        code = "include_pickpocketing",
        type = "progressive",
        mapping = {
            [0] = 0, -- Pickpocketing off
            [1] = 1  -- Pickpocketing on
        }
    },
    include_tom = {
        code = "include_tom",
        type = "progressive",
        mapping = {
            [0] = 0, -- TOM off
            [1] = 1  -- TOM on
        }
    },
    include_mega_jump = {
        code = "include_mega_jump",
        type = "progressive",
        mapping = {
            [0] = 0, -- Mega Jump off
            [1] = 1  -- Mega Jump on
        }
    },
    include_time_rush = {
        code = "include_time_rush",
        type = "progressive",
        mapping = {
            [0] = 0, -- Time Rush off
            [1] = 1  -- Time Rush on
        }
    },
    goal = {
        code = "goal",
        type = "progressive",
        mapping = {
            [0] = 0, -- Dimitri
            [1] = 1, -- Rajan
            [2] = 2, -- The Contessa
            [3] = 3, -- Jean Bison
            [4] = 4, -- Clockla
            [5] = 5, -- All Bosses
            [6] = 6, -- Clockwerk Hunt
            [7] = 7  -- All Vaults
        }
    },
    required_keys_goal = {
        code = "goal_required_keys",
        type = "consumable"
    }
}
