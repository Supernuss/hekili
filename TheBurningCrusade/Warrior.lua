-- Warrior.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Warrior (#1)

if UnitClassBase( "player" ) ~= "WARRIOR" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 1 )

spec:RegisterGear( "tier4", 29011, 29012, 29015, 29016, 29017 )
spec:RegisterGear( "tier5", 30113, 30114, 30115, 30116, 30117 )
spec:RegisterGear( "tier6", 30969, 30970, 30972, 30974, 30975, 30976, 30977, 30978, 30979, 30980 )
spec:RegisterGear( "sunwell", 34441, 34442, 34546, 34547, 34568, 34569 )

local TBC_RAGE_CONVERSION = 274.7
local TBC_RAGE_DEALT_FACTOR = 3.75 / TBC_RAGE_CONVERSION
local TBC_RAGE_TAKEN_FACTOR = 2.5 / TBC_RAGE_CONVERSION
local TBC_RAGE_MAINHAND_HIT_FACTOR = 3.5 / 2
local TBC_RAGE_OFFHAND_HIT_FACTOR = 1.75 / 2
local PASSIVE_RAGE_DAMAGE_WINDOW = 10

local passive_rage_damage_events = {}

local function trim_passive_rage_damage_events( now )
    local cutoff = now - PASSIVE_RAGE_DAMAGE_WINDOW

    while passive_rage_damage_events[1] and passive_rage_damage_events[1].t < cutoff do
        table.remove( passive_rage_damage_events, 1 )
    end
end

local function add_passive_rage_damage_event( amount )
    if not amount or amount == 0 then return end

    local now = GetTime and GetTime() or 0
    passive_rage_damage_events[ #passive_rage_damage_events + 1 ] = { t = now, v = amount }
    trim_passive_rage_damage_events( now )
end

local function get_passive_incoming_damage_per_second()
    local now = GetTime and GetTime() or 0
    trim_passive_rage_damage_events( now )

    local net_damage = 0

    for i = 1, #passive_rage_damage_events do
        net_damage = net_damage + passive_rage_damage_events[i].v
    end

    return max( 0, net_damage ) / PASSIVE_RAGE_DAMAGE_WINDOW
end

local function gain_warrior_rage( amount )
    if not amount or amount <= 0 then return end

    if type( state.gain ) == "function" then
        state.gain( amount, "rage" )
    elseif type( gain ) == "function" then
        gain( amount, "rage" )
    elseif rage then
        rage.current = min( rage.max or rage.current, rage.current + amount )
    end
end

local function get_warrior_swing_speed( is_offhand )
    local swings = state.swings
    local speed = swings and ( is_offhand and swings.offhand_speed or swings.mainhand_speed )

    if speed and speed > 0 then
        return speed
    end

    return is_offhand and 2.0 or 2.5
end

local function gain_warrior_auto_attack_rage( damage, is_offhand, is_critical )
    if not damage or damage <= 0 then return end

    local hit_factor = is_offhand and TBC_RAGE_OFFHAND_HIT_FACTOR or TBC_RAGE_MAINHAND_HIT_FACTOR

    if is_critical then
        hit_factor = hit_factor * 2
    end

    local multiplier = talent.endless_rage.rank > 0 and 1.25 or 1
    local rage = ( ( damage * TBC_RAGE_DEALT_FACTOR ) + ( hit_factor * get_warrior_swing_speed( is_offhand ) ) ) * multiplier

    gain_warrior_rage( rage )
end

local function gain_warrior_damage_taken_rage( damage )
    if not damage or damage <= 0 then return end
    gain_warrior_rage( damage * TBC_RAGE_TAKEN_FACTOR )
end

local function get_time_to_next_swing( hand )
    local speed = state.swings[ hand .. "_speed" ] or 0
    if speed <= 0 then return 0 end

    local now = state.now + state.offset
    local swing = state.swings[ hand ] or 0

    if swing == 0 then
        return speed * ( hand == "offhand" and 0.5 or 1 )
    end

    local remains = swing + ( ceil( ( now - swing ) / speed ) * speed ) - now
    if remains <= 0 then remains = speed end

    return remains
end

local function get_swing_forecast_last( hand )
    local speed = state.swings[ hand .. "_speed" ] or 0
    if speed <= 0 then return state.now + state.offset end

    local now = state.now + state.offset
    return now + get_time_to_next_swing( hand ) - speed
end

local function get_warrior_forecast_rage_per_swing( is_offhand )
    if not is_offhand and ( state.buff.heroic_strike_queue.up or state.buff.cleave_queue.up ) then
        return 0
    end

    local speed = get_warrior_swing_speed( is_offhand )
    local weapon_dps = is_offhand and state.weapon_offhand_dps or state.weapon_dps
    local estimated_damage = max( 0, weapon_dps * speed )
    local crit_chance = ( GetCritChance and GetCritChance() or 0 ) / 100

    local hit_factor = is_offhand and TBC_RAGE_OFFHAND_HIT_FACTOR or TBC_RAGE_MAINHAND_HIT_FACTOR
    local expected_hit_factor = hit_factor * ( 1 + crit_chance )

    local multiplier = talent.endless_rage.rank > 0 and 1.25 or 1

    return ( ( estimated_damage * TBC_RAGE_DEALT_FACTOR ) + ( expected_hit_factor * speed ) ) * multiplier
end

local function get_warrior_passive_incoming_rage_per_second()
    local multiplier = talent.endless_rage.rank > 0 and 1.25 or 1
    return get_passive_incoming_damage_per_second() * TBC_RAGE_TAKEN_FACTOR * multiplier
end


-- Effect implementation status (class-wide):
-- Profile: mvp
-- [x] TALENT_SPEC_SELECT (points 0/1 => primary/secondary)
-- [x] CREATE_ITEM (basic item creation counter)
-- [x] SCHOOL_DAMAGE (basic damage event tracking)
-- [x] SUMMON_PET (basic active pet tracking)
-- [x] SUMMON (basic summon event tracking)
-- [x] APPLY_AURA (basic aura tracking for caster/enemy/ally)

-- Talents
spec:RegisterTalents( {
    anger_management = { 137, 1, 12296 },
    anticipation = { 138, 5, 12297, 12750, 12751, 12752, 12753 },
    blood_craze = { 661, 3, 16487, 16489, 16492 },
    blood_frenzy = { 1664, 2, 29836, 29859 },
    bloodthirst = { 167, 1, 23881 },
    booming_voice = { 158, 5, 12321, 12835, 12836, 12837, 12838 },
    commanding_presence = { 154, 5, 12318, 12857, 12858, 12860, 12861 },
    concussion_blow = { 152, 1, 12809 },
    cruelty = { 157, 5, 12320, 12852, 12853, 12855, 12856 },
    death_wish = { 133, 1, 12292 },
    deep_wounds = { 121, 3, 12834, 12849, 12867 },
    defiance = { 144, 3, 12303, 12788, 12789 },
    deflection = { 130, 5, 16462, 16463, 16464, 16465, 16466 },
    devastate = { 1666, 1, 20243 },
    dual_wield_specialization = { 1581, 5, 23584, 23585, 23586, 23587, 23588 },
    endless_rage = { 1661, 1, 29623 },
    enrage = { 155, 5, 12317, 13045, 13046, 13047, 13048 },
    flurry = { 156, 5, 12319, 12971, 12972, 12973, 12974 },
    focused_rage = { 1660, 3, 29787, 29790, 29792 },
    impale = { 662, 2, 16493, 16494 },
    improved_berserker_rage = { 1541, 2, 20500, 20501 },
    improved_berserker_stance = { 1658, 5, 29759, 29760, 29761, 29762, 29763 },
    improved_bloodrage = { 142, 2, 12301, 12818 },
    improved_charge = { 126, 2, 12285, 12697 },
    improved_cleave = { 166, 3, 12329, 12950, 20496 },
    improved_defensive_stance = { 1652, 3, 29593, 29594, 29595 },
    improved_demoralizing_shout = { 161, 5, 12324, 12876, 12877, 12878, 12879 },
    improved_disarm = { 151, 3, 12313, 12804, 12807 },
    improved_disciplines = { 1662, 3, 29723, 29724, 29725 },
    improved_execute = { 1542, 2, 20502, 20503 },
    improved_hamstring = { 129, 3, 12289, 12668, 23695 },
    improved_heroic_strike = { 124, 3, 12282, 12663, 12664 },
    improved_intercept = { 134, 2, 29888, 29889 },
    improved_mortal_strike = { 1824, 5, 35446, 35448, 35449, 35450, 35451 },
    improved_overpower = { 131, 2, 12290, 12963 },
    improved_rend = { 127, 3, 12286, 12658, 12659 },
    improved_revenge = { 147, 3, 12797, 12799, 12800 },
    improved_shield_bash = { 149, 2, 12311, 12958 },
    improved_shield_block = { 145, 1, 12945 },
    improved_shield_wall = { 150, 2, 12312, 12803 },
    improved_slam = { 168, 2, 12862, 12330 },
    improved_sunder_armor = { 146, 3, 12308, 12810, 12811 },
    improved_taunt = { 143, 2, 12302, 12765 },
    improved_thunder_clap = { 128, 3, 12287, 12665, 12666 },
    improved_whirlwind = { 1655, 2, 29721, 29776 },
    iron_will = { 641, 5, 12300, 12959, 12960, 12961, 12962 },
    last_stand = { 153, 1, 12975 },
    mace_specialization = { 125, 5, 12284, 12701, 12702, 12703, 12704 },
    mortal_strike = { 135, 1, 12294 },
    one_handed_weapon_specialization = { 702, 5, 16538, 16539, 16540, 16541, 16542 },
    piercing_howl = { 160, 1, 12323 },
    poleaxe_specialization = { 132, 5, 12700, 12781, 12783, 12784, 12785 },
    precision = { 1657, 3, 29590, 29591, 29592 },
    rampage = { 1659, 1, 29801 },
    second_wind = { 1663, 2, 29834, 29838 },
    shield_mastery = { 1654, 3, 29598, 29599, 29600 },
    shield_slam = { 148, 1, 23922 },
    shield_specialization = { 1601, 5, 12298, 12724, 12725, 12726, 12727 },
    sweeping_strikes = { 165, 1, 12328 },
    sword_specialization = { 123, 5, 12281, 12812, 12813, 12814, 12815 },
    tactical_mastery = { 141, 3, 12295, 12676, 12677 },
    toughness = { 140, 5, 12299, 12761, 12762, 12763, 12764 },
    two_handed_weapon_specialization = { 136, 5, 12163, 12711, 12712, 12713, 12714 },
    unbridled_wrath = { 159, 5, 12322, 12999, 13000, 13001, 13002 },
    vitality = { 1653, 5, 29140, 29143, 29144, 29145, 29146 },
    weapon_mastery = { 1543, 2, 20504, 20505 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    battle_shout = {
        id = 2048,
        duration = 120,
        max_stack = 1,
        copy = { 2048, 5242, 6192, 6673, 11549, 11550, 11551, 25289 },
        -- Aura effects: MOD_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_CASTER_AREA_PARTY
    },

    battle_stance = {
        id = 2457,
        max_stack = 1,
        -- Aura effects: MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    berserker_rage = {
        id = 18499,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    berserker_stance = {
        id = 2458,
        max_stack = 1,
        -- Aura effects: MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blood_fury = {
        id = 20572,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_ATTACK_POWER, MOD_RANGED_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    bloodthirst = {
        id = 23880,
        duration = 8,
        max_stack = 1,
        copy = { 23880, 23881, 23885, 23886, 23887, 23888, 23889, 23890, 23891, 23892, 23893, 23894, 25251, 25252, 25253, 30335, 30339, 30340 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    challenging_shout = {
        id = 1161,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_TAUNT
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    commanding_shout = {
        id = 469,
        duration = 120,
        max_stack = 1,
        -- Aura effects: MOD_MAX_HEALTH
        -- Aura targets: TARGET_UNIT_CASTER_AREA_PARTY
    },

    cleave_queue = {
        duration = 5,
        max_stack = 1,
    },

    concussion_blow = {
        id = 12809,
        duration = 5,
        max_stack = 1,
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    death_wish = {
        id = 12292,
        duration = 30,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_DAMAGE_PERCENT_DONE, MOD_DAMAGE_PERCENT_TAKEN
        -- Aura targets: TARGET_UNIT_CASTER
    },

    defensive_stance = {
        id = 71,
        max_stack = 1,
        -- Aura effects: MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    demoralizing_shout = {
        id = 1160,
        duration = 30,
        max_stack = 1,
        copy = { 1160, 6190, 11554, 11555, 11556, 25202, 25203 },
        -- Aura effects: MOD_ATTACK_POWER
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    disarm = {
        id = 676,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MOD_DISARM
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    hamstring = {
        id = 1715,
        duration = 15,
        max_stack = 1,
        copy = { 1715, 7372, 7373, 25212 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    heroic_strike_queue = {
        duration = 5,
        max_stack = 1,
    },

    intervene = {
        id = 3411,
        duration = 10,
        max_stack = 1,
        -- Aura effects: INTERCEPT_MELEE_RANGED_ATTACKS
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    intimidating_shout = {
        id = 5246,
        duration = 8,
        max_stack = 1,
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    mocking_blow = {
        id = 694,
        duration = 6,
        max_stack = 1,
        copy = { 694, 7400, 7402, 20559, 20560, 25266 },
        -- Aura effects: MOD_TAUNT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    overpower_ready = {
        duration = 5,
        max_stack = 1,
    },

    mortal_strike = {
        id = 12294,
        duration = 10,
        max_stack = 1,
        copy = { 12294, 21551, 21552, 21553, 25248, 30330 },
        -- Aura effects: MOD_HEALING_PCT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    piercing_howl = {
        id = 12323,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    rampage = {
        id = 29801,
        duration = 30,
        max_stack = 5,
        copy = { 29801, 30029, 30030, 30031, 30032, 30033 },
        -- Aura effects: MOD_ATTACK_POWER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    recklessness = {
        id = 1719,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_DAMAGE_PERCENT_TAKEN, MOD_WEAPON_CRIT_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    rend = {
        id = 772,
        duration = 21,
        tick_time = 3,
        max_stack = 1,
        copy = { 772, 6546, 6547, 6548, 11572, 11573, 11574, 25208 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    retaliation = {
        id = 20230,
        duration = 15,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    second_wind = {
        id = 29834,
        duration = 10,
        tick_time = 2,
        max_stack = 1,
        copy = { 29834, 29838, 29841, 29842 },
        -- Aura effects: DUMMY, OBS_MOD_HEALTH, PERIODIC_ENERGIZE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shield_block = {
        id = 2565,
        duration = 5,
        max_stack = 1,
        -- Aura effects: MOD_BLOCK_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shield_wall = {
        id = 871,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN
        -- Aura targets: TARGET_UNIT_CASTER
    },

    spell_reflection = {
        id = 23920,
        duration = 5,
        max_stack = 1,
        -- Aura effects: REFLECT_SPELLS
        -- Aura targets: TARGET_UNIT_CASTER
    },

    sunder_armor = {
        id = 7386,
        duration = 30,
        max_stack = 5,
        copy = { 7386, 7405, 8380, 11596, 11597, 25225 },
        -- Aura effects: MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    sweeping_strikes = {
        id = 12328,
        duration = 10,
        max_stack = 1,
        copy = { 12328, 12723, 26654 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    taunt = {
        id = 355,
        duration = 3,
        max_stack = 1,
        -- Aura effects: MOD_TAUNT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    thunder_clap = {
        id = 6343,
        duration = 30,
        max_stack = 1,
        copy = { 6343, 8198, 8204, 8205, 11580, 11581, 25264 },
        -- Aura effects: MOD_MELEE_HASTE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

} )

-- Abilities (Hekili-style scaffold)
spec:RegisterAbilities( {

-- Activate Primary Spec - Switch to your Primary Talent Specialization.
    activate_primary_spec = {
        id = 63645,
        cast = 5,
        texture = 236544,
        range = 50000,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 63645 #0 -- effect: TALENT_SPEC_SELECT, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Activate Secondary Spec - Switch to your Secondary Talent Specialization.
    activate_secondary_spec = {
        id = 63644,
        cast = 5,
        texture = 236544,
        range = 50000,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 63644 #0 -- effect: TALENT_SPEC_SELECT, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Battle Shout - The warrior shouts, increasing the melee attack power of all party members within $a1 yards by 15-305. Lasts 120 sec.
    battle_shout = {
        id = 2048,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "physical",
        texture = 132333,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 2048, 5242, 6192, 6673, 11549, 11550, 11551, 25289 },

        -- Effects:
        -- [ ] Rank 2048 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 304, addl_points: 1, points_per_level: 1, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 5242 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 34, addl_points: 1, points_per_level: 0.5, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 6192 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 54, addl_points: 1, points_per_level: 0.5, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 6673 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 14, addl_points: 1, points_per_level: 0.5, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 11549 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 84, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 11550 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 129, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 11551 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 184, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 25289 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 231, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0

        radius = 20,

        handler = function ()
        end,
    },

-- Battle Stance - A balanced combat stance.
    battle_stance = {
        id = 2457,
        cast = 0,
        category_cooldown = 1,
        school = "physical",
        texture = 132349,
        cooldown_category_id = 47,
        cooldown_category = "Combat States",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2457 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            removeBuff( "berserker_stance" )
            removeBuff( "defensive_stance" )
            applyBuff( "battle_stance" )
        end,

        proc_chance = 100,
    },

-- Berserker Rage - The warrior enters a berserker rage, becoming immune to Fear, Sap and Incapacitate effects and generating extra rage when taking damage. Lasts 10 sec.
    berserker_rage = {
        id = 18499,
        cast = 0,
        duration = 10,
        cooldown = 30,
        gcd = "spell",
        school = "physical",
        texture = 136009,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18499 #0 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 18499 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 18499 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "berserker_rage" )
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Berserker Stance - An aggressive stance. Critical hit chance is increased by 3% and all damage taken is increased by 10%.
    berserker_stance = {
        id = 2458,
        cast = 0,
        category_cooldown = 1,
        school = "physical",
        texture = 132275,
        cooldown_category_id = 47,
        cooldown_category = "Combat States",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2458 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            removeBuff( "battle_stance" )
            removeBuff( "defensive_stance" )
            applyBuff( "berserker_stance" )
        end,

        proc_chance = 100,
    },

-- Berserking - Increases your attack speed by $26635m1% to $26635M1%. At full health the speed increase is $26635m1% with a greater effect up to $26635M1% if you are badly hurt when you activate Berserking. Lasts $26635d.
    berserking = {
        id = 26296,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 135727,
        spend = 5,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 26296 #0 -- effect: DUMMY, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Blood Fury - Increases attack power by 6, but reduces healing effects on you by 50%. Lasts 15 sec.
    blood_fury = {
        id = 20572,
        cast = 0,
        duration = 15,
        cooldown = 120,
        school = "physical",
        texture = 135726,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 20572 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 5, addl_points: 1, points_per_level: 4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20572 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 5, addl_points: 1, points_per_level: 4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blood_fury" )
        end,
    },

-- Bloodrage - Generates $/10;s1 rage at the cost of health, and then generates an additional $/10;29131o1 rage over $29131d.
    bloodrage = {
        id = 2687,
        cast = 0,
        cooldown = 60,
        school = "physical",
        texture = 132277,
        spend_pct = 16,
        spendType = "-2",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2687 #0 -- effect: ENERGIZE, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 2687 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29131
    },

-- Bloodthirst - Instantly attack the target causing ${$AP*$m1/100} damage. In addition, the next $23885n successful melee attacks will restore 10 health. This effect lasts $23885d. Damage is based on your attack power.
    bloodthirst = {
        id = 23880,
        cast = 0,
        duration = 8,
        category_cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 136012,
        cooldown_category_id = 971,
        cooldown_category = "Mortal Strike",
        range = 5,
        spend = 30,
        spendType = "Rage",
        max_stack = 1,
        copy = { 23880, 23881, 23885, 23886, 23887, 23888, 23889, 23890, 23891, 23892, 23893, 23894, 25251, 25252, 25253, 30335, 30339, 30340 },

        -- Effects:
        -- [ ] Rank 23880 #0 -- effect: HEAL, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23881 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23885 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 23880
        -- [x] Rank 23886 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 23889
        -- [x] Rank 23887 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 23890
        -- [x] Rank 23888 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 23891
        -- [ ] Rank 23889 #0 -- effect: HEAL, aura: NONE, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23890 #0 -- effect: HEAL, aura: NONE, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23891 #0 -- effect: HEAL, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23892 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23893 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23894 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25251 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25252 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 25253
        -- [ ] Rank 25253 #0 -- effect: HEAL, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30335 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30339 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30340
        -- [ ] Rank 30340 #0 -- effect: HEAL, aura: NONE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "bloodthirst" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "bloodthirst" ) end
        end,

        proc_chance = 100,
        proc_charges = 5,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Challenging Shout - Forces all enemies within $a1 yards to focus attacks on you for 6 sec.
    challenging_shout = {
        id = 1161,
        cast = 0,
        duration = 6,
        cooldown = 600,
        gcd = "spell",
        school = "physical",
        texture = 132091,
        spend = 5,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1161 #0 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Charge - Charge an enemy, generate $/10;s2 rage, and stun it for $7922d. Cannot be used in combat.
    charge = {
        id = 100,
        cast = 0,
        category_cooldown = 15,
        school = "physical",
        texture = 132337,
        cooldown_category_id = 44,
        cooldown_category = "Speed",
        min_range = 8,
        range = 25,
        spendType = "Rage",
        max_stack = 1,
        copy = { 100, 6178, 11578 },

        -- Effects:
        -- [ ] Rank 100 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 100 #1 -- effect: DUMMY, aura: NONE, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 36, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 100 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 7922
        -- [ ] Rank 6178 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6178 #1 -- effect: DUMMY, aura: NONE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 36, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 6178 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 7922
        -- [ ] Rank 11578 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11578 #1 -- effect: DUMMY, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 36, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11578 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 7922
        startsCombat = true,
    },

-- Cleave - A sweeping attack that does your weapon damage plus 5-70 to the target and his nearest ally.
    cleave = {
        id = 845,
        cast = 0,
        school = "physical",
        texture = 132338,
        range = 5,
        spend = 20,
        spendType = "Rage",
        max_stack = 1,
        copy = { 845, 7369, 11608, 11609, 20569, 25231 },

        -- Effects:
        -- [ ] Rank 845 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 7369 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11608 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11609 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20569 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25231 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            removeBuff( "heroic_strike_queue" )
            applyBuff( "cleave_queue", swings and swings.time_to_next_mainhand or nil )
        end,

        proc_chance = 100,
    },

-- Commanding Shout - Increases maximum health of all party members within $a1 yards by 1080. Lasts 120 sec.
    commanding_shout = {
        id = 469,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "physical",
        texture = 132351,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 469 #0 -- effect: APPLY_AURA, aura: MOD_MAX_HEALTH, points: 1079, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0

        radius = 20,

        handler = function ()
        end,
    },

-- Concussion Blow - Stuns the opponent for 5 sec.
    concussion_blow = {
        id = 12809,
        cast = 0,
        duration = 5,
        cooldown = 45,
        school = "physical",
        texture = 132325,
        range = 5,
        spend = 15,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 12809 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "concussion_blow" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Death Wish - When activated, increases your physical damage by 20% and makes you immune to Fear effects, but increases all damage taken by 5%. Lasts 30 sec.
    death_wish = {
        id = 12292,
        cast = 0,
        duration = 30,
        cooldown = 180,
        gcd = "spell",
        school = "physical",
        texture = 136146,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 12292 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12292 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12292 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "death_wish" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Defensive Stance - A defensive combat stance. Decreases damage taken by 10% and damage caused by 10%. Increases threat generated.
    defensive_stance = {
        id = 71,
        cast = 0,
        category_cooldown = 1,
        school = "physical",
        texture = 132341,
        cooldown_category_id = 47,
        cooldown_category = "Combat States",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 71 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            removeBuff( "battle_stance" )
            removeBuff( "berserker_stance" )
            applyBuff( "defensive_stance" )
        end,

        proc_chance = 100,
    },

-- Demoralizing Shout - Reduces the melee attack power of all enemies within $a1 yards by 35-300 for 30 sec.
    demoralizing_shout = {
        id = 1160,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "physical",
        texture = 132366,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 1160, 6190, 11554, 11555, 11556, 25202, 25203 },

        -- Effects:
        -- [ ] Rank 1160 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -36, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 6190 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -56, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11554 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -71, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11555 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -106, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11556 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -141, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 25202 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -221, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 25203 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -301, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Devastate - Sunder the target's armor causing the Sunder Armor effect. In addition, causes 50% of weapon damage plus 15/25/35 for each application of Sunder Armor on the target. The Sunder Armor effect can stack up to $u times.
    devastate = {
        id = 20243,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 135291,
        range = 5,
        spend = 15,
        spendType = "Rage",
        max_stack = 5,
        copy = { 20243, 30016, 30022 },

        -- Effects:
        -- [ ] Rank 20243 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20243 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30016 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30016 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30022 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30022 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Disarm - Disarm the enemy's weapon for 10 sec.
    disarm = {
        id = 676,
        cast = 0,
        duration = 10,
        category_cooldown = 60,
        gcd = "spell",
        school = "physical",
        texture = 132343,
        cooldown_category_id = 109,
        cooldown_category = "Melee (Disarm)",
        range = 5,
        spend = 20,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 676 #0 -- effect: APPLY_AURA, aura: MOD_DISARM, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "disarm" )
        end,

        proc_chance = 100,
    },

-- Execute - Attempt to finish off a wounded foe, causing 1-925 damage and converting each extra point of rage into $*10;F1 additional damage. Only usable on enemies that have less than 20% health.
    execute = {
        id = 5308,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 135358,
        range = 100,
        spend = function () return max( 0, 15 + -3 * ( talent.improved_execute.rank or 0 ) ) end,
        -- Talent spend flat scaling: improved_execute (-3 rage per rank)
        spendType = "Rage",
        max_stack = 1,
        copy = { 5308, 20647, 20658, 20660, 20661, 20662, 25234, 25236 },

        -- Effects:
        -- [ ] Rank 5308 #0 -- effect: DUMMY, aura: NONE, points: 124, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20647 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20658 #0 -- effect: DUMMY, aura: NONE, points: 199, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20660 #0 -- effect: DUMMY, aura: NONE, points: 324, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20661 #0 -- effect: DUMMY, aura: NONE, points: 449, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20662 #0 -- effect: DUMMY, aura: NONE, points: 599, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25234 #0 -- effect: DUMMY, aura: NONE, points: 749, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25236 #0 -- effect: DUMMY, aura: NONE, points: 924, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        usable = function () return target.health.pct <= 20 end,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "execute" ) end
        end,

        -- Aura restrictions: target_state=2
    },

-- Furious Gizmatic Goggles
    furious_gizmatic_goggles = {
        id = 40274,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 40274 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Hamstring - Maims the enemy, causing 5/18/45/63 damage and slowing the enemy's movement by 40/45/50% for 15 sec.
    hamstring = {
        id = 1715,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "physical",
        texture = 132316,
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 1715, 7372, 7373, 25212 },

        -- Effects:
        -- [x] Rank 1715 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1715 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 7372 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7372 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -46, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 7373 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7373 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 25212 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 62, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25212 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "hamstring" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "hamstring" ) end
        end,
    },

-- Hard Khorium Goggles
    hard_khorium_goggles = {
        id = 46115,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46115 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Heroic Strike - A strong attack that increases melee damage by 11-208 and causes a high amount of threat.
    heroic_strike = {
        id = 78,
        cast = 0,
        school = "physical",
        texture = 132282,
        range = 5,
        spend = function () return max( 0, 15 + -1 * ( talent.improved_heroic_strike.rank or 0 ) ) end,
        -- Talent spend flat scaling: improved_heroic_strike (-1 rage per rank)
        spendType = "Rage",
        max_stack = 1,
        copy = { 78, 284, 285, 1608, 11564, 11565, 11566, 11567, 25286, 29707, 30324 },

        -- Effects:
        -- [ ] Rank 78 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 284 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 285 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1608 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 43, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11564 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 57, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11565 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11566 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 110, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11567 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 137, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25286 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 156, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 29707 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 175, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30324 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 207, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            removeBuff( "cleave_queue" )
            applyBuff( "heroic_strike_queue", swings and swings.time_to_next_mainhand or nil )
        end,

        proc_chance = 100,
    },

-- Intercept - Charge an enemy, causing 25 damage and stunning it for $20253d.
    intercept = {
        id = 20252,
        cast = 0,
        cooldown = function () return max( 0, 30 + -5 * ( talent.improved_intercept.rank or 0 ) ) end,
        category_cooldown = 30,
        school = "physical",
        texture = 132307,
        cooldown_category_id = 1158,
        cooldown_category = "Intercept",
        min_range = 8,
        range = 25,
        spend = 10,
        -- Talent cooldown scaling (category source): improved_intercept (-5s per rank)
        spendType = "Rage",
        max_stack = 1,
        copy = { 20252, 20616, 20617, 25272, 25275 },

        -- Effects:
        -- [ ] Rank 20252 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20252 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 20253
        -- [ ] Rank 20616 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20616 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 20614
        -- [ ] Rank 20617 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20617 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 20615
        -- [ ] Rank 25272 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25272 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 25273
        -- [ ] Rank 25275 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25275 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 25274
        startsCombat = true,
    },

-- Intervene - Run at high speed towards a party member, intercepting the next melee or ranged attack made against them.
    intervene = {
        id = 3411,
        cast = 0,
        duration = 10,
        cooldown = 30,
        school = "physical",
        texture = 132365,
        min_range = 8,
        range = 25,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3411 #0 -- effect: CHARGE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 3411 #1 -- effect: APPLY_AURA, aura: INTERCEPT_MELEE_RANGED_ATTACKS, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 13, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability
    },

-- Intimidating Shout - The warrior shouts, causing enemies within $a2 yards to cower in fear. Up to $i total nearby enemies will flee in fear. Lasts 8 sec.
    intimidating_shout = {
        id = 5246,
        cast = 0,
        duration = 8,
        cooldown = 180,
        gcd = "spell",
        school = "physical",
        texture = 132154,
        range = 10,
        spend = 25,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 5246 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 20511
        -- [ ] Rank 5246 #1 -- effect: APPLY_AURA, aura: MOD_FEAR, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 5246 #2 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Last Stand - When activated, this ability temporarily grants you 30% of your maximum health for $12976d. After the effect expires, the health is lost.
    last_stand = {
        id = 12975,
        cast = 0,
        cooldown = 480,
        school = "physical",
        texture = 135871,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 12975 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
    },

-- Mayhem Projection Goggles
    mayhem_projection_goggles = {
        id = 46114,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46114 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Mocking Blow - A mocking attack that causes 22-114 damage, a moderate amount of threat and forces the target to focus attacks on you for 6 sec.
    mocking_blow = {
        id = 694,
        cast = 0,
        duration = 6,
        category_cooldown = 120,
        gcd = "spell",
        school = "physical",
        texture = 132350,
        cooldown_category_id = 40,
        cooldown_category = "Melee (Generic)",
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 694, 7400, 7402, 20559, 20560, 25266 },

        -- Effects:
        -- [x] Rank 694 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 694 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7400 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7400 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7402 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 45, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7402 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20559 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 70, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20559 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20560 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 92, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20560 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25266 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 113, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25266 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "mocking_blow" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "mocking_blow" ) end
        end,

        proc_chance = 100,
    },

-- Mortal Strike - A vicious strike that deals weapon damage plus 85-210 and wounds the target, reducing the effectiveness of any healing by 50% for 10 sec.
    mortal_strike = {
        id = 12294,
        cast = 0,
        duration = 10,
        category_cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 132355,
        cooldown_category_id = 971,
        cooldown_category = "Mortal Strike",
        range = 5,
        spend = 30,
        spendType = "Rage",
        max_stack = 1,
        copy = { 12294, 21551, 21552, 21553, 25248, 30330 },

        -- Effects:
        -- [x] Rank 12294 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 12294 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 21551 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 21551 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 21552 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 21552 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 134, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 21553 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 21553 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25248 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25248 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30330 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30330 #1 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 209, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "mortal_strike" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Overpower - Instantly overpower the enemy, causing weapon damage plus 5/15/25/35. Only useable after the target dodges. The Overpower cannot be blocked, dodged or parried.
    overpower = {
        id = 7384,
        cast = 0,
        category_cooldown = 5,
        gcd = "spell",
        school = "physical",
        texture = 132223,
        cooldown_category_id = 65,
        cooldown_category = "Melee (Special)",
        range = 5,
        spend = 5,
        spendType = "Rage",
        max_stack = 1,
        copy = { 7384, 7887, 11584, 11585 },

        -- Effects:
        -- [ ] Rank 7384 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 7887 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11584 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11585 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        usable = function () return buff.overpower_ready.up end,

        handler = function ()
            removeBuff( "overpower_ready" )
        end,
    },

-- Piercing Howl - Causes all enemies within $a1 yards to be Dazed, reducing movement speed by 50% for 6 sec.
    piercing_howl = {
        id = 12323,
        cast = 0,
        duration = 6,
        gcd = "spell",
        school = "physical",
        texture = 136147,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 12323 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Pummel - Pummel the target for 20/50 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 4 sec.
    pummel = {
        id = 6552,
        cast = 0,
        duration = 4,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132938,
        cooldown_category_id = 88,
        cooldown_category = "Silence",
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 6552, 6554 },

        -- Effects:
        -- [ ] Rank 6552 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 6552 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6554 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 6554 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "pummel" ) end
        end,
    },

-- Rampage - Warrior goes on a rampage, increasing attack power by 30 and causing most successful melee attacks to increase attack power by an additional 30. This effect will stack up to $30029u times. Lasts 30 sec. This ability can only be used after scoring a critical hit.
    rampage = {
        id = 29801,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "physical",
        texture = 132352,
        spend = 20,
        spendType = "Rage",
        max_stack = 5,
        copy = { 29801, 30029, 30030, 30031, 30032, 30033 },

        -- Effects:
        -- [x] Rank 29801 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [ ] Rank 29801 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30029
        -- [x] Rank 30029 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30030 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 15, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [ ] Rank 30030 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30031
        -- [x] Rank 30031 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30032 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30033 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [ ] Rank 30033 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30032

        handler = function ()
            if buff.rampage.up then
                applyBuff( "rampage", nil, min( buff.rampage.max_stack, buff.rampage.stack + 1 ) )
            else
                applyBuff( "rampage" )
            end
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Aura restrictions: caster_state=11

        -- Related talents:
        -- talent_0 [0]
    },

-- Recklessness - The warrior will cause critical hits with most attacks and will be immune to Fear effects for the next 15 sec, but all damage taken is increased by 20%.
    recklessness = {
        id = 1719,
        cast = 0,
        duration = 15,
        category_cooldown = 1800,
        gcd = "spell",
        school = "physical",
        texture = 132109,
        cooldown_category_id = 132,
        cooldown_category = "Discipline",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1719 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1719 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1719 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "recklessness" )
        end,
    },

-- Rend - Wounds the target causing them to bleed for 15-182 damage plus an additional ${0.00743*3*(($MWB+$mwb)/2+$AP/14*$MWS)} (based on weapon damage) over 9/12/15/18/21 sec.
    rend = {
        id = 772,
        cast = 0,
        duration = 21,
        gcd = "spell",
        school = "physical",
        texture = 132155,
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 772, 6546, 6547, 6548, 11572, 11573, 11574, 25208 },

        -- Effects:
        -- [x] Rank 772 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6546 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6547 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6548 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11572 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11573 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11574 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25208 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 25, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "rend" )
        end,

        proc_chance = 100,
    },

-- Retaliation - Instantly counterattack any enemy that strikes you in melee for 15 sec. Melee attacks made from behind cannot be counterattacked. A maximum of $n attacks will cause retaliation.
    retaliation = {
        id = 20230,
        cast = 0,
        duration = 15,
        category_cooldown = 1800,
        gcd = "spell",
        school = "physical",
        texture = 132336,
        cooldown_category_id = 132,
        cooldown_category = "Discipline",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 20230 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "retaliation" )
        end,

        proc_chance = 100,
        proc_charges = 30,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Revenge - Instantly counterattack an enemy for 50-414 damage and a high amount of threat. Revenge must follow a block, dodge or parry.
    revenge = {
        id = 6572,
        cast = 0,
        category_cooldown = 5,
        gcd = "spell",
        school = "physical",
        texture = 132353,
        cooldown_category_id = 65,
        cooldown_category = "Melee (Special)",
        range = 5,
        spend = 5,
        spendType = "Rage",
        max_stack = 1,
        copy = { 6572, 6574, 7379, 11600, 11601, 25269, 25288, 30357 },

        -- Effects:
        -- [x] Rank 6572 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 49, addl_points: 11, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6574 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 76, addl_points: 17, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7379 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 106, addl_points: 23, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11600 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 179, addl_points: 41, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11601 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 269, addl_points: 61, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25269 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 359, addl_points: 81, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25288 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 341, addl_points: 77, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30357 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 413, addl_points: 93, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "revenge" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=1
    },

-- Second Wind - Whenever you are struck by a Stun or Immobilize effect you will generate $/10;29841o1 rage and $29841o2% of your total health over $29841d.
    second_wind = {
        id = 29834,
        cast = 0,
        duration = 10,
        texture = 132175,
        max_stack = 1,
        copy = { 29834, 29838, 29841, 29842 },

        -- Effects:
        -- [x] Rank 29834 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29838 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29841 #0 -- effect: APPLY_AURA, aura: PERIODIC_ENERGIZE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29841 #1 -- effect: APPLY_AURA, aura: OBS_MOD_HEALTH, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29842 #0 -- effect: APPLY_AURA, aura: PERIODIC_ENERGIZE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29842 #1 -- effect: APPLY_AURA, aura: OBS_MOD_HEALTH, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "second_wind" )
        end,

        proc_chance = 100,
        proc_type_mask = { 174760, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Helpful Ability; Take Harmful Ability; Take Helpful Spell; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Shield Bash - Bashes the target with your shield for 6/18/45/63 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 6 sec.
    shield_bash = {
        id = 72,
        cast = 0,
        duration = 6,
        category_cooldown = 12,
        gcd = "spell",
        school = "physical",
        texture = 132357,
        cooldown_category_id = 88,
        cooldown_category = "Silence",
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 72, 1671, 1672, 29704 },

        -- Effects:
        -- [ ] Rank 72 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 72 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1671 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1671 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1672 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1672 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 29704 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 29704 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 62, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 29704 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29703
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shield_bash" ) end
        end,

        proc_chance = 100,
    },

-- Shield Block - Increases chance to block by 75% for 5 sec, but will only block $n $lattack:attacks;.
    shield_block = {
        id = 2565,
        cast = 0,
        duration = 5,
        cooldown = 5,
        school = "physical",
        texture = 132110,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2565 #0 -- effect: APPLY_AURA, aura: MOD_BLOCK_PERCENT, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shield_block" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability
    },

-- Shield Slam - Slam the target with your shield, causing 225-420 damage, modified by your shield block value, and dispels 1 magic effect on the target. Also causes a high amount of threat.
    shield_slam = {
        id = 23922,
        cast = 0,
        category_cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 134951,
        cooldown_category_id = 971,
        cooldown_category = "Mortal Strike",
        range = 5,
        spend = 20,
        spendType = "Rage",
        max_stack = 1,
        copy = { 23922, 23923, 23924, 23925, 25258, 30356 },

        -- Effects:
        -- [ ] Rank 23922 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23922 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 224, addl_points: 11, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 23923 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23923 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 263, addl_points: 13, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 23924 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23924 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 302, addl_points: 15, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 23925 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 23925 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 341, addl_points: 17, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25258 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25258 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 380, addl_points: 19, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30356 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30356 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 419, addl_points: 21, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shield_slam" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Shield Wall - Reduces the damage taken from melee attacks, ranged attacks and spells by 75% for 10 sec.
    shield_wall = {
        id = 871,
        cast = 0,
        duration = 10,
        category_cooldown = 1800,
        gcd = "spell",
        school = "physical",
        texture = 132362,
        cooldown_category_id = 132,
        cooldown_category = "Discipline",
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 871 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -76, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shield_wall" )
        end,
    },

-- Shoot
    shoot = {
        id = 3018,
        cast = 1,
        texture = 132222,
        cooldown_category_id = 76,
        cooldown_category = "Shoot/Throw",
        range = 30,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3018 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Slam - Slams the opponent, causing weapon damage plus 32-140.
    slam = {
        id = 1464,
        cast = function () return max( 0, 1.5 + -0.5 * ( talent.improved_slam.rank or 0 ) ) end,
        gcd = "spell",
        school = "physical",
        texture = 132340,
        range = 5,
        spend = 15,
        -- Talent cast scaling: improved_slam (-0.5s per rank)
        spendType = "Rage",
        max_stack = 1,
        copy = { 1464, 8820, 11604, 11605, 25241, 25242 },

        -- Effects:
        -- [ ] Rank 1464 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8820 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11604 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 67, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11605 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 86, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25241 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25242 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 139, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Spell Reflection - Raise your shield, reflecting the next spell cast on you. Lasts 5 sec.
    spell_reflection = {
        id = 23920,
        cast = 0,
        duration = 5,
        cooldown = 10,
        school = "physical",
        texture = 132361,
        spend = 25,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 23920 #0 -- effect: APPLY_AURA, aura: REFLECT_SPELLS, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "spell_reflection" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139936, 0 },
        -- Proc type flags: mask0: Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Sunder Armor - Sunders the target's armor, reducing it by 90-520 per Sunder Armor and causes a high amount of threat. Can be applied up to 5 times. Lasts 30 sec.
    sunder_armor = {
        id = 7386,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "physical",
        texture = 132363,
        range = 5,
        spend = function () return max( 0, 15 + -1 * ( talent.improved_sunder_armor.rank or 0 ) ) end,
        -- Talent spend flat scaling: improved_sunder_armor (-1 rage per rank)
        spendType = "Rage",
        max_stack = 5,
        copy = { 7386, 7405, 8380, 11596, 11597, 25225 },

        -- Effects:
        -- [x] Rank 7386 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -91, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7405 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -181, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8380 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -271, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11596 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -361, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11597 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -451, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25225 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -521, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if debuff.sunder_armor.up then
                applyDebuff( "target", "sunder_armor", nil, min( debuff.sunder_armor.max_stack, debuff.sunder_armor.stack + 1 ) )
            else
                applyDebuff( "target", "sunder_armor", nil, 1 )
            end
        end,

        proc_chance = 100,
    },

-- Sweeping Strikes - Your next $n melee attacks strike an additional nearby opponent.
    sweeping_strikes = {
        id = 12328,
        cast = 0,
        duration = 10,
        cooldown = 30,
        school = "physical",
        texture = 132306,
        range = 100,
        spend = 30,
        spendType = "Rage",
        max_stack = 1,
        copy = { 12328, 12723, 26654 },

        -- Effects:
        -- [x] Rank 12328 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12723 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26654 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "sweeping_strikes" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "sweeping_strikes" ) end
        end,

        proc_chance = 100,
        proc_charges = 10,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Tankatronic Goggles
    tankatronic_goggles = {
        id = 41312,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41312 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Taunt - Taunts the target to attack you, but has no effect if the target is already attacking you.
    taunt = {
        id = 355,
        cast = 0,
        duration = 3,
        cooldown = function () return max( 0, 10 + -1 * ( talent.improved_taunt.rank or 0 ) ) end,
        category_cooldown = 10,
        school = "physical",
        texture = 136080,
        cooldown_category_id = 82,
        cooldown_category = "Taunt/Detaunt",
        range = 5,
        -- Talent cooldown scaling (category source): improved_taunt (-1s per rank)
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 355 #0 -- effect: ATTACK_ME, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 355 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "taunt" )
        end,

        proc_chance = 100,
    },

-- Throw - Hurl a thrown weapon at the target.
    throw = {
        id = 2764,
        cast = 0,
        texture = 132324,
        cooldown_category_id = 76,
        cooldown_category = "Shoot/Throw",
        range = 30,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2764 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Thunder Clap - Blasts nearby enemies increasing the time between their attacks by 10% for 10-30 sec and doing 10-123 damage to them. This ability causes additonal threat and will affect up to $i targets.
    thunder_clap = {
        id = 6343,
        cast = 0,
        duration = 30,
        category_cooldown = 4,
        gcd = "spell",
        school = "physical",
        texture = 136105,
        cooldown_category_id = 49,
        cooldown_category = "Direct Damage (AE) - Ability",
        spend = function () return max( 0, 20 + -1.5 * ( talent.improved_thunder_clap.rank or 0 ) ) end,
        -- Talent spend flat scaling: improved_thunder_clap (-1.5 rage per rank)
        spendType = "Rage",
        max_stack = 1,
        copy = { 6343, 8198, 8204, 8205, 11580, 11581, 25264 },

        -- Effects:
        -- [x] Rank 6343 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 6343 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8198 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 22, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8198 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8204 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8204 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8205 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8205 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 11580 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 81, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11580 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 11581 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 102, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11581 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 25264 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 122, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 25264 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "thunder_clap" ) end
        end,
    },

-- Victory Rush - Instantly attack the target causing ${$AP*$m1/100} damage. Can only be used within $32216d after you kill an enemy that yields experience or honor. Damage is based on your attack power.
    victory_rush = {
        id = 34428,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132342,
        range = 5,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 34428 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "victory_rush" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=10
    },

-- Whirlwind - In a whirlwind of steel you attack up to $i enemies within $a1 yards, causing weapon damage from both melee weapons to each enemy.
    whirlwind = {
        id = 1680,
        cast = 0,
        cooldown = function () return max( 0, 10 + -1 * ( talent.improved_whirlwind.rank or 0 ) ) end,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132369,
        cooldown_category_id = 891,
        cooldown_category = "Whirlwind",
        spend = 25,
        -- Talent cooldown scaling (category source): improved_whirlwind (-1s per rank)
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1680 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 1680 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_SRC_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44949
        startsCombat = true,

        radius = 8,
    },

} )

spec:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED", function()
    local _, subtype, _, sourceGUID, _, _, _, destGUID, _, _, _, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10 = CombatLogGetCurrentEventInfo()

    if sourceGUID == state.GUID and subtype == "SWING_DAMAGE" then
        gain_warrior_auto_attack_rage( a1, a10, a7 )
        return
    end

    if destGUID ~= state.GUID or sourceGUID == state.GUID then return end

    local damage

    if sourceGUID ~= state.GUID then
        if subtype == "SWING_DAMAGE" then
            damage = a1
        elseif subtype == "SPELL_DAMAGE" or subtype == "RANGE_DAMAGE" or subtype == "SPELL_PERIODIC_DAMAGE" then
            damage = a4
        elseif subtype == "ENVIRONMENTAL_DAMAGE" then
            damage = a2
        end
    end

    if damage and damage > 0 then
        gain_warrior_damage_taken_rage( damage )
        add_passive_rage_damage_event( damage )
    end
end )

spec:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED", function()
    if not class.auras.overpower_ready then return end

    local _, subtype, _, sourceGUID, _, _, _, _, _, _, _, missType = CombatLogGetCurrentEventInfo()

    if sourceGUID ~= state.GUID then return end
    if missType ~= "DODGE" then return end
    if subtype ~= "SWING_MISSED" and subtype ~= "SPELL_MISSED" and subtype ~= "RANGE_MISSED" then return end

    applyBuff( "overpower_ready" )
end )

-- Resources
spec:RegisterResource( "rage", nil, {
    warrior_mainhand_swing = {
        resource = "rage",
        swing = "mainhand",
        last = function () return get_swing_forecast_last( "mainhand" ) end,
        interval = function () return state.swings.mainhand_speed or 0 end,
        value = function () return get_warrior_forecast_rage_per_swing() end,
    },

    warrior_offhand_swing = {
        resource = "rage",
        swing = "offhand",
        last = function () return get_swing_forecast_last( "offhand" ) end,
        interval = function () return state.swings.offhand_speed or 0 end,
        value = function () return get_warrior_forecast_rage_per_swing( true ) end,
    },

    warrior_incoming_damage = {
        resource = "rage",
        setting = "passive_rage_prediction",
        last = function () return state.now + state.offset - 1 end,
        interval = 1,
        value = function () return get_warrior_passive_incoming_rage_per_second() end,
    },
} )

if spec.RegisterRanges then
    spec:RegisterRanges( "bloodthirst", "hamstring", "mocking_blow", "pummel", "rend", "revenge" )
end

spec:RegisterOptions( {
    enabled = true,

    aoe = 2,
    cycle = false,

    nameplates = true,
    nameplateRange = 10,
    rangeFilter = false,

    damage = true,
    damageDots = true,
    damageExpiration = 6,

    potion = "tempered_potion",

    package = "Fury",
} )

--[[
spec:RegisterSetting( "scaffold_strict_range", false, {
    name = "Scaffold: Strict Range Checks",
    desc = "If checked, this generated profile can use stricter range checks where supported.",
    type = "toggle",
    width = "full",
} )
]]--

spec:RegisterSetting( "passive_rage_prediction", false, {
    type = "toggle",
    name = "|T132355:0|t Passive Rage Prediction",
    desc = "When enabled, rage forecasting includes average incoming damage over the last 10 seconds.",
    width = "full",
} )

spec:RegisterSetting( "warrior_arms_settings_sep", false, {
    type = "description",
    name = "|T132292:0|t Arms",
    width = "full",
} )

spec:RegisterSetting( "warrior_arms_hs_rage_threshold", 70, {
    type = "range",
    name = "|T132282:0|t Arms HS Rage Threshold",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_arms_hamstring_rage_threshold", 75, {
    type = "range",
    name = "|T132316:0|t Arms Hamstring Rage Threshold",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_arms_overpower_rage_threshold", 20, {
    type = "range",
    name = "|T132223:0|t Arms Overpower Rage Ceiling",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_arms_slam_min_rage", 15, {
    type = "range",
    name = "|T132340:0|t Arms Slam Minimum Rage",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_arms_slam_latency", 0.1, {
    type = "range",
    name = "|T132340:0|t Arms Slam Latency",
    width = "full",
    min = 0,
    max = 1,
    step = 0.01,
} )

spec:RegisterSetting( "warrior_arms_slam_gcd_delay", 0.4, {
    type = "range",
    name = "|T132340:0|t Arms Slam GCD Delay",
    width = "full",
    min = 0,
    max = 1.5,
    step = 0.01,
} )

spec:RegisterSetting( "warrior_arms_slam_msww_delay", 2, {
    type = "range",
    name = "|T132340:0|t Arms Slam MS/WW Delay",
    width = "full",
    min = 0,
    max = 6,
    step = 0.1,
} )

spec:RegisterSetting( "warrior_arms_use_slam_execute", true, {
    type = "toggle",
    name = "|T132340:0|t Arms Use Slam in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_arms_use_ww_execute", true, {
    type = "toggle",
    name = "|T132369:0|t Arms Use Whirlwind in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_arms_use_ms_execute", true, {
    type = "toggle",
    name = "|T132355:0|t Arms Use Mortal Strike in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_arms_use_hs_execute", true, {
    type = "toggle",
    name = "|T132282:0|t Arms Use Heroic Strike in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_fury_settings_sep", false, {
    type = "description",
    name = "|T132347:0|t Fury",
    width = "full",
} )

spec:RegisterSetting( "warrior_fury_hs_rage_threshold", 70, {
    type = "range",
    name = "|T132282:0|t Fury HS Rage Threshold",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_fury_hamstring_rage_threshold", 75, {
    type = "range",
    name = "|T132316:0|t Fury Hamstring Rage Threshold",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_fury_overpower_rage_threshold", 20, {
    type = "range",
    name = "|T132223:0|t Fury Overpower Rage Ceiling",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_fury_rampage_cd_threshold", 5, {
    type = "range",
    name = "|T132352:0|t Fury Rampage Refresh Window",
    width = "full",
    min = 0,
    max = 30,
    step = 0.1,
} )

spec:RegisterSetting( "warrior_fury_use_hs_execute", true, {
    type = "toggle",
    name = "|T132282:0|t Fury Use Heroic Strike in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_fury_use_ww_execute", true, {
    type = "toggle",
    name = "|T132369:0|t Fury Use Whirlwind in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_fury_use_bt_execute", true, {
    type = "toggle",
    name = "|T132090:0|t Fury Use Bloodthirst in Execute",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_settings_sep", false, {
    type = "description",
    name = "|T134952:0|t Protection",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_hs_rage_threshold", 30, {
    type = "range",
    name = "|T132282:0|t Protection HS Rage Threshold",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "warrior_prot_thunder_mode_maintain", true, {
    type = "toggle",
    name = "|T136105:0|t Protection Maintain Thunder Clap",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_thunder_mode_on_cd", false, {
    type = "toggle",
    name = "|T136105:0|t Protection Thunder Clap on Cooldown",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_demo_mode_maintain", true, {
    type = "toggle",
    name = "|T132121:0|t Protection Maintain Demoralizing Shout",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_demo_mode_filler", false, {
    type = "toggle",
    name = "|T132121:0|t Protection Demoralizing as Filler",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_shield_block_on_cd", false, {
    type = "toggle",
    name = "|T132110:0|t Protection Shield Block on Cooldown",
    width = "full",
} )

spec:RegisterSetting( "warrior_prot_shield_block_revenge", true, {
    type = "toggle",
    name = "|T132110:0|t Protection Shield Block for Revenge",
    width = "full",
} )

spec:RegisterPack( "Arms", 20260310, [[Hekili:DJvZoUTnq43gJe0avj70TTa2lq7PM9WErfO3OeT4ylctjkqsvvxyON9qsNvKY20Ykb5q7Hvwl5mFZWpo)bHsq)jkLGva61LXlFkEvsCuYtXFmEfkvDSbqPn4Id496xQXv6N)MOsAw8iJJjgLL8wrHEdu62wkt9PA02BJ4sTSnqb61euAjLqGZscYIZO2N)xyHGYf95nMFOQJ957m)7FahOmQ2Qc(oktBlCHIYRLrncOGxTfR(Hn)O(PIbzsfUUa6F5EIuYBvFGUBZ22D7I8xmIW7QdOlJZjcnr0)YGa6LBLqgvbvYpyEJVBx2(cYMeFr0GCGbszT(pJvvyXEqfPOvqMINrOWZlJ9vyMUPwdcuXfyg9FP17D6raRMxVzKaQW0A56L(GOkBRjGiRGHB8u3F5BROgEfMPzEb9a4Dclbmtvg1uOwVzz8cjOuAxqg1X7K0QSUZ32zy9DFMH90)a)du0QaF07kPcwhTM8nGCx3TqwYWvFdGAu)nyxyImIkAfcOw98M7QRvVkADMrNffCoZCDgnIfFJOFiOK6Jhby4JoWgiTVoG8zPVCcdsuJICbHeeh0rlMZwyU9Ce9iHVkME6OQlsBUFGYfcZ)Bq0W7ariHp7JdILjam5yuBZOB613Lu9uwRtMQua60pgzMm2ZpiHvIRmKv9(GOmJG0bWUW3x8LQcd7F7scbtTMPB8FSCLsqWPfEXSZ4OwkVKQF3TyVtNMSWu5qD03Js1XGsT3zBgVkE5YNqPAfQnaGs)uvJMjbsF(Y(8ZhJ(CgvQKr9VGsTVzhqa2HBzk9RVAhyWRxNTD(zvpVUTBikfQXBzab97iL22gLCRKwOBUdckwpJXvnd7ZFw7oXoq97FAaBvqWUDJshs(Bzq6JbrAYwN95R1EPd6RL0yGFAkdCRMRxcTVmgqFAkY0fVOHAJHm7Zx0NpzCJR)RZ4JY0mw)N)EzDxpAN1hsnnw(x(Ezz)g5wn8ZA1HJBMaJrfPSaC)cvpmKUAmJa9QcwZhqhfB2WWU)68zxhiVDXPXjjE(azpEHAX5L(oAtRXsMJXUOUYvH2jtwM6oOnkunjCnQqi54GRN54gbLRN4(o0ShohEqcRdhUu40o8CV0cxv8U2AMzLHMGXIvOPyUS27GawhFwvE)QD8)xuojjCFIzshxnxK17FxFEyo)0PhOQVBkP(837DJ7pchY0fpD4Zamm)ZLduy)Mdp8mpZDmLvJm5BFhIXMZ6O4wvjxGstBBarDRDCjfc95d]] )

spec:RegisterPack( "Fury", 20260310, [[Hekili:vFvtVTnoq0)ngTyl0kj74UlGTpShk2Kd5IkWEJu0sJIiSKOa5OOgGa9BFjPC1x2YoUbff9qsKjh(EVz4O5ft8iFLeeZqG8OVR)A3LEUoERDxDNpjaFPeibLSOdSN0puWY1)(lvYxml(sMGfBoSsujJ0Bqc2xXZW7li7plIRUthBjerE0JeKYJJH2ibvulQnH)htk5cztyP5pCuVuI5J)lCGNX1Skfj8mnxSiKlkuoLsisKVNH)X2)CpivG8aiPkKvebnpC2OyiMbuvQOc)epz7(QKeNHl6elQlM5SzcrSuxlAEOla9YvkGYrix9jZtIKe6trXB9ggIgKdzGsvO)XWkYKpbOdYZbkkOXCyNV7WdedmmLwZvPdx9gfVHywEPwWDbF8ZosiNXluB2Qae5fpPCQf1kEoTU9kGMOVqOhJMgftXujOPilEKEmfemLlv4GSkfyzyQtzeUzRV7IlYGPIThPW3GOkegIDTg2SAEr87a566ZH8XLMf3rzyxtL8yz88sP9MyuWNCxCTQ1KwGlxaMeS4zqwkQb5Cb3QWUWOsGf)Itv5cRuJQKsOa3CXk6GdBAkoFhX1Rx7EJLRuwUcLA1mlkdL(Ul3j3b2eTVigSAPB)U3m8hQLOmG9SnDmR9mqHciNdQDB9VjvOMs)hoxI96RxTZwJ0X24poQMbsbpIAsLdNrUB(1RwsGUlsPLR1DyP7kV1Ka9bkmaqcUpVuiriUj0VjSnVAcZ4ku508ajW(K1XcsyvzO(XhToydM8A9xApA762zZKaOGTpdIj)db1CBou)kbrA3gqYzAtVtgn3eUtlh3Eqhon3a2sdyFFZ(j3tOC1SuE(X49qoClds3DzKMmJVjCZ2MWBEo)G0TDxdZRVwzRVZOLw9uQWfxH9XEads7(5LgU)8plU7Dj65UB4RH5)62zUhPVdTgN)(2XXMbZnTCqPA0MgU8CVfYM0GpPY759oWAuL07QV3Dcs9vGtnVS7nCIMUSDLl85mX6fCxewbV8Di4B9kB(jexKRXfGDx7L95ScTynNDOTW63R(UaScF(bsJ9FAvN)pKQNAgzb5dnHZxAE913Wl)9wtnHFSp)An8Tj38Z8MMCB(9i3g9pjqmVHh09TC6mupTnT9Bv9M9rVvtTrMODFtRX0z1kRctfssqqvjilQSwWiH8))]] )

spec:RegisterPack( "Protection", 20260310, [[Hekili:TAvqVjopq0)nOD1wLLaTD3vc6H9w7HURuQ2EZjM4jeR6yhz7aQFhYV9VXjqXjqOvPCae4z88EEMXZZKqYtKig1cKhNnD2TtNhoni82P3CnjY(AjqIkPPVqxJ)qslWV)RwzHulxjDMEvOOmxemQkDkA(z1Zr8cdjAvfxyVxswDYOp)wClLqk5XqsuoNXGwpbtkj6PCUPoPuZvAU916e3)wrnaRorjRtS5qDYw12CGIRSUIZGasKGBSMMZcKrRew8Np2C2QmqSkllEDkRbn6oY7wNBbhxbjDLayKFtSipDBAVtMCoiyXgbTONBZ9DBLqPy2CU2y7521(UvO0wQi2y18xGEoEJVJAydix33LBDUCyLOum9aAo1LSZYcsvffujJlxhBYvv2aMAR8qm7B2fXFmIiwNmblhoZROwRaojy(MCa9ZbbYawlcGjaROgEr8wQ2v4JlX(SyBELKb64cfdIlOCPf)0qag0qH9oKkOLbAW5c2SSOoz2bU47JJl)6cWfLmgBNgeIWPJddguOg(W6SQPc()DOGmWr(ypByv4NLvzCHa0VloDUcXGnuJ1ncOB3CyNBqM2eivJbSVJxpoAV7UlE3m9L2c2HwxFB9AD9n1a)nxa43DHUHaPkLWbzWUfpuexwNmDCCC4rdUTSbIbjuWbeJ7qqM1aIgNQhKwP1G02U(zpp5My3oW7bAal1cV2)ubq3anez4jk9jYIlppYbTINUF(QRxmQud4umCC0B6bh6lZaPXrjS7uM2V9C2ignE(HTZhreh1W2RpsAst7lM0KC2aAJZjN288WWzOMpMQLUupj6(IsuUYj6ILP2OvN0OYgu)ag)kBU7QAuvjOLvgNKVtJ(ps)3iuN8CBTRo5l3)VV6QhkCicSNFMG3kqFB537xsQF4uE1prDfpB5zYGNmg(PSZV)jNo7pqy3NSRF4nhWLF7Pgx59yKLH(U49qd)L9EyH)YDEiHVH9Zz8wAKPRlAscdMVePlyFCT29sHtoJM)IzxgSALj8c1XkCVBapweFY7kG3L)FkqB1O7gUDkWDA48eCprJyJ0Y7I6XsStoT01LbHDD3tgsbD50pa8TIvoG7QiD3Yzt8LIU78e7iziFm6ieDmul(Ci1m8M8)]] )



spec:RegisterPackSelector( "arms", "Arms", "|T132292:0|t Arms",
    "If you have spent more points in |T132292:0|t Arms than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "fury", "Fury", "|T132347:0|t Fury",
    "If you have spent more points in |T132347:0|t Fury than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "protection", "Protection", "|T134952:0|t Protection",
    "If you have spent more points in |T134952:0|t Protection than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

