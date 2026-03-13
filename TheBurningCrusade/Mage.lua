-- Mage.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Mage (#8)

if UnitClassBase( "player" ) ~= "MAGE" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 8 )

spec:RegisterGear( "tier4", 29076, 29080, 29078, 29079, 29077 )
spec:RegisterGear( "tier5", 30206, 30205, 30207, 30210, 30196 )
spec:RegisterGear( "tier6", 31056, 31055, 31058, 31059, 31057 )
spec:RegisterGear( "sunwell", 34557, 34574, 34447 )

local function has_arcane_concentration()
    return class.auras.arcane_concentration and buff.arcane_concentration and buff.arcane_concentration.up
end

local function consume_arcane_concentration()
    if has_arcane_concentration() then
        removeBuff( "arcane_concentration" )
    end
end

local function apply_ignite_stack()
    if not talent.ignite.enabled then return end
    if not class.auras.ignite or not debuff.ignite then return end

    if debuff.ignite.up then
        applyDebuff( "target", "ignite", nil, min( debuff.ignite.max_stack or 1, ( debuff.ignite.stack or 0 ) + 1 ) )
    else
        applyDebuff( "target", "ignite", nil, 1 )
    end
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
    arcane_concentration = { 75, 5, 11213, 12574, 12575, 12576, 12577 },
    arcane_focus = { 76, 5, 11222, 12839, 12840, 12841, 12842 },
    arcane_fortitude = { 85, 1, 28574 },
    arcane_impact = { 81, 3, 11242, 12467, 12469 },
    arcane_instability = { 421, 3, 15058, 15059, 15060 },
    arcane_meditation = { 1142, 3, 18462, 18463, 18464 },
    arcane_mind = { 77, 5, 11232, 12500, 12501, 12502, 12503 },
    arcane_potency = { 1725, 3, 31571, 31572, 31573 },
    arcane_power = { 87, 1, 12042 },
    arcane_subtlety = { 74, 2, 11210, 12592 },
    arctic_reach = { 741, 2, 16757, 16758 },
    arctic_winds = { 1738, 5, 31674, 31675, 31676, 31677, 31678 },
    blast_wave = { 32, 1, 11113 },
    blazing_speed = { 1731, 2, 31641, 31642 },
    burning_soul = { 23, 2, 11083, 12351 },
    cold_snap = { 72, 1, 11958 },
    combustion = { 36, 1, 11129 },
    critical_mass = { 33, 3, 11115, 11367, 11368 },
    dragons_breath = { 1735, 1, 31661 },
    elemental_precision = { 1649, 3, 29438, 29439, 29440 },
    empowered_arcane_missiles = { 1727, 3, 31579, 31582, 31583 },
    empowered_fireball = { 1734, 5, 31656, 31657, 31658, 31659, 31660 },
    empowered_frostbolt = { 1740, 5, 31682, 31683, 31684, 31685, 31686 },
    fire_power = { 35, 5, 11124, 12378, 12398, 12399, 12400 },
    flame_throwing = { 28, 2, 11100, 12353 },
    frost_channeling = { 66, 3, 11160, 12518, 12519 },
    frost_warding = { 70, 2, 11189, 28332 },
    frostbite = { 38, 3, 11071, 12496, 12497 },
    frozen_core = { 1736, 3, 31667, 31668, 31669 },
    ice_barrier = { 71, 1, 11426 },
    ice_floes = { 1737, 2, 31670, 31672 },
    ice_shards = { 73, 5, 11207, 12672, 15047, 15052, 15053 },
    icy_veins = { 69, 1, 12472 },
    ignite = { 34, 5, 11119, 11120, 12846, 12847, 12848 },
    impact = { 30, 5, 11103, 12357, 12358, 12359, 12360 },
    improved_arcane_missiles = { 80, 5, 11237, 12463, 12464, 16769, 16770 },
    improved_blink = { 1724, 2, 31569, 31570 },
    improved_blizzard = { 63, 3, 11185, 12487, 12488 },
    improved_cone_of_cold = { 64, 3, 11190, 12489, 12490 },
    improved_counterspell = { 88, 2, 11255, 12598 },
    improved_fire_blast = { 27, 3, 11078, 11080, 12342 },
    improved_fireball = { 26, 5, 11069, 12338, 12339, 12340, 12341 },
    improved_flamestrike = { 31, 3, 11108, 12349, 12350 },
    improved_frost_nova = { 62, 2, 11165, 12475 },
    improved_frostbolt = { 37, 5, 11070, 12473, 16763, 16765, 16766 },
    improved_mana_shield = { 83, 2, 11252, 12605 },
    improved_scorch = { 25, 3, 11095, 12872, 12873 },
    incineration = { 1141, 2, 18459, 18460 },
    magic_absorption = { 1650, 5, 29441, 29444, 29445, 29446, 29447 },
    magic_attunement = { 82, 2, 11247, 12606 },
    master_of_elements = { 1639, 3, 29074, 29075, 29076 },
    mind_mastery = { 1728, 5, 31584, 31585, 31586, 31587, 31588 },
    molten_fury = { 1732, 2, 31679, 31680 },
    molten_shields = { 24, 2, 11094, 13043 },
    permafrost = { 65, 3, 11175, 12569, 12571 },
    piercing_ice = { 61, 3, 11151, 12952, 12953 },
    playing_with_fire = { 1730, 3, 31638, 31639, 31640 },
    presence_of_mind = { 86, 1, 12043 },
    prismatic_cloak = { 1726, 2, 31574, 31575 },
    pyroblast = { 29, 1, 11366 },
    pyromaniac = { 1733, 3, 34293, 34295, 34296 },
    shatter = { 67, 5, 11170, 12982, 12983, 12984, 12985 },
    slow = { 1729, 1, 31589 },
    spell_power = { 1826, 2, 35578, 35581 },
    summon_water_elemental = { 1741, 1, 31687 },
    wand_specialization = { 78, 2, 6057, 6085 },
    winters_chill = { 68, 5, 11180, 28592, 28593, 28594, 28595 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    amplify_magic = {
        id = 1008,
        duration = 600,
        max_stack = 1,
        copy = { 1008, 8455, 10169, 10170, 27130, 33946 },
        -- Aura effects: MOD_DAMAGE_TAKEN, MOD_HEALING
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    arcane_brilliance = {
        id = 23028,
        duration = 3600,
        max_stack = 1,
        copy = { 23028, 27127 },
        -- Aura effects: MOD_STAT
        -- Aura targets: TARGET_UNIT_LASTTARGET_AREA_PARTY, TARGET_UNIT_TARGET_ALLY
    },

    arcane_blast = {
        id = 36032,
        duration = 8,
        max_stack = 3,
        -- Aura effects: ADD_PCT_MODIFIER, MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    arcane_intellect = {
        id = 1459,
        duration = 1800,
        max_stack = 1,
        copy = { 1459, 1460, 1461, 10156, 10157, 27126 },
        -- Aura effects: MOD_STAT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    arcane_missiles = {
        id = 5143,
        duration = 5,
        tick_time = 1,
        max_stack = 1,
        copy = { 5143, 5144, 5145, 8416, 8417, 10211, 10212, 25345, 27075, 38699, 38704 },
        -- Aura effects: DUMMY, PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    arcane_power = {
        id = 12042,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    arcane_torrent = {
        id = 28730,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    blast_wave = {
        id = 11113,
        duration = 6,
        max_stack = 1,
        copy = { 11113, 13018, 13019, 13020, 13021, 27133, 33933 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    blazing_speed = {
        id = 31641,
        duration = 8,
        max_stack = 1,
        copy = { 31641, 31642, 31643 },
        -- Aura effects: MOD_INCREASE_SPEED, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blink = {
        id = 1953,
        duration = 1,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blizzard = {
        id = 10,
        duration = 8,
        tick_time = 1,
        max_stack = 1,
        copy = { 10, 6141, 8427, 10185, 10186, 10187, 27085, 42198, 42208, 42209, 42210, 42211, 42212, 42213 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    chilled = {
        id = 12484,
        duration = 1.5,
        max_stack = 1,
        copy = { 12484, 12485, 12486 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    combustion = {
        id = 11129,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    cone_of_cold = {
        id = 120,
        duration = 8,
        max_stack = 1,
        copy = { 120, 8492, 10159, 10160, 10161, 27087 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_CONE_ENEMY_24
    },

    dampen_magic = {
        id = 604,
        duration = 600,
        max_stack = 1,
        copy = { 604, 8450, 8451, 10173, 10174, 33944 },
        -- Aura effects: MOD_DAMAGE_TAKEN, MOD_HEALING
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    dragons_breath = {
        id = 31661,
        duration = 3,
        max_stack = 1,
        copy = { 31661, 33041, 33042, 33043 },
        -- Aura effects: MOD_CONFUSE, MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_CONE_ENEMY_24
    },

    fire_vulnerability = {
        id = 22959,
        duration = 30,
        max_stack = 5,
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    fire_ward = {
        id = 543,
        duration = 30,
        max_stack = 1,
        copy = { 543, 8457, 8458, 10223, 10225, 27128 },
        -- Aura effects: REFLECT_SPELLS_SCHOOL, SCHOOL_ABSORB
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fireball = {
        id = 133,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    frost_armor = {
        id = 168,
        duration = 1800,
        max_stack = 1,
        copy = { 168, 7300, 7301 },
        -- Aura effects: MOD_RESISTANCE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    frost_nova = {
        id = 122,
        duration = 8,
        max_stack = 1,
        copy = { 122, 865, 6131, 10230, 27088 },
        -- Aura effects: MOD_ROOT
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    frost_ward = {
        id = 6143,
        duration = 30,
        max_stack = 1,
        copy = { 6143, 8461, 8462, 10177, 28609, 32796 },
        -- Aura effects: REFLECT_SPELLS_SCHOOL, SCHOOL_ABSORB
        -- Aura targets: TARGET_UNIT_CASTER
    },

    frostbite = {
        id = 11071,
        duration = 5,
        max_stack = 1,
        copy = { 11071, 12494, 12496, 12497 },
        -- Aura effects: ADD_TARGET_TRIGGER, MOD_ROOT
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ANY
    },

    frostbolt = {
        id = 116,
        duration = 9,
        max_stack = 1,
        copy = { 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    ice_armor = {
        id = 7302,
        duration = 1800,
        max_stack = 1,
        copy = { 7302, 7320, 10219, 10220, 27124 },
        -- Aura effects: MOD_RESISTANCE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    ice_barrier = {
        id = 11426,
        duration = 60,
        max_stack = 1,
        copy = { 11426, 13031, 13032, 13033, 27134, 33405 },
        -- Aura effects: SCHOOL_ABSORB
        -- Aura targets: TARGET_UNIT_CASTER
    },

    ice_block = {
        id = 45438,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MOD_STUN, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    icy_veins = {
        id = 12472,
        duration = 20,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER, MOD_CASTING_SPEED_NOT_STACK
        -- Aura targets: TARGET_UNIT_CASTER
    },

    impact = {
        id = 11103,
        duration = 2,
        max_stack = 1,
        copy = { 11103, 12355, 12357, 12358, 12359, 12360 },
        -- Aura effects: MOD_STUN, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    mage_armor = {
        id = 6117,
        duration = 1800,
        max_stack = 1,
        copy = { 6117, 22782, 22783, 27125 },
        -- Aura effects: MOD_MANA_REGEN_INTERRUPT, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    magic_absorption = {
        id = 29441,
        max_stack = 1,
        copy = { 29441, 29442, 29444, 29445, 29446, 29447 },
        -- Aura effects: DUMMY, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    mana_shield = {
        id = 1463,
        duration = 60,
        max_stack = 1,
        copy = { 1463, 8494, 8495, 10191, 10192, 10193, 27131 },
        -- Aura effects: MANA_SHIELD
        -- Aura targets: TARGET_UNIT_CASTER
    },

    master_of_elements = {
        id = 29074,
        max_stack = 1,
        copy = { 29074, 29075, 29076, 29077 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    molten_armor = {
        id = 30482,
        duration = 1800,
        max_stack = 1,
        -- Aura effects: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, MOD_SPELL_CRIT_CHANCE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    polymorph = {
        id = 118,
        duration = 50,
        max_stack = 1,
        copy = { 118, 12824, 12825, 12826, 28271, 28272 },
        -- Aura effects: MOD_CONFUSE, TRANSFORM
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    presence_of_mind = {
        id = 12043,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    pyroblast = {
        id = 11366,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    slow = {
        id = 31589,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER_BY_SPELL_LABEL, HASTE_SPELLS, MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    slow_fall = {
        id = 130,
        duration = 30,
        max_stack = 1,
        -- Aura effects: FEATHER_FALL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    winters_chill = {
        id = 12579,
        duration = 15,
        max_stack = 5,
        copy = { 11180, 12579, 28592, 28593, 28594, 28595 },
        -- Aura effects: MOD_SPELL_CRIT_CHANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
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

-- Amplify Magic - Amplifies magic used against the targeted party member, increasing damage taken from spells by up to 15-120 and healing spells by up to 30-240. Lasts 600 sec.
    amplify_magic = {
        id = 1008,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "arcane",
        texture = 135907,
        range = 30,
        spend = 150,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1008, 8455, 10169, 10170, 27130, 33946 },

        -- Effects:
        -- [ ] Rank 1008 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 1008 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8455 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8455 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10169 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10169 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10170 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10170 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 27130 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 27130 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 179, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 33946 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 33946 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: 239, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Annihilator Holo-Gogs
    annihilator_holo_gogs = {
        id = 46111,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46111 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Arcane Brilliance - Infuses the target's party with brilliance, increasing their Intellect by 31/40 for 3600 sec.
    arcane_brilliance = {
        id = 23028,
        cast = 0,
        duration = 3600,
        gcd = "spell",
        school = "arcane",
        texture = 135869,
        range = 40,
        spend = 1500,
        spendType = "Mana",
        max_stack = 1,
        copy = { 23028, 27127 },

        -- Effects:
        -- [x] Rank 23028 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 27127 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        handler = function ()
            applyBuff( "arcane_brilliance" )
        end,
    },

-- Arcane Blast - Blasts the target with energy, dealing Arcane damage. Each time you cast Arcane Blast, damage is increased and mana cost is increased while cast time is reduced.
    arcane_blast = {
        id = 30451,
        cast = function () return max( 0, 2.5 + -0.333 * ( buff.arcane_blast.stack or 0 ) ) end,
        gcd = "spell",
        school = "arcane",
        texture = 136096,
        range = 30,
        spend = function ()
            if has_arcane_concentration() then return 0 end
            return 195 * ( 1 + 0.75 * ( buff.arcane_blast.stack or 0 ) )
        end,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 30451 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 668, addl_points: 105, points_per_level: 0, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30451 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.arcane_blast.up then
                applyBuff( "arcane_blast", nil, min( buff.arcane_blast.max_stack, ( buff.arcane_blast.stack or 0 ) + 1 ) )
            else
                applyBuff( "arcane_blast", nil, 1 )
            end
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "arcane_blast" ) end
        end,

        proc_chance = 100,
    },

-- Arcane Explosion - Causes an explosion of arcane magic around the caster, causing 32-377 Arcane damage to all targets within $a1 yards.
    arcane_explosion = {
        id = 1449,
        cast = 0,
        gcd = "spell",
        school = "arcane",
        texture = 136116,
        spend = function () return has_arcane_concentration() and 0 or 75 end,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1449, 8437, 8438, 8439, 10201, 10202, 27080, 27082 },

        -- Effects:
        -- [x] Rank 1449 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 31, addl_points: 5, points_per_level: 0.4, sp_bonus: 0.166, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8437 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 56, addl_points: 7, points_per_level: 0.6, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8438 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 96, addl_points: 9, points_per_level: 0.9, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 8439 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 13, points_per_level: 0.9, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 10201 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 185, addl_points: 17, points_per_level: 1.1, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 10202 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 242, addl_points: 21, points_per_level: 1.3, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27080 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 305, addl_points: 25, points_per_level: 1.5, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27082 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 376, addl_points: 31, points_per_level: 1.6, sp_bonus: 0.214, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0

        radius = 10,

        handler = function ()
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "arcane_explosion" ) end
        end,

        proc_chance = 100,
    },

-- Arcane Intellect - Increases the target's Intellect by 2-40 for 1800 sec.
    arcane_intellect = {
        id = 1459,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "arcane",
        texture = 135932,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1459, 1460, 1461, 10156, 10157, 27126 },

        -- Effects:
        -- [x] Rank 1459 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1460 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1461 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10156 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10157 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27126 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "arcane_intellect" )
        end,
    },

-- Arcane Missiles - Launches Arcane Missiles at the enemy, causing 24 Arcane damage every $t2 sec for 3/4/5 sec.
    arcane_missiles = {
        id = 5143,
        cast = 0,
        duration = 5,
        gcd = "spell",
        school = "arcane",
        texture = 136096,
        range = 30,
        spend = function ()
            if has_arcane_concentration() then return 0 end
            return max( 0, 85 * ( 1 + 0.02 * ( talent.empowered_arcane_missiles.rank or 0 ) ) )
        end,
        -- Talent spend scaling: empowered_arcane_missiles (2% per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 5143, 5144, 5145, 8416, 8417, 10211, 10212, 25345, 27075, 38699, 38704 },

        -- Effects:
        -- [x] Rank 5143 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5143 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7268
        -- [x] Rank 5144 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5144 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7269
        -- [x] Rank 5145 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5145 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7270
        -- [x] Rank 8416 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8416 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 8419
        -- [x] Rank 8417 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8417 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 8418
        -- [x] Rank 10211 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10211 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 10273
        -- [x] Rank 10212 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10212 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 10274
        -- [x] Rank 25345 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25345 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 25346
        -- [x] Rank 27075 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27075 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 27076
        -- [x] Rank 38699 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38699 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 38700
        -- [x] Rank 38704 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38704 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 38703

        channeled = true,

        handler = function ()
            applyDebuff( "target", "arcane_missiles" )
            applyBuff( "arcane_missiles" )
            consume_arcane_concentration()
        end,

        proc_chance = 100,
    },

-- Arcane Power - When activated, your spells deal 30% more damage while costing 30% more mana to cast. This effect lasts 15 sec.
    arcane_power = {
        id = 12042,
        cast = 0,
        duration = 15,
        cooldown = 180,
        school = "arcane",
        texture = 136048,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 12042 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12042 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12042 #2 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "arcane_power" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Arcane Torrent - Silence all enemies within $a1 yards for 2 sec. In addition, you gain 10 Mana for each Mana Tap charge currently affecting you.
    arcane_torrent = {
        id = 28730,
        cast = 0,
        duration = 2,
        cooldown = 120,
        gcd = "spell",
        school = "arcane",
        texture = 136222,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 28730 #0 -- effect: APPLY_AURA, aura: MOD_SILENCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 28730 #1 -- effect: DUMMY, aura: NONE, points: 9, addl_points: 1, points_per_level: 2.16, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 8,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Berserking - Increases your casting and attack speed by $26635m1% to $26635M1%. At full health the speed increase is $26635m1% with a greater effect up to $26635M1% if you are badly hurt when you activate Berserking. Lasts $26635d.
    berserking = {
        id = 20554,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 135727,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 20554 #0 -- effect: DUMMY, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Blast Wave - A wave of flame radiates outward from the caster, damaging all enemies caught within the blast for 154-616 Fire damage, and Dazing them for 6 sec.
    blast_wave = {
        id = 11113,
        cast = 0,
        duration = 6,
        category_cooldown = 30,
        gcd = "spell",
        school = "fire",
        texture = 135903,
        cooldown_category_id = 250,
        cooldown_category = "Blast Wave",
        spend = 215,
        spendType = "Mana",
        max_stack = 1,
        copy = { 11113, 13018, 13019, 13020, 13021, 27133, 33933 },

        -- Effects:
        -- [x] Rank 11113 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 153, addl_points: 33, points_per_level: 1, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 11113 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 13018 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 200, addl_points: 41, points_per_level: 1.2, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 13018 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 13019 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 276, addl_points: 53, points_per_level: 1.4, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 13019 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 13020 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 364, addl_points: 69, points_per_level: 1.6, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 13020 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 13021 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 461, addl_points: 83, points_per_level: 1.9, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 13021 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 27133 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 532, addl_points: 95, points_per_level: 2.1, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 27133 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        -- [x] Rank 33933 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 615, addl_points: 109, points_per_level: 2.3, sp_bonus: 0.193, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 33933 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: ensnared
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "blast_wave" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Blazing Speed - Gives you a $h% chance when hit by a melee or ranged attack to increase your movement speed by 50% and dispel all movement impairing effects. This effect lasts $31643d.
    blazing_speed = {
        id = 31641,
        cast = 0,
        duration = 8,
        school = "fire",
        texture = 135788,
        max_stack = 1,
        copy = { 31641, 31642, 31643 },

        -- Effects:
        -- [x] Rank 31641 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [x] Rank 31642 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [x] Rank 31643 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 31643 #1 -- effect: DISPEL_MECHANIC, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 31643 #2 -- effect: DISPEL_MECHANIC, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blazing_speed" )
        end,

        proc_chance = 5,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Blink - Teleports the caster $a1 yards forward, unless something is in the way. Also frees the caster from stuns and bonds.
    blink = {
        id = 1953,
        cast = 0,
        duration = 1,
        category_cooldown = 15,
        gcd = "spell",
        school = "arcane",
        texture = 135736,
        cooldown_category_id = 44,
        cooldown_category = "Speed",
        spend_pct = 21,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1953 #0 -- effect: LEAP, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_CASTER_FRONT_LEAP, mechanic: 0
        -- [x] Rank 1953 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1953 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 20,

        handler = function ()
            applyBuff( "blink" )
        end,
    },

-- Blizzard - Ice shards pelt the target area doing ${$42208m1*8} Frost damage over 8 sec.
    blizzard = {
        id = 10,
        cast = 0,
        duration = 8,
        gcd = "spell",
        school = "frost",
        texture = 135857,
        range = 100,
        spend = function () return max( 0, 320 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 10, 6141, 8427, 10185, 10186, 10187, 27085, 42198, 42208, 42209, 42210, 42211, 42212, 42213 },

        -- Effects:
        -- [ ] Rank 10 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 24, addl_points: 1, points_per_level: 0.1, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42208
        -- [ ] Rank 6141 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 43, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6141 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42209
        -- [ ] Rank 8427 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 64, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8427 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42210
        -- [ ] Rank 10185 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 89, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10185 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42211
        -- [ ] Rank 10186 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 116, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10186 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42212
        -- [ ] Rank 10187 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 148, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10187 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42213
        -- [ ] Rank 27085 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 183, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27085 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42198
        -- [x] Rank 42198 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 183, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42208 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 1, points_per_level: 0.1, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42209 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 43, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42210 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 64, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42211 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 89, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42212 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 116, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42213 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 148, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        channeled = true,

        handler = function ()
            applyBuff( "blizzard" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "blizzard" ) end
        end,

        proc_chance = 100,
    },

-- Chilled - Chills the target for 1.5 sec.
    chilled = {
        id = 12484,
        cast = 0,
        duration = 1.5,
        school = "frost",
        texture = 135857,
        range = 50000,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        max_stack = 1,
        copy = { 12484, 12485, 12486 },

        -- Effects:
        -- [x] Rank 12484 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12485 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12486 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -66, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "chilled" )
        end,
    },

-- Cold Snap - When activated, this spell finishes the cooldown on all Frost spells you recently cast.
    cold_snap = {
        id = 11958,
        cast = 0,
        cooldown = 480,
        school = "frost",
        texture = 135865,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11958 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            setCooldown( "icy_veins", 0 )
            setCooldown( "cold_snap", 480 )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Combustion - When activated, this spell causes each of your Fire damage spell hits to increase your critical strike chance with Fire damage spells by 1%. This effect lasts until you have caused $n critical strikes with Fire spells.
    combustion = {
        id = 11129,
        cast = 0,
        cooldown = 180,
        school = "fire",
        texture = 135824,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11129 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11129 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28682

        handler = function ()
            applyBuff( "combustion" )
        end,

        proc_chance = 100,
        proc_charges = 3,
        proc_type_mask = { 65536, 0 },
        -- Proc type flags: mask0: Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Cone of Cold - Targets in a cone in front of the caster take 98-410 Frost damage and are slowed by 50% for 8 sec.
    cone_of_cold = {
        id = 120,
        cast = 0,
        duration = 8,
        category_cooldown = 10,
        gcd = "spell",
        school = "frost",
        texture = 135852,
        cooldown_category_id = 50,
        cooldown_category = "Direct Damage (AE-Cone) - Ability",
        spend = function () return max( 0, 210 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 120, 8492, 10159, 10160, 10161, 27087 },

        -- Effects:
        -- [ ] Rank 120 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 120 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 97, addl_points: 11, points_per_level: 0.8, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 8492 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 8492 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 145, addl_points: 15, points_per_level: 1, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 10159 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 10159 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 202, addl_points: 21, points_per_level: 1.2, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 10160 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 10160 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 263, addl_points: 27, points_per_level: 1.3, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 10161 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 10161 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 334, addl_points: 31, points_per_level: 1.5, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 27087 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 27087 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 409, addl_points: 39, points_per_level: 1.7, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "cone_of_cold" ) end
        end,

        proc_chance = 100,
    },

-- Conjure Food - Conjures 2/10 $lmuffin:muffins;, providing the mage and $ghis:her; allies with something to eat. Conjured items disappear if logged out for more than 15 minutes.
    conjure_food = {
        id = 587,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 133952,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 587, 597, 990, 6129, 10144, 10145, 28612, 33717 },

        -- Effects:
        -- [x] Rank 587 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 597 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 990 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6129 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10144 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10145 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28612 #0 -- effect: CREATE_ITEM, aura: NONE, points: 9, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33717 #0 -- effect: CREATE_ITEM, aura: NONE, points: 9, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Conjure Mana Agate - Conjures a mana agate that can be used to instantly restore 390 mana. Conjured items disappear if logged out for more than 15 minutes.
    conjure_mana_agate = {
        id = 759,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 134104,
        spend = 530,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 759 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Conjure Mana Citrine - Conjures a mana citrine that can be used to instantly restore 829 mana. Conjured items disappear if logged out for more than 15 minutes.
    conjure_mana_citrine = {
        id = 10053,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 134116,
        spend = 1130,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 10053 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Conjure Mana Emerald - Conjures a mana emerald that can be used to instantly restore 2340 mana. 3 charges. Conjured items disappear if logged out for more than 15 minutes.
    conjure_mana_emerald = {
        id = 27101,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 134134,
        cooldown_category_id = 87,
        cooldown_category = "Conjure (Long)",
        spend = 1670,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 27101 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Conjure Mana Jade - Conjures a mana jade that can be used to instantly restore 585 mana. Conjured items disappear if logged out for more than 15 minutes.
    conjure_mana_jade = {
        id = 3552,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 134105,
        spend = 800,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3552 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Conjure Mana Ruby - Conjures a mana ruby that can be used to instantly restore 1073 mana. Conjured items disappear if logged out for more than 15 minutes.
    conjure_mana_ruby = {
        id = 10054,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 134128,
        spend = 1470,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 10054 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Conjure Water - Conjures 2/10 $lbottle:bottles; of water, providing the mage and $ghis:her; allies with something to drink. Conjured items disappear if logged out for more than 15 minutes.
    conjure_water = {
        id = 5504,
        cast = 3,
        gcd = "spell",
        school = "arcane",
        texture = 132793,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5504, 5505, 5506, 6127, 10138, 10139, 10140, 27090, 37420 },

        -- Effects:
        -- [x] Rank 5504 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5505 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5506 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6127 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10138 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10139 #0 -- effect: CREATE_ITEM, aura: NONE, points: 1, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10140 #0 -- effect: CREATE_ITEM, aura: NONE, points: 9, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27090 #0 -- effect: CREATE_ITEM, aura: NONE, points: 9, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 37420 #0 -- effect: CREATE_ITEM, aura: NONE, points: 9, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Counterspell - Counters the enemy's spellcast, preventing any spell from that school of magic from being cast for 8 sec. Generates a high amount of threat.
    counterspell = {
        id = 2139,
        cast = 0,
        duration = 8,
        category_cooldown = 24,
        school = "arcane",
        texture = 135856,
        cooldown_category_id = 88,
        cooldown_category = "Silence",
        range = 30,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2139 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Dampen Magic - Dampens magic used against the targeted party member, decreasing damage taken from spells by up to 10-120 and healing spells by up to 20-240. Lasts 600 sec.
    dampen_magic = {
        id = 604,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "arcane",
        texture = 136006,
        range = 30,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,
        copy = { 604, 8450, 8451, 10173, 10174, 33944 },

        -- Effects:
        -- [ ] Rank 604 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 604 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8450 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8450 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8451 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 8451 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -81, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10173 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10173 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -121, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10174 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -91, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10174 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -181, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 33944 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -121, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 33944 #1 -- effect: APPLY_AURA, aura: MOD_HEALING, points: -241, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Destruction Holo-gogs
    destruction_holo_gogs = {
        id = 41320,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41320 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Dragon's Breath - Targets in a cone in front of the caster take 370/454/574/680 Fire damage and are Disoriented for 3 sec. Any direct damaging attack will revive targets. Turns off your attack when used.
    dragons_breath = {
        id = 31661,
        cast = 0,
        duration = 3,
        category_cooldown = 20,
        gcd = "spell",
        school = "fire",
        texture = 134153,
        cooldown_category_id = 50,
        cooldown_category = "Direct Damage (AE-Cone) - Ability",
        spend = 475,
        spendType = "Mana",
        max_stack = 1,
        copy = { 31661, 33041, 33042, 33043 },

        -- Effects:
        -- [x] Rank 31661 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 369, addl_points: 61, points_per_level: 1.5, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 31661 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: disoriented
        -- [ ] Rank 31661 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 33041 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 453, addl_points: 73, points_per_level: 1.6, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 33041 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: disoriented
        -- [ ] Rank 33041 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 33042 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 573, addl_points: 93, points_per_level: 1.8, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 33042 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: disoriented
        -- [ ] Rank 33042 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        -- [x] Rank 33043 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 679, addl_points: 111, points_per_level: 2, sp_bonus: 0.193, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: 0
        -- [ ] Rank 33043 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: disoriented
        -- [ ] Rank 33043 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_CONE_ENEMY_24, target2: NONE, mechanic: ensnared
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "dragons_breath" ) end
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Fire Blast - Blasts the enemy for 24-664 Fire damage.
    fire_blast = {
        id = 2136,
        cast = 0,
        cooldown = function () return max( 0, 8 + -0.5 * ( talent.improved_fire_blast.rank or 0 ) ) end,
        category_cooldown = 8,
        gcd = "spell",
        school = "fire",
        texture = 135807,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 20,
        spend = function () return has_arcane_concentration() and 0 or 40 end,
        -- Talent cooldown scaling (category source): improved_fire_blast (-0.5s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 2136, 2137, 2138, 8412, 8413, 10197, 10199, 27078, 27079 },

        -- Effects:
        -- [x] Rank 2136 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 23, addl_points: 9, points_per_level: 0.6, sp_bonus: 0.204, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2137 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 56, addl_points: 15, points_per_level: 1, sp_bonus: 0.332, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2138 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 102, addl_points: 25, points_per_level: 1.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8412 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 167, addl_points: 35, points_per_level: 1.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8413 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 241, addl_points: 49, points_per_level: 2.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10197 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 331, addl_points: 63, points_per_level: 2.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10199 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 430, addl_points: 79, points_per_level: 3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27078 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 538, addl_points: 99, points_per_level: 3.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27079 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 663, addl_points: 123, points_per_level: 3.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            apply_ignite_stack()
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "fire_blast" ) end
        end,

        proc_chance = 100,
    },

-- Fire Vulnerability - Increases Fire damage taken by 3%.
    fire_vulnerability = {
        id = 22959,
        cast = 0,
        duration = 30,
        school = "fire",
        texture = 135827,
        range = 100,
        max_stack = 5,

        -- Effects:
        -- [x] Rank 22959 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if debuff.fire_vulnerability.up then
                applyDebuff( "target", "fire_vulnerability", nil, min( debuff.fire_vulnerability.max_stack, debuff.fire_vulnerability.stack + 1 ) )
            else
                applyDebuff( "target", "fire_vulnerability", nil, 1 )
            end
        end,

        proc_chance = 100,
    },

-- Fire Ward - Absorbs 165-1125 Fire damage. Lasts 30 sec.
    fire_ward = {
        id = 543,
        cast = 0,
        duration = 30,
        category_cooldown = 30,
        gcd = "spell",
        school = "fire",
        texture = 135806,
        cooldown_category_id = 56,
        cooldown_category = "Instant Heal - Spell",
        spend = 85,
        spendType = "Mana",
        max_stack = 1,
        copy = { 543, 8457, 8458, 10223, 10225, 27128 },

        -- Effects:
        -- [x] Rank 543 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 164, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 543 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8457 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 289, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8457 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8458 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 469, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8458 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10223 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 674, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10223 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10225 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 874, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10225 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27128 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 1124, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27128 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "fire_ward" )
        end,

        proc_chance = 100,
    },

-- Fireball - Hurls a fiery ball that causes 14-717 Fire damage and an additional 2-84 Fire damage over 4/6/8 sec.
    fireball = {
        id = 133,
        cast = function () return max( 0, 1.5 + -0.1 * ( talent.improved_fireball.rank or 0 ) ) end,
        duration = 8,
        gcd = "spell",
        school = "fire",
        texture = 135812,
        range = 35,
        spend = function () return has_arcane_concentration() and 0 or 30 end,
        -- Talent cast scaling: improved_fireball (-0.1s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692 },

        -- Effects:
        -- [x] Rank 133 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 13, addl_points: 9, points_per_level: 0.6, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 133 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 143 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 30, addl_points: 15, points_per_level: 0.8, sp_bonus: 0.271, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 143 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 145 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 52, addl_points: 21, points_per_level: 1, sp_bonus: 0.5, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 145 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 3140 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 83, addl_points: 33, points_per_level: 1.3, sp_bonus: 0.793, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 3140 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8400 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 49, points_per_level: 1.8, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8400 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8401 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 198, addl_points: 67, points_per_level: 2.1, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8401 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8402 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 254, addl_points: 81, points_per_level: 2.4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8402 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10148 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 317, addl_points: 97, points_per_level: 2.7, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10148 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10149 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 391, addl_points: 115, points_per_level: 3, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10149 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10150 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 474, addl_points: 135, points_per_level: 3.4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10150 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10151 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 560, addl_points: 155, points_per_level: 3.7, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10151 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25306 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 595, addl_points: 165, points_per_level: 3.8, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25306 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 18, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27070 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 632, addl_points: 173, points_per_level: 4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27070 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38692 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 716, addl_points: 197, points_per_level: 4.2, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38692 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "fireball" )
            apply_ignite_stack()
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "fireball" ) end
        end,

        proc_chance = 100,
    },

-- Flamestrike - Calls down a pillar of fire, burning all enemies within the area for 52-471 Fire damage and an additional 48-424 Fire damage over 8 sec.
    flamestrike = {
        id = 2120,
        cast = 3,
        duration = 8,
        gcd = "spell",
        school = "fire",
        texture = 135826,
        range = 30,
        spend = 195,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2120, 2121, 8422, 8423, 10215, 10216, 27086 },

        -- Effects:
        -- [x] Rank 2120 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 51, addl_points: 17, points_per_level: 0.6, sp_bonus: 0.2, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2120 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0.026, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2121 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 95, addl_points: 27, points_per_level: 0.8, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2121 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8422 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 153, addl_points: 39, points_per_level: 1, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8422 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8423 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 219, addl_points: 53, points_per_level: 1.3, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8423 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 48, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10215 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 290, addl_points: 69, points_per_level: 1.5, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10215 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 65, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10216 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 374, addl_points: 85, points_per_level: 1.7, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10216 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27086 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 470, addl_points: 105, points_per_level: 1.9, sp_bonus: 0.236, radius_idx: 8, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27086 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 105, addl_points: 1, points_per_level: 0, sp_bonus: 0.03, radius_idx: 8, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 5,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "flamestrike" ) end
        end,

        proc_chance = 100,
    },

-- Frost Armor - Increases Armor by 30/110/200. If an enemy strikes the caster, they may have their movement slowed by 30% and the time between their attacks increased by 25% for $6136d. Only one type of Armor spell can be active on the Mage at any time. Lasts 1800 sec.
    frost_armor = {
        id = 168,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "frost",
        texture = 135843,
        spend = function () return max( 0, 60 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 168, 7300, 7301 },

        -- Effects:
        -- [x] Rank 168 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 168 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6136
        -- [x] Rank 7300 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7300 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6136
        -- [x] Rank 7301 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7301 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6136

        handler = function ()
            applyBuff( "frost_armor" )
        end,

        proc_chance = 100,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Frost Nova - Blasts enemies near the caster for 19/33/52/71/99 Frost damage and freezes them in place for up to 8 sec. Damage caused may interrupt the effect.
    frost_nova = {
        id = 122,
        cast = 0,
        duration = 8,
        cooldown = function () return max( 0, 25 + -2 * ( talent.improved_frost_nova.rank or 0 ) ) end,
        category_cooldown = 25,
        gcd = "spell",
        school = "frost",
        texture = 135848,
        cooldown_category_id = 35,
        cooldown_category = "Direct Damage (AE) - Spell",
        spend = function () return max( 0, 55 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent cooldown scaling (category source): improved_frost_nova (-2s per rank)
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 122, 865, 6131, 10230, 27088 },

        -- Effects:
        -- [x] Rank 122 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 18, addl_points: 3, points_per_level: 0.5, sp_bonus: 0.018, radius_idx: 0, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 122 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: rooted
        -- [x] Rank 865 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 32, addl_points: 5, points_per_level: 0.5, sp_bonus: 0.043, radius_idx: 0, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 865 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: rooted
        -- [x] Rank 6131 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 51, addl_points: 7, points_per_level: 0.5, sp_bonus: 0.043, radius_idx: 0, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 6131 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: rooted
        -- [x] Rank 10230 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 70, addl_points: 9, points_per_level: 0.5, sp_bonus: 0.043, radius_idx: 0, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 10230 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: rooted
        -- [x] Rank 27088 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 98, addl_points: 13, points_per_level: 0.5, sp_bonus: 0.043, radius_idx: 0, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 27088 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: rooted
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "frost_nova" ) end
        end,

        proc_chance = 100,
    },

-- Frost Ward - Absorbs 165-1125 Frost damage. Lasts 30 sec.
    frost_ward = {
        id = 6143,
        cast = 0,
        duration = 30,
        category_cooldown = 30,
        gcd = "spell",
        school = "frost",
        texture = 135850,
        cooldown_category_id = 56,
        cooldown_category = "Instant Heal - Spell",
        spend = function () return max( 0, 85 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 6143, 8461, 8462, 10177, 28609, 32796 },

        -- Effects:
        -- [x] Rank 6143 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 164, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6143 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8461 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 289, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8461 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8462 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 469, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8462 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10177 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 674, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10177 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28609 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 874, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28609 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32796 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 1124, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32796 #1 -- effect: APPLY_AURA, aura: REFLECT_SPELLS_SCHOOL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "frost_ward" )
        end,

        proc_chance = 100,
    },

-- Frostbite - Gives your Chill effects a 0/5/10/15% chance to freeze the target for $12494d.
    frostbite = {
        id = 11071,
        cast = 0,
        duration = 5,
        school = "frost",
        texture = 135842,
        range = 100,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        max_stack = 1,
        copy = { 11071, 12494, 12496, 12497 },

        -- Effects:
        -- [x] Rank 11071 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12494
        -- [ ] Rank 12494 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 12496 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12494
        -- [x] Rank 12497 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12494

        handler = function ()
            applyBuff( "frostbite" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Frostbolt - Launches a bolt of frost at the enemy, causing 18-630 Frost damage and slowing movement speed by 40% for 5/6/7/8/9 sec.
    frostbolt = {
        id = 116,
        cast = function () return max( 0, 1.5 + -0.1 * ( talent.improved_frostbolt.rank or 0 ) ) end,
        duration = 9,
        gcd = "spell",
        school = "frost",
        texture = 135846,
        range = 30,
        spend = function ()
            if has_arcane_concentration() then return 0 end
            return max( 0, 25 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) )
        end,
        -- Talent cast scaling: improved_frostbolt (-0.1s per rank)
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697 },

        -- Effects:
        -- [x] Rank 116 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 116 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 17, addl_points: 3, points_per_level: 0.5, sp_bonus: 0.163, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 205 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 205 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 30, addl_points: 5, points_per_level: 0.7, sp_bonus: 0.269, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 837 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 837 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 50, addl_points: 7, points_per_level: 0.9, sp_bonus: 0.463, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7322 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 7322 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 73, addl_points: 9, points_per_level: 1.1, sp_bonus: 0.706, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8406 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 8406 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 125, addl_points: 13, points_per_level: 1.5, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8407 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 8407 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 173, addl_points: 17, points_per_level: 1.7, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8408 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 8408 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 226, addl_points: 21, points_per_level: 2, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10179 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 10179 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 291, addl_points: 25, points_per_level: 2.3, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10180 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 10180 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 352, addl_points: 31, points_per_level: 2.6, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10181 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 10181 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 428, addl_points: 35, points_per_level: 2.9, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25304 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 25304 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 514, addl_points: 41, points_per_level: 3.2, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27071 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 27071 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 535, addl_points: 43, points_per_level: 3.2, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27072 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 27072 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 596, addl_points: 47, points_per_level: 3.5, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38697 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 38697 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 629, addl_points: 51, points_per_level: 3.8, sp_bonus: 0.814, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "frostbolt" )
            if talent.winters_chill.enabled then
                if debuff.winters_chill.up then
                    applyDebuff( "target", "winters_chill", nil, min( debuff.winters_chill.max_stack, debuff.winters_chill.stack + 1 ) )
                else
                    applyDebuff( "target", "winters_chill", nil, 1 )
                end
            end
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "frostbolt" ) end
        end,

        proc_chance = 100,
    },

-- Ice Armor - Increases Armor by 290/380/470/560/645 and frost resistance by 6/9/12/15/18. If an enemy strikes the caster, they may have their movement slowed by 30% and the time between their attacks increased by 25% for $7321d. Only one type of Armor spell can be active on the Mage at any time. Lasts 1800 sec.
    ice_armor = {
        id = 7302,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "frost",
        texture = 135843,
        spend = function () return max( 0, 240 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 7302, 7320, 10219, 10220, 27124 },

        -- Effects:
        -- [x] Rank 7302 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 289, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7302 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7321
        -- [x] Rank 7302 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7320 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 379, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7320 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7321
        -- [x] Rank 7320 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10219 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 469, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10219 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7321
        -- [x] Rank 10219 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10220 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 559, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10220 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7321
        -- [x] Rank 10220 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27124 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 644, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27124 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 7321
        -- [x] Rank 27124 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "ice_armor" )
        end,

        proc_chance = 100,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Ice Barrier - Instantly shields you, absorbing 438-1075 damage. Lasts 60 sec. While the shield holds, spells will not be interrupted.
    ice_barrier = {
        id = 11426,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "frost",
        texture = 135988,
        cooldown_category_id = 471,
        cooldown_category = "Ice Barrier",
        spend = function () return max( 0, 305 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,
        copy = { 11426, 13031, 13032, 13033, 27134, 33405 },

        -- Effects:
        -- [x] Rank 11426 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 437, addl_points: 1, points_per_level: 2.8, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 13031 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 548, addl_points: 1, points_per_level: 3.2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 13032 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 677, addl_points: 1, points_per_level: 3.6, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 13033 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 817, addl_points: 1, points_per_level: 4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27134 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 924, addl_points: 1, points_per_level: 4.4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33405 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 1074, addl_points: 1, points_per_level: 4.8, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "ice_barrier" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Ice Block - You become encased in a block of ice, protecting you from all physical attacks and spells for 10 sec, but during that time you cannot attack, move or cast spells. Also causes Hypothermia, preventing you from recasting Ice Block for $41425d.
    ice_block = {
        id = 45438,
        cast = 0,
        duration = 10,
        category_cooldown = 300,
        gcd = "spell",
        school = "frost",
        texture = 135841,
        cooldown_category_id = 37,
        cooldown_category = "Invulnerability",
        spend = function () return max( 0, 15 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 45438 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45438 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45438 #2 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "ice_block" )
        end,

        proc_chance = 100,

        -- Aura restrictions: exclude_caster_state=19
    },

-- Icy Veins - Hastens your spellcasting, increasing spell casting speed by 20% and gives you 100% chance to avoid interruption caused by damage while casting. Lasts 20 sec.
    icy_veins = {
        id = 12472,
        cast = 0,
        duration = 20,
        cooldown = 180,
        school = "frost",
        texture = 135838,
        spend_pct = function () return 3 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 12472 #0 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 12472 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "icy_veins" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Impact - Gives your Fire spells a $h% chance to stun the target for $12355d.
    impact = {
        id = 11103,
        cast = 0,
        duration = 2,
        school = "fire",
        texture = 135821,
        range = 100,
        max_stack = 1,
        copy = { 11103, 12355, 12357, 12358, 12359, 12360 },

        -- Effects:
        -- [x] Rank 11103 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12355
        -- [x] Rank 12355 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12357 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12355
        -- [x] Rank 12358 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12355
        -- [x] Rank 12359 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12355
        -- [x] Rank 12360 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 12355

        handler = function ()
            applyDebuff( "target", "impact" )
            applyBuff( "impact" )
        end,

        proc_chance = 2,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Mage Armor - Increases your resistance to all magic by 5/10/15/18 and allows 30% of your mana regeneration to continue while casting. Only one type of Armor spell can be active on the Mage at any time. Lasts 1800 sec.
    mage_armor = {
        id = 6117,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "arcane",
        texture = 135991,
        spend = 270,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6117, 22782, 22783, 27125 },

        -- Effects:
        -- [x] Rank 6117 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6117 #1 -- effect: APPLY_AURA, aura: MOD_MANA_REGEN_INTERRUPT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22782 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22782 #1 -- effect: APPLY_AURA, aura: MOD_MANA_REGEN_INTERRUPT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22783 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22783 #1 -- effect: APPLY_AURA, aura: MOD_MANA_REGEN_INTERRUPT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27125 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27125 #1 -- effect: APPLY_AURA, aura: MOD_MANA_REGEN_INTERRUPT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mage_armor" )
        end,
    },

-- Magic Absorption - Increases all resistances by 2/4/6/8/10 and causes all spells you fully resist to restore 0-5% of your total mana. 1 sec. cooldown.
    magic_absorption = {
        id = 29441,
        cast = 0,
        school = "arcane",
        texture = 136011,
        max_stack = 1,
        copy = { 29441, 29442, 29444, 29445, 29446, 29447 },

        -- Effects:
        -- [x] Rank 29441 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29441 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 29442 #0 -- effect: ENERGIZE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29444 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29444 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29445 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29445 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29446 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29446 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29447 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29447 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "magic_absorption" )
        end,

        proc_chance = 100,
        proc_category_recovery = 1,
        proc_type_mask = { 131072, 0 },
        -- Proc type flags: mask0: Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Mana Shield - Absorbs 120-715 damage, draining mana instead. Drains $e mana per damage absorbed. Lasts 60 sec.
    mana_shield = {
        id = 1463,
        cast = 0,
        duration = 60,
        gcd = "spell",
        school = "arcane",
        texture = 136153,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1463, 8494, 8495, 10191, 10192, 10193, 27131 },

        -- Effects:
        -- [x] Rank 1463 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8494 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 209, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8495 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 299, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10191 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 389, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10192 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 479, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10193 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 569, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27131 #0 -- effect: APPLY_AURA, aura: MANA_SHIELD, points: 714, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mana_shield" )
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Master of Elements - Your Fire and Frost spell criticals will refund 1/10/20/30% of their base mana cost.
    master_of_elements = {
        id = 29074,
        cast = 0,
        school = "fire",
        texture = 135820,
        range = 50000,
        max_stack = 1,
        copy = { 29074, 29075, 29076, 29077 },

        -- Effects:
        -- [x] Rank 29074 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29075 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29076 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 29077 #0 -- effect: ENERGIZE, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "master_of_elements" )
        end,

        proc_chance = 100,
        proc_category_recovery = 0.009,
        proc_type_mask = { 65536, 0 },
        -- Proc type flags: mask0: Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Molten Armor - Causes 75 Fire damage when hit, increases your chance to critically hit with spells by 3%, and reduces the chance you are critically hit by 5%. Only one type of Armor spell can be active on the Mage at any time. Lasts 1800 sec.
    molten_armor = {
        id = 30482,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "fire",
        texture = 132221,
        spend = 630,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 30482 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34913
        -- [x] Rank 30482 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30482 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_CRIT_CHANCE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "molten_armor" )
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Polymorph - Transforms the enemy into a sheep, forcing it to wander around for up to 20/30/40/50 sec. While wandering, the sheep cannot attack or cast spells but will regenerate very quickly. Any damage will transform the target back into its normal form. Only one target can be polymorphed at a time. Only works on Beasts, Humanoids and Critters.
    polymorph = {
        id = 118,
        cast = 1.5,
        duration = 50,
        gcd = "spell",
        school = "arcane",
        texture = 136071,
        range = 30,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 118, 12824, 12825, 12826, 28271, 28272 },

        -- Effects:
        -- [x] Rank 118 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 118 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12824 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12824 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12825 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12825 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12826 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12826 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28271 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28271 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28272 #0 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28272 #1 -- effect: APPLY_AURA, aura: TRANSFORM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "polymorph" )
        end,

        proc_chance = 100,
    },

-- Portal: Darnassus - Creates a portal, teleporting group members that use it to Darnassus.
    portal_darnassus = {
        id = 11419,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135741,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11419 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Portal: Exodar - Creates a portal, teleporting group members that use it to Exodar.
    portal_exodar = {
        id = 32266,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135742,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32266 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,

        proc_chance = 100,
    },

-- Portal: Ironforge - Creates a portal, teleporting group members that use it to Ironforge.
    portal_ironforge = {
        id = 11416,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135743,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11416 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Portal: Orgrimmar - Creates a portal, teleporting group members that use it to Orgrimmar.
    portal_orgrimmar = {
        id = 11417,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135744,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11417 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Portal: Shattrath - Creates a portal, teleporting group members that use it to Shattrath.
    portal_shattrath = {
        id = 33691,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135745,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,
        copy = { 33691, 35717 },

        -- Effects:
        -- [ ] Rank 33691 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 35717 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,

        proc_chance = 100,
    },

-- Portal: Silvermoon - Creates a portal, teleporting group members that use it to Silvermoon.
    portal_silvermoon = {
        id = 32267,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135746,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32267 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,

        proc_chance = 100,
    },

-- Portal: Stonard - Creates a portal, teleporting group members that use it to Stonard.
    portal_stonard = {
        id = 49361,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135747,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 49361 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,

        proc_chance = 100,
    },

-- Portal: Stormwind - Creates a portal, teleporting group members that use it to Stormwind.
    portal_stormwind = {
        id = 10059,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135748,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 10059 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Portal: Theramore - Creates a portal, teleporting group members that use it to Theramore.
    portal_theramore = {
        id = 49360,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135749,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 49360 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,

        proc_chance = 100,
    },

-- Portal: Thunder Bluff - Creates a portal, teleporting group members that use it to Thunder Bluff.
    portal_thunder_bluff = {
        id = 11420,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135750,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11420 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Portal: Undercity - Creates a portal, teleporting group members that use it to Undercity.
    portal_undercity = {
        id = 11418,
        cast = 10,
        duration = 60,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 135751,
        range = 10,
        spend = 850,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 11418 #0 -- effect: TRANS_DOOR, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 3,
    },

-- Presence of Mind - When activated, your next Mage spell with a casting time less than 10 sec becomes an instant cast spell.
    presence_of_mind = {
        id = 12043,
        cast = 0,
        cooldown = 180,
        category_cooldown = 1.5,
        school = "physical",
        texture = 136031,
        cooldown_category_id = 1151,
        cooldown_category = "Talent - DPS",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 12043 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "presence_of_mind" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Pyroblast - Hurls an immense fiery boulder that causes 141-939 Fire damage and an additional 56-356 Fire damage over 12 sec.
    pyroblast = {
        id = 11366,
        cast = 6,
        duration = 12,
        gcd = "spell",
        school = "fire",
        texture = 135808,
        range = 35,
        spend = function () return has_arcane_concentration() and 0 or 125 end,
        spendType = "Mana",
        max_stack = 1,
        copy = { 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938 },

        -- Effects:
        -- [x] Rank 11366 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 140, addl_points: 47, points_per_level: 1.9, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11366 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12505 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 179, addl_points: 57, points_per_level: 2.2, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12505 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12522 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 254, addl_points: 73, points_per_level: 2.6, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12522 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12523 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 328, addl_points: 91, points_per_level: 3, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12523 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12524 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 406, addl_points: 109, points_per_level: 3.4, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12524 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 38, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12525 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 502, addl_points: 129, points_per_level: 3.8, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12525 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 46, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12526 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 599, addl_points: 151, points_per_level: 4.2, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 12526 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 56, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18809 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 707, addl_points: 191, points_per_level: 4.6, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18809 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 66, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27132 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 845, addl_points: 229, points_per_level: 5, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27132 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 77, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33938 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 938, addl_points: 253, points_per_level: 5.4, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33938 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 88, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "pyroblast" )
            apply_ignite_stack()
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "pyroblast" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Remove Lesser Curse - Removes $m1 Curse from a friendly target.
    remove_lesser_curse = {
        id = 475,
        cast = 0,
        gcd = "spell",
        school = "arcane",
        texture = 136082,
        range = 40,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 475 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Ritual of Refreshment - Begins a ritual that creates a refreshment table. Raid members can click the table to acquire Conjured Manna Biscuits. The tables lasts for $43985d or 50 charges. Requires the caster and 2 additional party members to complete the ritual. In order to participate, all players must right-click the refreshment portal and not move until the ritual is complete.
    ritual_of_refreshment = {
        id = 43987,
        cast = 0,
        duration = 60,
        category_cooldown = 300,
        gcd = "spell",
        school = "arcane",
        texture = 135739,
        cooldown_category_id = 1177,
        cooldown_category = "Ritual of Souls/Refreshment",
        range = 30,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 43987 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 8, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 5,

        proc_chance = 100,
    },

-- Scorch - Scorch the enemy for 53-305 Fire damage.
    scorch = {
        id = 2948,
        cast = 1.5,
        gcd = "spell",
        school = "fire",
        texture = 135827,
        range = 30,
        spend = function () return has_arcane_concentration() and 0 or 50 end,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2948, 8444, 8445, 8446, 10205, 10206, 10207, 27073, 27074 },

        -- Effects:
        -- [x] Rank 2948 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 52, addl_points: 13, points_per_level: 0.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8444 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 76, addl_points: 17, points_per_level: 1.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8445 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 99, addl_points: 21, points_per_level: 1.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8446 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 132, addl_points: 27, points_per_level: 1.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10205 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 161, addl_points: 31, points_per_level: 1.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10206 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 199, addl_points: 40, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10207 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 232, addl_points: 43, points_per_level: 2.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27073 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 268, addl_points: 49, points_per_level: 2.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27074 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 304, addl_points: 57, points_per_level: 2.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            apply_ignite_stack()
            consume_arcane_concentration()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "scorch" ) end
        end,

        proc_chance = 100,
    },

-- Shoot - Attack with an equipped wand.
    shoot = {
        id = 5019,
        cast = 0,
        texture = 132317,
        cooldown_category_id = 351,
        cooldown_category = "Ranged Weapon",
        range = 30,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 5019 #0 -- effect: WEAPON_DAMAGE_NOSCHOOL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Slow - Reduces target's movement speed by 50%, increases the time between ranged attacks by 50% and increases casting time by 50%. Lasts 15 sec. Slow can only affect one target at a time.
    slow = {
        id = 31589,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "arcane",
        texture = 136091,
        range = 30,
        spend_pct = 20,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31589 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31589 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER_BY_SPELL_LABEL, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31589 #2 -- effect: APPLY_AURA, aura: HASTE_SPELLS, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "slow" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Slow Fall - Slows falling speed for 30 sec.
    slow_fall = {
        id = 130,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "arcane",
        texture = 135992,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 130 #0 -- effect: APPLY_AURA, aura: FEATHER_FALL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "slow_fall" )
        end,
    },

-- Summon Water Elemental - Summon a Water Elemental to fight for the caster for 45 sec.
    summon_water_elemental = {
        id = 31687,
        cast = 0,
        duration = 45,
        cooldown = 180,
        gcd = "spell",
        school = "frost",
        texture = 135862,
        spend_pct = function () return 16 * ( 1 + -0.05 * ( talent.frost_channeling.rank or 0 ) ) end,
        -- Talent spend scaling: frost_channeling (-5% per rank, frost school)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31687 #0 -- effect: SUMMON, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "water_elemental", 45 ) end
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Teleport: Darnassus - Teleports the caster to Darnassus.
    teleport_darnassus = {
        id = 3565,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135755,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3565 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3565 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Teleport: Exodar - Teleports the caster to Exodar.
    teleport_exodar = {
        id = 32271,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135756,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32271 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 32271 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Teleport: Ironforge - Teleports the caster to Ironforge.
    teleport_ironforge = {
        id = 3562,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135757,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3562 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3562 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Teleport: Orgrimmar - Teleports the caster to Orgrimmar.
    teleport_orgrimmar = {
        id = 3567,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135759,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3567 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3567 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Teleport: Shattrath - Teleports the caster to Shattrath.
    teleport_shattrath = {
        id = 33690,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135760,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,
        copy = { 33690, 35715 },

        -- Effects:
        -- [ ] Rank 33690 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 33690 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35715 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 35715 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Teleport: Silvermoon - Teleports the caster to Silvermoon.
    teleport_silvermoon = {
        id = 32272,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135761,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32272 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 32272 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Teleport: Stonard - Teleports the caster to Stonard.
    teleport_stonard = {
        id = 49358,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135762,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 49358 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 49358 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Teleport: Stormwind - Teleports the caster to Stormwind.
    teleport_stormwind = {
        id = 3561,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135763,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3561 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3561 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Teleport: Theramore - Teleports the caster to Theramore.
    teleport_theramore = {
        id = 49359,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135764,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 49359 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 49359 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Teleport: Thunder Bluff - Teleports the caster to Thunder Bluff.
    teleport_thunder_bluff = {
        id = 3566,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135765,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3566 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3566 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Teleport: Undercity - Teleports the caster to Undercity.
    teleport_undercity = {
        id = 3563,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135766,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3563 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
        -- [ ] Rank 3563 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

} )

-- Resources
spec:RegisterResource( "mana" )

if spec.RegisterRanges then
    spec:RegisterRanges( "fire_blast", "flamestrike", "frostbolt", "scorch", "fireball", "pyroblast" )
end

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    cycle = false,

    nameplates = false,
    nameplateRange = 40,
    rangeFilter = false,

    damage = true,
    damageDots = true,
    damageExpiration = 6,

    potion = "tempered_potion",

    package = "Mage",
} )

-- Settings
spec:RegisterSetting( "mage_arcane_header", false, {
    type = "header",
    name = "Arcane",
    width = "full",
} )

spec:RegisterSetting( "arcane_regen_start_mana", 20, {
    type = "range",
    name = "Arcane: Regen Start Mana",
    desc = "Start Arcane conservation behavior below this mana percentage.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "arcane_regen_bloodlust_start_mana", 10, {
    type = "range",
    name = "Arcane: Regen Start Mana (Bloodlust)",
    desc = "Start Arcane conservation behavior below this mana percentage while Bloodlust is active.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "arcane_regen_stop_mana", 30, {
    type = "range",
    name = "Arcane: Regen Stop Mana",
    desc = "Leave Arcane conservation behavior at or above this mana percentage.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "arcane_regen_missiles_min_stack", 3, {
    type = "range",
    name = "Arcane: Missiles Stack Threshold",
    desc = "Use Arcane Missiles during conservation when Arcane Blast stacks are at least this value.",
    width = "full",
    min = 1,
    max = 3,
    step = 1,
} )

spec:RegisterSetting( "mage_fire_header", false, {
    type = "header",
    name = "Fire",
    width = "full",
} )

spec:RegisterSetting( "fire_maintain_vulnerability_stacks", true, {
    type = "toggle",
    name = "Fire: Maintain Fire Vulnerability Stacks",
    desc = "When enabled, Scorch is used to build Fire Vulnerability stacks up to 5.",
    width = "full",
} )

spec:RegisterSetting( "fire_refresh_vulnerability", 5.5, {
    type = "range",
    name = "Fire: Refresh Fire Vulnerability",
    desc = "Refresh Fire Vulnerability with Scorch when remaining duration is below this threshold.",
    width = "full",
    min = 0,
    max = 30,
    step = 0.1,
} )

spec:RegisterSetting( "fire_flamestrike_aoe", 3, {
    type = "range",
    name = "Fire: Flamestrike Enemy Threshold",
    desc = "Use Flamestrike at or above this enemy count.",
    width = "full",
    min = 1,
    max = 10,
    step = 1,
} )

spec:RegisterSetting( "fire_blast_single_target", true, {
    type = "toggle",
    name = "Fire: Use Fire Blast in Single Target",
    desc = "When enabled, Fire Blast is used below the Flamestrike enemy threshold when off cooldown.",
    width = "full",
} )

spec:RegisterSetting( "mage_frost_header", false, {
    type = "header",
    name = "Frost",
    width = "full",
} )

spec:RegisterSetting( "frost_blizzard_aoe", 3, {
    type = "range",
    name = "Frost: Blizzard Enemy Threshold",
    desc = "Use Blizzard at or above this enemy count.",
    width = "full",
    min = 1,
    max = 10,
    step = 1,
} )

--[[
spec:RegisterSetting( "scaffold_strict_range", false, {
    name = "Scaffold: Strict Range Checks",
    desc = "If checked, this generated profile can use stricter range checks where supported.",
    type = "toggle",
    width = "full",
} )
]]--

-- Pets (Hekili-style scaffold)
spec:RegisterPet( "water_elemental", 31687, "summon_water_elemental", 45 )

spec:RegisterPack( "Arcane", 20260313, [[Hekili:9EvxVPnmu0)n8YqzqPRBtIG02BTp09qMuFZjoj3aw1X2Y2bwLq53(SDibYxaRfTxAISVFCUNCV3tbnh9BuqkwdONVB2DpmBX8fEZMD)S7NJc0VjauGaN8kET5fgo383FitWm3XVr54uR7kEHmXC0l8xci5kuqCbHQFKHIhm0lqb4c9gUefeuiajRqz8zdjnfQCbujOauaLO0kh8GmCbvBE9zhCbgoMcPOFIc4ct6bTjIjAcNHc2ILe7T23OfMh5yg2tKOlJwwgzmvtyRvEyxvekH1aluP5IqRDLrtkJIlYYQVpMIvApjKJjmvz0k)YOeZjHAso0YgxIdRyOwXwSbRaK2qbwKxOGqEww46KuBT0GA75eny5UJfNXPfNZjbV6zlpUVdbLinX1qjvUTfcbgKtGdfZIJr7aQH)iOCL9etW(YOb7iRAdZ1qRDt)YHYUGVdK2m)WOz(0ppoZ9keUeCRHKqckGLy5(WCcl1cRV(FJqijVfUfmDD20(TpyAXs9H8UF)Hg8ykNNslmD3)d0xJtNeZEFdRMhmO(7xbQ)4ZKlhFKCmGnF2OiRE9Hx)H4raIHjsE9CKworPiuqzBIcDw3dz1M4ax3vC3aWnklFoSLj5kDmNwrzU1xdsOT2)ODZnj88y8G7RhEoMW0aLcjAVu(ow)ArsOuc2ml6UVhoACVzp74zm3iLfIL5CzNyD8IMfVNBrRRu3cs3QYA9TzOGDyjZYZOGhZfCPgslJURAyNBQmNMMx5twAINrS6uvxP8A4Tp5)5Uf2usM)4e2KZqwLpnu8pwSnrUdXmSFvmr5tn3AoRURCQv9ZVFR5uUW309n1Ph7xp6V8cJ9tgDKFL)WZ7NIPg90PNiE6p)utQkLXVVREOLOAVYEL)IbCWPjznUUsx5FPsTDyx2kQDvH62julbo52KUgzNBxfC63ORlQ1sl733tQ6IL5qsuxdAE)9JlVC7yN1828EMD5dKk3Q5Xk5(lXpn3nRXFNzDeI58jTTarSj8P)Iv)BhkJEHVBdy(TdbkbKy)3BSBtr)9]] )
spec:RegisterPack( "Fire", 20260313, [[Hekili:vsvYUTnmq0)gFPbQEjjTfWoaThkqYH0dSa5gLhrnYMiuKcKuoWx03EjPqKOKLCsp4fmRV5XzE0v0)sj5GfPpVE567xUz1MKLlVD16nuI9Cfsjva7v4G7psO099V56GXZcfK7t2OQ1mNPxuVq4LgkjRMlSpkPztx41ucuBpQ0ucPUc1YAJlPJ88CSnh0WOekrWnwtaDybulSU)(CaT1gmvvuKEGL7TqaMLRKT25w0dbuczcmN(lQ11(RLuLQ93bzSXNX7rWuLz1MjI624O4SZPNqUCCZVZhuVfct7GOMdoEdTwU8GjPWXOPLaxADFspvlKOgY4cU9CQX6yFtZ(fn7ZXS6II2OheusiOM9BB2FxpGmmLMD0dH7NfcZxsn6bKju0HavJfA0CCy8t12VnBB9XEctrjwYrxpEy34MuiC7AgRM)kMckSV8ro8947Fs2ntagBQXzqGPwqFaTboDmsUyAhbKqsmLsKREtgvAhFb5rSqVhpk)r8II3vgied3tSUnrn6x1G(f9jhSWlgOzG0TTlTOqGmBIhpbWf7otZfcoizyWFpggNE3vY8DS0jbKc6sLEuT6DCXLZu3wHr9eQnEpVRmSKsEd0spTtjpwwP0wmVz)62hiLBYcIbjnp5EyRqM)HNKbgm)pUY)ZW04jqvbx0TSys6y0VS7RJh5B4f7MNkxCfAS5PPQFpn0v5ru2051Yrnp151zRti7MivRDRIdPnT593lAfBTtKk2y7fRh1)hksl(a1OT3nDl(qfNTFc1M4shDG6R)Wd6h2D9R5460DXEjtmH6XIHnA7v7ZIzvmgJGGWG)eH(V)]] )
spec:RegisterPack( "Frost", 20260313, [[Hekili:9jvtVnoiq0)n9Yw5nF1v9I7H9qLAoK9aRuVH9amofvmyb4uLEGF7lyRy741jxSrZW7npEZJUM(xkraEKEyZQn)A121BZwTA36NEMs8NBqkPb4FchJh0qD87RwJZNQEwzarcTZ0A5XoVBENiRDucRvQ8VPPSfzEhLaT(pmwkH02GwDRlI5dPqG9qqhNsOeL05DDQdRGwLpE8qNABDyHPQQ4ixKQqaUxA091LEmPaudmfkO)M6Jt)EGAm9)VcX2eIl3qYpxCcL650UlDPXkeUnoCRe6rEclqnwlrxO8L8qPd9EP(OlRk5FfmL87VbROam44OUunr)tt1qhiMjAcxPH0EWICtndgTNfLeRTQkdSCqh9iThvkK7ZeMV0HYhcLtBZSsLscAo21FueZHp4T3EI1XGtbyRn2zCn24)87L2iDp1tO1L6CjoTIs(cS6KRsjVv3ySEuek3ek7Pku2fHYc7t2KPsQgSAx2GV9J8Fo)H9OSk)2g2d3XSc7xI)Xh7aZZmMLX17eH9dDJ1gc5pojrNVE6v6HD7(db6PfVe9sk8687l53j7oLIjHug4qXFIlXxL2OP7Aqo9WZDRr6)(]] )

