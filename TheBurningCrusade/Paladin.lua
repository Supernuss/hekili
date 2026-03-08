-- Paladin.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Paladin (#2)

if UnitClassBase( "player" ) ~= "PALADIN" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 2 )

local function clear_paladin_seals()
    removeBuff( "seal_of_blood" )
    removeBuff( "seal_of_command" )
    removeBuff( "seal_of_corruption" )
    removeBuff( "seal_of_justice" )
    removeBuff( "seal_of_light" )
    removeBuff( "seal_of_righteousness" )
    removeBuff( "seal_of_the_crusader" )
    removeBuff( "seal_of_the_martyr" )
    removeBuff( "seal_of_vengeance" )
    removeBuff( "seal_of_wisdom" )
end

local function consume_paladin_seal()
    clear_paladin_seals()
end

local function clear_paladin_auras()
    removeBuff( "concentration_aura" )
    removeBuff( "devotion_aura" )
    removeBuff( "fire_resistance_aura" )
    removeBuff( "frost_resistance_aura" )
    removeBuff( "retribution_aura" )
    removeBuff( "sanctity_aura" )
    removeBuff( "shadow_resistance_aura" )
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
    anticipation = { 1629, 5, 20096, 20097, 20098, 20099, 20100 },
    ardent_defender = { 1751, 5, 31850, 31851, 31852, 31853, 31854 },
    aura_mastery = { 1435, 1, 31821 },
    avengers_shield = { 1754, 1, 31935 },
    benediction = { 1407, 5, 20101, 20102, 20103, 20104, 20105 },
    blessed_life = { 1744, 3, 31828, 31829, 31830 },
    blessing_of_kings = { 1442, 1, 20217 },
    blessing_of_sanctuary = { 1431, 1, 20911 },
    combat_expertise = { 1753, 5, 31858, 31859, 31860, 31861, 31862 },
    conviction = { 1411, 5, 20117, 20118, 20119, 20120, 20121 },
    crusade = { 1755, 3, 31866, 31867, 31868 },
    crusader_strike = { 1823, 1, 35395 },
    deflection = { 1403, 5, 20060, 20061, 20062, 20063, 20064 },
    divine_favor = { 1433, 1, 20216 },
    divine_illumination = { 1747, 1, 31842 },
    divine_intellect = { 1449, 5, 20257, 20258, 20259, 20260, 20261 },
    divine_purpose = { 1757, 3, 31871, 31872, 31873 },
    divine_strength = { 1450, 5, 20262, 20263, 20264, 20265, 20266 },
    eye_for_an_eye = { 1632, 2, 9799, 25988 },
    fanaticism = { 1759, 5, 31879, 31880, 31881, 31882, 31883 },
    guardians_favor = { 1425, 2, 20174, 20175 },
    healing_light = { 1444, 3, 20237, 20238, 20239 },
    holy_guidance = { 1746, 5, 31837, 31838, 31839, 31840, 31841 },
    holy_power = { 1627, 5, 5923, 5924, 5925, 5926, 25829 },
    holy_shield = { 1430, 1, 20925 },
    holy_shock = { 1502, 1, 20473 },
    illumination = { 1461, 5, 20210, 20212, 20213, 20214, 20215 },
    improved_blessing_of_might = { 1401, 5, 20042, 20045, 20046, 20047, 20048 },
    improved_blessing_of_wisdom = { 1446, 2, 20244, 20245 },
    improved_concentration_aura = { 1626, 3, 20254, 20255, 20256 },
    improved_devotion_aura = { 1422, 5, 20138, 20139, 20140, 20141, 20142 },
    improved_hammer_of_justice = { 1521, 3, 20487, 20488, 20489 },
    improved_holy_shield = { 1829, 2, 41021, 41026 },
    improved_judgement = { 1631, 2, 25956, 25957 },
    improved_lay_on_hands = { 1443, 2, 20234, 20235 },
    improved_retribution_aura = { 1405, 2, 20091, 20092 },
    improved_righteous_fury = { 1501, 3, 20468, 20469, 20470 },
    improved_sanctity_aura = { 1756, 2, 31869, 31870 },
    improved_seal_of_righteousness = { 1463, 5, 20224, 20225, 20330, 20331, 20332 },
    improved_seal_of_the_crusader = { 1464, 3, 20335, 20336, 20337 },
    lights_grace = { 1745, 3, 31833, 31835, 31836 },
    one_handed_weapon_specialization = { 1429, 5, 20196, 20197, 20198, 20199, 20200 },
    precision = { 1630, 3, 20189, 20192, 20193 },
    pure_of_heart = { 1742, 3, 31822, 31823, 31824 },
    purifying_power = { 1743, 2, 31825, 31826 },
    pursuit_of_justice = { 1634, 3, 26022, 26023, 44414 },
    reckoning = { 1426, 5, 20177, 20179, 20181, 20180, 20182 },
    redoubt = { 1421, 5, 20127, 20130, 20135, 20136, 20137 },
    repentance = { 1441, 1, 20066 },
    sacred_duty = { 1750, 2, 31848, 31849 },
    sanctified_judgement = { 1758, 3, 31876, 31877, 31878 },
    sanctified_light = { 1465, 3, 20359, 20360, 20361 },
    sanctified_seals = { 1761, 3, 32043, 35396, 35397 },
    sanctity_aura = { 1409, 1, 20218 },
    seal_of_command = { 1481, 1, 20375 },
    shield_specialization = { 1424, 3, 20148, 20149, 20150 },
    spell_warding = { 1749, 2, 31846, 31847 },
    spiritual_focus = { 1432, 5, 20205, 20206, 20207, 20209, 20208 },
    stoicism = { 1748, 2, 31844, 31845 },
    toughness = { 1423, 5, 20143, 20144, 20145, 20146, 20147 },
    two_handed_weapon_specialization = { 1410, 3, 20111, 20112, 20113 },
    unyielding_faith = { 1628, 2, 9453, 25836 },
    vengeance = { 1402, 5, 20049, 20056, 20057, 20058, 20059 },
    vindication = { 1633, 3, 9452, 26016, 26021 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    arcane_torrent = {
        id = 28730,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    avengers_shield = {
        id = 31935,
        duration = 6,
        max_stack = 1,
        copy = { 31935, 32699, 32700 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    avenging_wrath = {
        id = 31884,
        duration = 20,
        max_stack = 1,
        -- Aura effects: MOD_DAMAGE_PERCENT_DONE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blessing_of_freedom = {
        id = 1044,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blessing_of_kings = {
        id = 20217,
        duration = 600,
        max_stack = 1,
        -- Aura effects: MOD_TOTAL_STAT_PERCENTAGE
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blessing_of_light = {
        id = 19977,
        duration = 600,
        max_stack = 1,
        copy = { 19977, 19978, 19979, 27144 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blessing_of_might = {
        id = 19740,
        duration = 600,
        max_stack = 1,
        copy = { 19740, 19834, 19835, 19836, 19837, 19838, 25291, 27140 },
        -- Aura effects: MOD_ATTACK_POWER, MOD_RANGED_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blessing_of_protection = {
        id = 1022,
        duration = 10,
        max_stack = 1,
        copy = { 1022, 5599, 10278 },
        -- Aura effects: MOD_PACIFY, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    blessing_of_sacrifice = {
        id = 6940,
        duration = 30,
        max_stack = 1,
        copy = { 6940, 20729, 27147, 27148 },
        -- Aura effects: SPLIT_DAMAGE_FLAT
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    blessing_of_salvation = {
        id = 1038,
        duration = 600,
        max_stack = 1,
        -- Aura effects: MOD_THREAT
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    blessing_of_sanctuary = {
        id = 20911,
        duration = 600,
        max_stack = 1,
        copy = { 20911, 20912, 20913, 20914, 27168 },
        -- Aura effects: MOD_DAMAGE_TAKEN, PROC_TRIGGER_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blessing_of_wisdom = {
        id = 19742,
        duration = 600,
        max_stack = 1,
        copy = { 19742, 19850, 19852, 19853, 19854, 25290, 27142 },
        -- Aura effects: MOD_POWER_REGEN
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blood_corruption = {
        id = 356110,
        duration = 15,
        tick_time = 3,
        max_stack = 5,
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    divine_favor = {
        id = 20216,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    divine_illumination = {
        id = 31842,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_POWER_COST_SCHOOL_PCT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    divine_protection = {
        id = 498,
        duration = 8,
        max_stack = 1,
        copy = { 498, 5573 },
        -- Aura effects: MOD_PACIFY, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    divine_shield = {
        id = 642,
        duration = 12,
        max_stack = 1,
        copy = { 642, 1020 },
        -- Aura effects: MOD_MELEE_HASTE, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    eye_for_an_eye = {
        id = 9799,
        max_stack = 1,
        copy = { 9799, 25988, 25997 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    greater_blessing_of_kings = {
        id = 25898,
        duration = 1800,
        max_stack = 1,
        -- Aura effects: MOD_TOTAL_STAT_PERCENTAGE
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    greater_blessing_of_light = {
        id = 25890,
        duration = 1800,
        max_stack = 1,
        copy = { 25890, 27145 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    greater_blessing_of_might = {
        id = 25782,
        duration = 1800,
        max_stack = 1,
        copy = { 25782, 25916, 27141 },
        -- Aura effects: MOD_ATTACK_POWER, MOD_RANGED_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    greater_blessing_of_salvation = {
        id = 25895,
        duration = 1800,
        max_stack = 1,
        -- Aura effects: MOD_THREAT
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    greater_blessing_of_sanctuary = {
        id = 25899,
        duration = 1800,
        max_stack = 1,
        copy = { 25899, 27169 },
        -- Aura effects: MOD_DAMAGE_TAKEN, PROC_TRIGGER_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    greater_blessing_of_wisdom = {
        id = 25894,
        duration = 1800,
        max_stack = 1,
        copy = { 25894, 25918, 27143 },
        -- Aura effects: MOD_POWER_REGEN
        -- Aura targets: TARGET_UNIT_TARGET_AREA_RAID_CLASS
    },

    hammer_of_justice = {
        id = 853,
        duration = 6,
        max_stack = 1,
        copy = { 853, 5588, 5589, 10308 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    holy_shield = {
        id = 20925,
        duration = 10,
        max_stack = 1,
        copy = { 20925, 27179 },
        -- Aura effects: MOD_BLOCK_PERCENT, MOD_RATING, PROC_TRIGGER_DAMAGE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    holy_vengeance = {
        id = 31803,
        duration = 15,
        tick_time = 3,
        max_stack = 5,
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    judgement_of_justice = {
        id = 20184,
        duration = 20,
        max_stack = 1,
        copy = { 20184, 31896 },
        -- Aura effects: PREVENTS_FLEEING, USE_NORMAL_MOVEMENT_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    judgement_of_light = {
        id = 20185,
        duration = 20,
        max_stack = 1,
        copy = { 20185, 20344, 20345, 20346, 27162 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    judgement_of_the_crusader = {
        id = 20188,
        duration = 20,
        max_stack = 1,
        copy = { 20188, 20300, 20301, 20302, 20303, 21183, 27159 },
        -- Aura effects: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, MOD_DAMAGE_TAKEN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    judgement_of_wisdom = {
        id = 20186,
        duration = 20,
        max_stack = 1,
        copy = { 20186, 20354, 20355, 27164 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    lights_grace = {
        id = 31833,
        duration = 15,
        max_stack = 1,
        copy = { 31833, 31834, 31835, 31836 },
        -- Aura effects: ADD_FLAT_MODIFIER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    repentance = {
        id = 20066,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    righteous_fury = {
        id = 25780,
        duration = 1800,
        max_stack = 1,
        copy = { 25780, 25781 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, MOD_THREAT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_blood = {
        id = 31892,
        duration = 30,
        max_stack = 1,
        copy = { 31892, 31893 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_command = {
        id = 20375,
        duration = 30,
        max_stack = 1,
        copy = { 20375, 27170 },
        -- Aura effects: DUMMY, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_corruption = {
        id = 348704,
        duration = 30,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_justice = {
        id = 20164,
        duration = 30,
        max_stack = 1,
        copy = { 20164, 31895 },
        -- Aura effects: DUMMY, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_light = {
        id = 20165,
        duration = 30,
        max_stack = 1,
        copy = { 20165, 20347, 20348, 20349, 27160 },
        -- Aura effects: DUMMY, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_righteousness = {
        id = 20154,
        duration = 30,
        max_stack = 1,
        copy = { 20154, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 21084, 27155 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_the_crusader = {
        id = 20162,
        duration = 30,
        max_stack = 1,
        copy = { 20162, 20305, 20306, 20307, 20308, 21082, 27158 },
        -- Aura effects: DUMMY, MOD_ATTACK_POWER, MOD_ATTACKSPEED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_the_martyr = {
        id = 348700,
        duration = 30,
        max_stack = 1,
        copy = { 348700, 348701 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_vengeance = {
        id = 31801,
        duration = 30,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seal_of_wisdom = {
        id = 20166,
        duration = 30,
        max_stack = 1,
        copy = { 20166, 20356, 20357, 27166 },
        -- Aura effects: DUMMY, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    sense_undead = {
        id = 5502,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    summon_charger = {
        id = 23214,
        max_stack = 1,
        copy = { 23214, 34767 },
        -- Aura effects: MOD_INCREASE_MOUNTED_SPEED, MOUNTED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    summon_warhorse = {
        id = 13819,
        max_stack = 1,
        copy = { 13819, 34769 },
        -- Aura effects: MOD_INCREASE_MOUNTED_SPEED, MOUNTED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    turn_evil = {
        id = 10326,
        duration = 20,
        max_stack = 1,
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    turn_undead = {
        id = 2878,
        duration = 15,
        max_stack = 1,
        copy = { 2878, 5627 },
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    vindication = {
        id = 67,
        duration = 15,
        max_stack = 1,
        copy = { 67, 9452, 26016, 26017, 26018, 26021 },
        -- Aura effects: MOD_TOTAL_STAT_PERCENTAGE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
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

-- Avenger's Shield - Hurls a holy shield at the enemy, dealing 270/370/494 Holy damage, Dazing them and then jumping to additional nearby enemies. Affects $x1 total targets. Lasts 6 sec.
    avengers_shield = {
        id = 31935,
        cast = 1,
        duration = 6,
        category_cooldown = 30,
        gcd = "spell",
        school = "holy",
        texture = 135874,
        cooldown_category_id = 1158,
        cooldown_category = "Intercept",
        range = 30,
        spend = 500,
        spendType = "Mana",
        max_stack = 1,
        copy = { 31935, 32699, 32700 },

        -- Effects:
        -- [x] Rank 31935 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 269, addl_points: 61, points_per_level: 0, sp_bonus: 0.193, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31935 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 32699 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 369, addl_points: 83, points_per_level: 0, sp_bonus: 0.193, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32699 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 32700 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 493, addl_points: 109, points_per_level: 0, sp_bonus: 0.193, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32700 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "avengers_shield" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "avengers_shield" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Avenging Wrath - Increases all damage caused by 30% for 20 sec. Causes Forebearance, preventing the use of Divine Shield, Divine Protection, Blessing of Protection again for $25771d.
    avenging_wrath = {
        id = 31884,
        cast = 0,
        duration = 20,
        cooldown = 180,
        school = "holy",
        texture = 135875,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31884 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "avenging_wrath" )
        end,

        proc_chance = 100,

        -- Aura restrictions: exclude_caster_state=17
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

-- Blessing of Freedom - Places a Blessing on the friendly target, granting immunity to movement impairing effects for 10 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_freedom = {
        id = 1044,
        cast = 0,
        duration = 10,
        cooldown = 25,
        gcd = "spell",
        school = "holy",
        texture = 135968,
        range = 30,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1044 #0 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1044 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_freedom" )
        end,
    },

-- Blessing of Kings - Places a Blessing on the friendly target, increasing total stats by 10% for 600 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_kings = {
        id = 20217,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135995,
        range = 30,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 20217 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_STAT_PERCENTAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_kings" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Blessing of Light - Places a Blessing on the friendly target, increasing the effects of Holy Light spells used on the target by up to 210/300/400/580 and the effects of Flash of Light spells used on the target by up to 60/85/115/185. Lasts 600 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_light = {
        id = 19977,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135943,
        range = 30,
        spend = 85,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19977, 19978, 19979, 27144 },

        -- Effects:
        -- [x] Rank 19977 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 209, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19977 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19978 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 299, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19978 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19979 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19979 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27144 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 579, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27144 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_light" )
        end,
    },

-- Blessing of Might - Places a Blessing on the friendly target, increasing attack power by 20-220 for 600 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_might = {
        id = 19740,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135906,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19740, 19834, 19835, 19836, 19837, 19838, 25291, 27140 },

        -- Effects:
        -- [x] Rank 19740 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19740 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19834 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19834 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19835 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19835 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19836 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19836 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19837 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19837 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19838 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19838 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25291 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25291 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27140 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 219, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27140 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 219, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_might" )
        end,
    },

-- Blessing of Protection - A targeted party member is protected from all physical attacks for 6/8/10 sec, but during that time they cannot attack or use physical abilities. Players may only have one Blessing on them per Paladin at any one time. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection again for $25771d.
    blessing_of_protection = {
        id = 1022,
        cast = 0,
        duration = 10,
        category_cooldown = 300,
        gcd = "spell",
        school = "holy",
        texture = 135964,
        cooldown_category_id = 20,
        cooldown_category = "Invulnerability (Other)",
        range = 30,
        spend = 25,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1022, 5599, 10278 },

        -- Effects:
        -- [ ] Rank 1022 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 1022 #1 -- effect: APPLY_AURA, aura: MOD_PACIFY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 5599 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 5599 #1 -- effect: APPLY_AURA, aura: MOD_PACIFY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10278 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10278 #1 -- effect: APPLY_AURA, aura: MOD_PACIFY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,

        -- Aura restrictions: exclude_target_aura_spell=25771

        usable = function ()
            return ( not debuff.forbearance or not debuff.forbearance.up )
        end,
    },

-- Blessing of Sacrifice - Places a Blessing on the party member, transfering 45/55/81/104 damage taken per hit to the caster. Lasts 30 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_sacrifice = {
        id = 6940,
        cast = 0,
        duration = 30,
        category_cooldown = 30,
        gcd = "spell",
        school = "holy",
        texture = 135966,
        cooldown_category_id = 1186,
        cooldown_category = "Blessing of Sacrifice",
        range = 30,
        spend = 80,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6940, 20729, 27147, 27148 },

        -- Effects:
        -- [ ] Rank 6940 #0 -- effect: APPLY_AURA, aura: SPLIT_DAMAGE_FLAT, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 20729 #0 -- effect: APPLY_AURA, aura: SPLIT_DAMAGE_FLAT, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 27147 #0 -- effect: APPLY_AURA, aura: SPLIT_DAMAGE_FLAT, points: 80, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 27148 #0 -- effect: APPLY_AURA, aura: SPLIT_DAMAGE_FLAT, points: 103, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Blessing of Salvation - Places a Blessing on the party member, reducing the amount of all threat generated by 30% for 600 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_salvation = {
        id = 1038,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135967,
        range = 30,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1038 #0 -- effect: APPLY_AURA, aura: MOD_THREAT, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,
    },

-- Blessing of Sanctuary - Places a Blessing on the friendly target, reducing damage dealt from all sources by up to 10/14/19/24/80 for 600 sec. In addition, when the target blocks a melee attack the attacker will take 14/21/28/35/46 Holy damage. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_sanctuary = {
        id = 20911,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 136051,
        range = 30,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20911, 20912, 20913, 20914, 27168 },

        -- Effects:
        -- [x] Rank 20911 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20911 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20912 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -15, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20912 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20913 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20913 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 27, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20914 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -25, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 20914 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27168 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -81, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27168 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 45, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_sanctuary" )
        end,

        proc_chance = 100,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Blessing of Wisdom - Places a Blessing on the friendly target, restoring 10-41 mana every 5 seconds for 600 sec. Players may only have one Blessing on them per Paladin at any one time.
    blessing_of_wisdom = {
        id = 19742,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135970,
        range = 30,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19742, 19850, 19852, 19853, 19854, 25290, 27142 },

        -- Effects:
        -- [x] Rank 19742 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19850 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19852 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19853 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 19854 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25290 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27142 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 40, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessing_of_wisdom" )
        end,
    },

-- Blood Corruption - 30 Holy damage every $t1 sec.
    blood_corruption = {
        id = 356110,
        cast = 0,
        duration = 15,
        school = "holy",
        texture = 135969,
        range = 100,
        max_stack = 5,

        -- Effects:
        -- [x] Rank 356110 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0.034, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if debuff.blood_corruption.up then
                applyDebuff( "target", "blood_corruption", nil, min( debuff.blood_corruption.max_stack, debuff.blood_corruption.stack + 1 ) )
            else
                applyDebuff( "target", "blood_corruption", nil, 1 )
            end
        end,
    },

-- Cleanse - Cleanses a friendly target, removing 1 poison effect, 1 disease effect, and 1 magic effect.
    cleanse = {
        id = 4987,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135953,
        range = 40,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 4987 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 4987 #1 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 4987 #2 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Concentration Aura - Gives a 35% chance of ignoring spell interruption when damaged to all party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    concentration_aura = {
        id = 19746,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135933,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19746 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: REDUCE_PUSHBACK, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19746 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MECHANIC_DURATION_MOD_NOT_STACK, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19746 #2 -- effect: APPLY_AREA_AURA_PARTY, aura: MECHANIC_DURATION_MOD_NOT_STACK, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "concentration_aura" )
        end,

        radius = 30,
    },

-- Consecration - Consecrates the land beneath the Paladin, doing 64-512 Holy damage over 8 sec to enemies who enter the area.
    consecration = {
        id = 20116,
        cast = 0,
        duration = 8,
        category_cooldown = 8,
        gcd = "spell",
        school = "holy",
        texture = 135926,
        cooldown_category_id = 932,
        cooldown_category = "Consecration",
        spend = 205,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20116, 20922, 20923, 20924, 26573, 27173 },

        -- Effects:
        -- [ ] Rank 20116 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 20922 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 20923 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 20924 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 47, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 26573 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 27173 #0 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 63, addl_points: 1, points_per_level: 0, sp_bonus: 0.119, radius_idx: 14, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,
    },

-- Crusader Aura - Increases the mounted speed by 20% for all party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time. This does not stack with other movement speed increasing effects.
    crusader_aura = {
        id = 32223,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135890,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32223 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_MOUNTED_SPEED_NOT_STACK, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 32223 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_FLIGHT_SPEED_NOT_STACK, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 30,

        proc_chance = 100,
    },

-- Crusader Strike - An instant strike that causes 110% weapon damage and refreshes all Judgements on the target.
    crusader_strike = {
        id = 35395,
        cast = 0,
        cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 135891,
        range = 5,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 35395 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 35395 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Devotion Aura - Gives 55-861 additional armor to party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    devotion_aura = {
        id = 465,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135893,
        max_stack = 1,
        copy = { 465, 643, 1032, 10290, 10291, 10292, 10293, 27149 },

        -- Effects:
        -- [ ] Rank 465 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 643 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 1032 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 504, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10290 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10291 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 389, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10292 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 619, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10293 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 734, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27149 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE, points: 860, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "devotion_aura" )
        end,

        radius = 30,
    },

-- Divine Favor - When activated, gives your next Flash of Light, Holy Light, or Holy Shock spell a 10% critical effect chance.
    divine_favor = {
        id = 20216,
        cast = 0,
        cooldown = 120,
        school = "holy",
        texture = 135915,
        spend_pct = 3,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 20216 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "divine_favor" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 81920, 0 },
        -- Proc type flags: mask0: Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Divine Illumination - Reduces the mana cost of all spells by 50% for 15 sec.
    divine_illumination = {
        id = 31842,
        cast = 0,
        duration = 15,
        cooldown = 180,
        school = "holy",
        texture = 135895,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31842 #0 -- effect: APPLY_AURA, aura: MOD_POWER_COST_SCHOOL_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "divine_illumination" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Divine Intervention - The paladin sacrifices $ghimself:herself; to remove the targeted party member from harms way. Enemies will stop attacking the protected party member, who will be immune to all harmful attacks but cannot take any action for $19753d.
    divine_intervention = {
        id = 19752,
        cast = 0,
        cooldown = 3600,
        gcd = "spell",
        school = "holy",
        texture = 136106,
        range = 40,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19752 #0 -- effect: SANCTUARY, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 19752 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0, trigger_spell_id: 19753
        -- [ ] Rank 19752 #2 -- effect: INSTAKILL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Divine Protection - You are protected from all physical attacks and spells for 6/8 sec, but during that time you cannot attack or use physical abilities yourself. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection again for $25771d.
    divine_protection = {
        id = 498,
        cast = 0,
        duration = 8,
        category_cooldown = 300,
        gcd = "spell",
        school = "holy",
        texture = 135954,
        cooldown_category_id = 37,
        cooldown_category = "Invulnerability",
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 498, 5573 },

        -- Effects:
        -- [x] Rank 498 #0 -- effect: APPLY_AURA, aura: MOD_PACIFY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 498 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 498 #2 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5573 #0 -- effect: APPLY_AURA, aura: MOD_PACIFY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5573 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5573 #2 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "divine_protection" )
        end,

        -- Aura restrictions: exclude_caster_state=17
    },

-- Divine Shield - Protects the paladin from all damage and spells for 10/12 sec, but increases the time between your attacks by 100%. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection, Blessing of Protection again or use Avenging Wrath for $25771d.
    divine_shield = {
        id = 642,
        cast = 0,
        duration = 12,
        category_cooldown = 300,
        gcd = "spell",
        school = "holy",
        texture = 135896,
        cooldown_category_id = 37,
        cooldown_category = "Invulnerability",
        spend = 75,
        spendType = "Mana",
        max_stack = 1,
        copy = { 642, 1020 },

        -- Effects:
        -- [x] Rank 642 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 642 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 642 #2 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1020 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1020 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1020 #2 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "divine_shield" )
        end,

        -- Aura restrictions: exclude_caster_state=17
    },

-- Exorcism - Causes 84-619 Holy damage to an Undead or Demon target.
    exorcism = {
        id = 879,
        cast = 0,
        category_cooldown = 15,
        gcd = "spell",
        school = "holy",
        texture = 135903,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 30,
        spend = 70,
        spendType = "Mana",
        max_stack = 1,
        copy = { 879, 5614, 5615, 10312, 10313, 10314, 27138 },

        -- Effects:
        -- [x] Rank 879 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 83, addl_points: 13, points_per_level: 1.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5614 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 151, addl_points: 21, points_per_level: 1.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5615 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 216, addl_points: 29, points_per_level: 2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10312 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 303, addl_points: 39, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10313 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 392, addl_points: 47, points_per_level: 2.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10314 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 504, addl_points: 59, points_per_level: 3.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27138 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 618, addl_points: 73, points_per_level: 3.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "exorcism" ) end
        end,

        proc_chance = 100,
    },

-- Eye for an Eye - All spell criticals against you cause 1/15/30% of the damage taken to the caster as well. The damage caused by Eye for an Eye will not exceed 50% of the Paladin's total health.
    eye_for_an_eye = {
        id = 9799,
        cast = 0,
        texture = 135904,
        range = 100,
        max_stack = 1,
        copy = { 9799, 25988, 25997 },

        -- Effects:
        -- [x] Rank 9799 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25988 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25997 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "eye_for_an_eye" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "eye_for_an_eye" ) end
        end,

        proc_chance = 100,
        proc_type_mask = { 131072, 0 },
        -- Proc type flags: mask0: Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Fire Resistance Aura - Gives 30/45/60/70 additional Fire resistance to all party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    fire_resistance_aura = {
        id = 19891,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135824,
        max_stack = 1,
        copy = { 19891, 19899, 19900, 27153 },

        -- Effects:
        -- [ ] Rank 19891 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19899 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19900 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27153 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "fire_resistance_aura" )
        end,

        radius = 30,
    },

-- Flash of Light - Heals a friendly target for 62-448.
    flash_of_light = {
        id = 19750,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135907,
        range = 40,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19750, 19939, 19940, 19941, 19942, 19943, 27137 },

        -- Effects:
        -- [ ] Rank 19750 #0 -- effect: HEAL, aura: NONE, points: 61, addl_points: 11, points_per_level: 1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 19939 #0 -- effect: HEAL, aura: NONE, points: 95, addl_points: 15, points_per_level: 1.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 19940 #0 -- effect: HEAL, aura: NONE, points: 144, addl_points: 19, points_per_level: 1.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 19941 #0 -- effect: HEAL, aura: NONE, points: 196, addl_points: 25, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 19942 #0 -- effect: HEAL, aura: NONE, points: 266, addl_points: 33, points_per_level: 2.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 19943 #0 -- effect: HEAL, aura: NONE, points: 342, addl_points: 41, points_per_level: 2.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27137 #0 -- effect: HEAL, aura: NONE, points: 447, addl_points: 55, points_per_level: 2.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Frost Resistance Aura - Gives 30/45/60/70 additional Frost resistance to all party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    frost_resistance_aura = {
        id = 19888,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135865,
        max_stack = 1,
        copy = { 19888, 19897, 19898, 27152 },

        -- Effects:
        -- [ ] Rank 19888 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19897 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19898 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27152 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "frost_resistance_aura" )
        end,

        radius = 30,
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

-- Greater Blessing of Kings - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Kings, increasing total stats by 10% for 1800 sec. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_kings = {
        id = 25898,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135993,
        range = 40,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 25898 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_STAT_PERCENTAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,
    },

-- Greater Blessing of Light - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Light, increasing the effects of Holy Light spells used on the target by up to 400/580 and the effects of Flash of Light spells used on the target by up to 115/185. Lasts 1800 sec. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_light = {
        id = 25890,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135909,
        range = 40,
        spend = 260,
        spendType = "Mana",
        max_stack = 1,
        copy = { 25890, 27145 },

        -- Effects:
        -- [ ] Rank 25890 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25890 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27145 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 579, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27145 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Greater Blessing of Might - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Might, increasing attack power by 155/185/220 for 1800 sec. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_might = {
        id = 25782,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135908,
        range = 40,
        spend = 220,
        spendType = "Mana",
        max_stack = 1,
        copy = { 25782, 25916, 27141 },

        -- Effects:
        -- [ ] Rank 25782 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25782 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25916 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25916 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27141 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 219, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27141 #1 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 219, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,
    },

-- Greater Blessing of Salvation - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Salvation, reducing the amount of all threat generated by 30% for 1800 sec. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_salvation = {
        id = 25895,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135910,
        range = 40,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 25895 #0 -- effect: APPLY_AURA, aura: MOD_THREAT, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,
    },

-- Greater Blessing of Sanctuary - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Sanctuary, reducing damage dealt from all sources by up to 24/80 for 1800 sec. In addition, when the target blocks a melee attack the attacker will take 35/46 Holy damage. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_sanctuary = {
        id = 25899,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135911,
        range = 40,
        spend = 270,
        spendType = "Mana",
        max_stack = 1,
        copy = { 25899, 27169 },

        -- Effects:
        -- [ ] Rank 25899 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -25, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25899 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27169 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: -81, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27169 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 45, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,

        proc_chance = 100,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Greater Blessing of Wisdom - Gives all members of the raid or group that share the same class with the target the Greater Blessing of Wisdom, restoring 30/33/41 mana every 5 seconds for 1800 sec. Players may only have one Blessing on them per Paladin at any one time.
    greater_blessing_of_wisdom = {
        id = 25894,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135912,
        range = 40,
        spend = 230,
        spendType = "Mana",
        max_stack = 1,
        copy = { 25894, 25918, 27143 },

        -- Effects:
        -- [ ] Rank 25894 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 25918 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0
        -- [ ] Rank 27143 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 40, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_AREA_RAID_CLASS, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
        end,
    },

-- Hammer of Justice - Stuns the target for 3/4/5/6 sec.
    hammer_of_justice = {
        id = 853,
        cast = 0,
        duration = 6,
        cooldown = function () return max( 0, 60 + -5 * ( talent.improved_hammer_of_justice.rank or 0 ) ) end,
        category_cooldown = 60,
        gcd = "spell",
        school = "holy",
        texture = 135963,
        cooldown_category_id = 32,
        cooldown_category = "Stun",
        range = 10,
        spend = 30,
        -- Talent cooldown scaling (category source): improved_hammer_of_justice (-5s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 853, 5588, 5589, 10308 },

        -- Effects:
        -- [x] Rank 853 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5588 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5589 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10308 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "hammer_of_justice" )
        end,

        proc_chance = 100,
    },

-- Hammer of Wrath - Hurls a hammer that strikes an enemy for 304/399/504/665 Holy damage. Only usable on enemies that have 20% or less health.
    hammer_of_wrath = {
        id = 24239,
        cast = 0.5,
        category_cooldown = 6,
        gcd = "spell",
        school = "holy",
        texture = 132326,
        cooldown_category_id = 1131,
        cooldown_category = "Hammer of Vengeance",
        range = 30,
        spend = 340,
        spendType = "Mana",
        max_stack = 1,
        copy = { 24239, 24274, 24275, 27180 },

        -- Effects:
        -- [x] Rank 24239 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 503, addl_points: 53, points_per_level: 3.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24274 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 398, addl_points: 43, points_per_level: 2.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24275 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 303, addl_points: 33, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27180 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 664, addl_points: 71, points_per_level: 3.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "hammer_of_wrath" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: target_state=2
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

-- Holy Light - Heals a friendly target for 39-2196.
    holy_light = {
        id = 635,
        cast = 2.5,
        gcd = "spell",
        school = "holy",
        texture = 135920,
        range = 40,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 635, 639, 647, 1026, 3472, 10328, 10329, 25292, 27135, 27136 },

        -- Effects:
        -- [ ] Rank 635 #0 -- effect: HEAL, aura: NONE, points: 38, addl_points: 9, points_per_level: 0.8, sp_bonus: 0.205, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 639 #0 -- effect: HEAL, aura: NONE, points: 75, addl_points: 15, points_per_level: 1.1, sp_bonus: 0.339, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 647 #0 -- effect: HEAL, aura: NONE, points: 158, addl_points: 29, points_per_level: 1.7, sp_bonus: 0.554, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 1026 #0 -- effect: HEAL, aura: NONE, points: 309, addl_points: 47, points_per_level: 2.4, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 3472 #0 -- effect: HEAL, aura: NONE, points: 697, addl_points: 83, points_per_level: 3.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10328 #0 -- effect: HEAL, aura: NONE, points: 944, addl_points: 109, points_per_level: 4.6, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10329 #0 -- effect: HEAL, aura: NONE, points: 1245, addl_points: 143, points_per_level: 5.2, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25292 #0 -- effect: HEAL, aura: NONE, points: 1589, addl_points: 181, points_per_level: 5.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27135 #0 -- effect: HEAL, aura: NONE, points: 1740, addl_points: 199, points_per_level: 6.4, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27136 #0 -- effect: HEAL, aura: NONE, points: 2195, addl_points: 251, points_per_level: 7, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Holy Shield - Increases chance to block by 30% for 10 sec and deals 59/155 Holy damage for each attack blocked while active. Damage caused by Holy Shield causes 35% additional threat. Each block expends a charge. $n charges.
    holy_shield = {
        id = 20925,
        cast = 0,
        duration = 10,
        category_cooldown = 10,
        gcd = "spell",
        school = "holy",
        texture = 135880,
        cooldown_category_id = 931,
        cooldown_category = "Holy Shield",
        spend = 135,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20925, 27179 },

        -- Effects:
        -- [x] Rank 20925 #0 -- effect: APPLY_AURA, aura: MOD_BLOCK_PERCENT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20925 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 58, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20925 #2 -- effect: APPLY_AURA, aura: MOD_RATING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27179 #0 -- effect: APPLY_AURA, aura: MOD_BLOCK_PERCENT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27179 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_DAMAGE, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 0.05, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27179 #2 -- effect: APPLY_AURA, aura: MOD_RATING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "holy_shield" )
        end,

        proc_chance = 100,
        proc_charges = 4,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Holy Shock - Blasts the target with Holy energy, causing 277 Holy damage to an enemy, or 351 healing to an ally.
    holy_shock = {
        id = 20473,
        cast = 0,
        category_cooldown = 15,
        gcd = "spell",
        school = "holy",
        texture = 135972,
        cooldown_category_id = 892,
        cooldown_category = "Holy Shock",
        range = 20,
        spend = 335,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20473, 20929, 20930, 25902, 25903, 25911, 25912, 25913, 25914, 27174, 27175, 27176, 33072, 33073, 33074 },

        -- Effects:
        -- [ ] Rank 20473 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 20929 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 20930 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 25902 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 495, addl_points: 41, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25903 #0 -- effect: HEAL, aura: NONE, points: 627, addl_points: 53, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25911 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 378, addl_points: 31, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25912 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 276, addl_points: 23, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25913 #0 -- effect: HEAL, aura: NONE, points: 479, addl_points: 39, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25914 #0 -- effect: HEAL, aura: NONE, points: 350, addl_points: 29, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27174 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 27175 #0 -- effect: HEAL, aura: NONE, points: 776, addl_points: 65, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27176 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 613, addl_points: 51, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33072 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 33073 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 720, addl_points: 59, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33074 #0 -- effect: HEAL, aura: NONE, points: 912, addl_points: 75, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "holy_shock" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Holy Vengeance - 30 Holy damage every $t1 sec.
    holy_vengeance = {
        id = 31803,
        cast = 0,
        duration = 15,
        school = "holy",
        texture = 135969,
        range = 100,
        max_stack = 5,

        -- Effects:
        -- [x] Rank 31803 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0.034, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if debuff.holy_vengeance.up then
                applyDebuff( "target", "holy_vengeance", nil, min( debuff.holy_vengeance.max_stack, debuff.holy_vengeance.stack + 1 ) )
            else
                applyDebuff( "target", "holy_vengeance", nil, 1 )
            end
        end,
    },

-- Holy Wrath - Sends bolts of holy power in all directions, causing 362/490/635 Holy damage to all Undead and Demon targets within $a1 yds.
    holy_wrath = {
        id = 2812,
        cast = 2,
        category_cooldown = 60,
        gcd = "spell",
        school = "holy",
        texture = 135902,
        cooldown_category_id = 35,
        cooldown_category = "Direct Damage (AE) - Spell",
        spend = 550,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2812, 10318, 27139 },

        -- Effects:
        -- [x] Rank 2812 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 361, addl_points: 67, points_per_level: 1.6, sp_bonus: 0.286, radius_idx: 9, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 10318 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 489, addl_points: 87, points_per_level: 1.9, sp_bonus: 0.286, radius_idx: 9, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27139 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 634, addl_points: 111, points_per_level: 2.2, sp_bonus: 0.286, radius_idx: 9, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 20,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "holy_wrath" ) end
        end,

        proc_chance = 100,
    },

-- Judgement - Unleashes the energy of a Seal spell upon an enemy. Refer to individual Seals for Judgement effect.
    judgement = {
        id = 20271,
        cast = 0,
        cooldown = function () return max( 0, 10 + -1 * ( talent.improved_judgement.rank or 0 ) ) end,
        school = "holy",
        texture = 135959,
        range = 10,
        spend_pct = 5,
        -- Talent cooldown scaling: improved_judgement (-1s per rank)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 20271 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            consume_paladin_seal()
        end,

        -- Aura restrictions: caster_state=5
    },

-- Judgement of Blood - Unleashing this Seal's energy will judge an enemy, instantly causing 295 Holy damage at the cost of health equal to 33% of the damage caused.
    judgement_of_blood = {
        id = 31898,
        cast = 0,
        school = "holy",
        texture = 136168,
        range = 50000,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31898 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 294, addl_points: 31, points_per_level: 6.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "judgement_of_blood" ) end
        end,
    },

-- Judgement of Corruption
    judgement_of_corruption = {
        id = 356112,
        cast = 0,
        school = "holy",
        texture = 135969,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 356112 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "judgement_of_corruption" ) end
        end,

        proc_chance = 100,
    },

-- Judgement of Justice - Cannot flee.
    judgement_of_justice = {
        id = 20184,
        cast = 0,
        duration = 20,
        school = "holy",
        texture = 135971,
        range = 100,
        max_stack = 1,
        copy = { 20184, 31896 },

        -- Effects:
        -- [x] Rank 20184 #0 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31896 #0 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31896 #1 -- effect: APPLY_AURA, aura: USE_NORMAL_MOVEMENT_SPEED, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            applyDebuff( "target", "judgement_of_justice" )
        end,
    },

-- Judgement of Light - Melee attacks made against you have a chance of causing the attacker to be healed for 25.
    judgement_of_light = {
        id = 20185,
        cast = 0,
        duration = 20,
        school = "holy",
        texture = 135917,
        range = 100,
        max_stack = 1,
        copy = { 20185, 20344, 20345, 20346, 27162 },

        -- Effects:
        -- [x] Rank 20185 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5373
        -- [x] Rank 20344 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5373
        -- [x] Rank 20345 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5373
        -- [x] Rank 20346 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5373
        -- [x] Rank 27162 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5373
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            applyDebuff( "target", "judgement_of_light" )
        end,

        proc_chance = 50,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Judgement of Righteousness
    judgement_of_righteousness = {
        id = 20187,
        cast = 0,
        school = "holy",
        texture = 132325,
        range = 100,
        max_stack = 1,
        copy = { 20187, 20280, 20281, 20282, 20283, 20284, 20285, 20286, 27157 },

        -- Effects:
        -- [x] Rank 20187 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 14, addl_points: 1, points_per_level: 1.8, sp_bonus: 0.209, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20187 #1 -- effect: DUMMY, aura: NONE, points: 107, addl_points: 1, points_per_level: 18, sp_bonus: 0.058, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20280 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 3, points_per_level: 1.9, sp_bonus: 0.455, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20280 #1 -- effect: DUMMY, aura: NONE, points: 215, addl_points: 1, points_per_level: 17, sp_bonus: 0.125, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20281 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 38, addl_points: 5, points_per_level: 2.4, sp_bonus: 0.674, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20281 #1 -- effect: DUMMY, aura: NONE, points: 351, addl_points: 1, points_per_level: 23, sp_bonus: 0.185, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20282 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 56, addl_points: 7, points_per_level: 2.8, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20282 #1 -- effect: DUMMY, aura: NONE, points: 540, addl_points: 1, points_per_level: 31, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20283 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 77, addl_points: 9, points_per_level: 3.1, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20283 #1 -- effect: DUMMY, aura: NONE, points: 784, addl_points: 1, points_per_level: 37, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20284 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 101, addl_points: 11, points_per_level: 3.8, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20284 #1 -- effect: DUMMY, aura: NONE, points: 1081, addl_points: 1, points_per_level: 41, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20285 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 130, addl_points: 13, points_per_level: 4.1, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20285 #1 -- effect: DUMMY, aura: NONE, points: 1406, addl_points: 1, points_per_level: 47, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 20286 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 161, addl_points: 17, points_per_level: 4.1, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20286 #1 -- effect: DUMMY, aura: NONE, points: 1785, addl_points: 1, points_per_level: 47, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 27157 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 207, addl_points: 21, points_per_level: 4.4, sp_bonus: 0.728, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27157 #2 -- effect: DUMMY, aura: NONE, points: 2453, addl_points: 1, points_per_level: 53, sp_bonus: 0.2, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "judgement_of_righteousness" ) end
        end,
    },

-- Judgement of the Crusader - Increases Holy damage taken by up to 23-219.
    judgement_of_the_crusader = {
        id = 20188,
        cast = 0,
        duration = 20,
        school = "holy",
        texture = 135924,
        range = 100,
        max_stack = 1,
        copy = { 20188, 20300, 20301, 20302, 20303, 21183, 27159 },

        -- Effects:
        -- [x] Rank 20188 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20188 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20300 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 57, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20300 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20301 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 91, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20301 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20302 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 126, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20302 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20303 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 160, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20303 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 21183 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 22, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 21183 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27159 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 218, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27159 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            applyDebuff( "target", "judgement_of_the_crusader" )
        end,
    },

-- Judgement of Vengeance
    judgement_of_vengeance = {
        id = 31804,
        cast = 0,
        school = "holy",
        texture = 135969,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31804 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "judgement_of_vengeance" ) end
        end,

        proc_chance = 100,
    },

-- Judgement of Wisdom - Attacks and spells used against you have a chance of restoring 33 of the attacker's mana.
    judgement_of_wisdom = {
        id = 20186,
        cast = 0,
        duration = 20,
        school = "holy",
        texture = 135960,
        range = 100,
        max_stack = 1,
        copy = { 20186, 20354, 20355, 27164 },

        -- Effects:
        -- [x] Rank 20186 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1826
        -- [x] Rank 20354 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1826
        -- [x] Rank 20355 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1826
        -- [x] Rank 27164 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1826
        startsCombat = true,

        handler = function ()
            consume_paladin_seal()
            applyDebuff( "target", "judgement_of_wisdom" )
        end,

        proc_chance = 50,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Justicebringer 2000 Specs
    justicebringer_2000_specs = {
        id = 41311,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41311 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Justicebringer 3000 Specs
    justicebringer_3000_specs = {
        id = 46107,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46107 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Lay on Hands - Heals a friendly target for an amount equal to the Paladin's maximum health. Drains all of the Paladin's remaining mana when used.
    lay_on_hands = {
        id = 633,
        cast = 0,
        cooldown = function () return max( 0, 3600 + -600 * ( talent.improved_lay_on_hands.rank or 0 ) ) end,
        category_cooldown = 3600,
        gcd = "spell",
        school = "holy",
        texture = 135928,
        cooldown_category_id = 56,
        cooldown_category = "Instant Heal - Spell",
        range = 40,
        -- Talent cooldown scaling (category source): improved_lay_on_hands (-600s per rank)
        max_stack = 1,
        copy = { 633, 2800, 10310, 27154 },

        -- Effects:
        -- [ ] Rank 633 #0 -- effect: HEAL_MAX_HEALTH, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 2800 #0 -- effect: HEAL_MAX_HEALTH, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 2800 #1 -- effect: ENERGIZE, aura: NONE, points: 249, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10310 #0 -- effect: HEAL_MAX_HEALTH, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10310 #1 -- effect: ENERGIZE, aura: NONE, points: 549, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27154 #0 -- effect: HEAL_MAX_HEALTH, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 27154 #1 -- effect: ENERGIZE, aura: NONE, points: 899, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Light's Grace - Gives your Holy Light spell a $h% chance to reduce the cast time of your next Holy Light spell by $/1000;31834S1 sec. This effect lasts $31834d.
    lights_grace = {
        id = 31833,
        cast = 0,
        duration = 15,
        texture = 135931,
        max_stack = 1,
        copy = { 31833, 31834, 31835, 31836 },

        -- Effects:
        -- [x] Rank 31833 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31834
        -- [x] Rank 31834 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: -501, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31835 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31834
        -- [x] Rank 31836 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31834

        handler = function ()
            applyBuff( "lights_grace" )
        end,

        proc_chance = 33,
        proc_type_mask = { 16384, 0 },
        -- Proc type flags: mask0: Deal Helpful Spell

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

-- Purify - Purifies the friendly target, removing 1 disease effect and 1 poison effect.
    purify = {
        id = 1152,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135949,
        range = 40,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1152 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 1152 #1 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Redemption - Brings a dead player back to life with 65/150/250/400/600 health and $q1 mana. Cannot be cast when in combat.
    redemption = {
        id = 7328,
        cast = 10,
        gcd = "spell",
        school = "holy",
        texture = 135955,
        range = 30,
        spend_pct = 64,
        spendType = "Mana",
        max_stack = 1,
        copy = { 7328, 10322, 10324, 20772, 20773 },

        -- Effects:
        -- [ ] Rank 7328 #0 -- effect: 329, aura: NONE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10322 #0 -- effect: 329, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10324 #0 -- effect: 329, aura: NONE, points: 249, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20772 #0 -- effect: 329, aura: NONE, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20773 #0 -- effect: 329, aura: NONE, points: 599, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
    },

-- Repentance - Puts the enemy target in a state of meditation, incapacitating them for up to 6 sec. Any damage caused will awaken the target. Only works against Humanoids.
    repentance = {
        id = 20066,
        cast = 0,
        duration = 6,
        cooldown = 60,
        gcd = "spell",
        school = "holy",
        texture = 135942,
        range = 20,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 20066 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "repentance" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Retribution Aura - Causes 5-26 Holy damage to any creature that strikes a party member within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    retribution_aura = {
        id = 7294,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135873,
        max_stack = 1,
        copy = { 7294, 10298, 10299, 10300, 10301, 27150 },

        -- Effects:
        -- [ ] Rank 7294 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10298 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10299 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10300 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 15, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10301 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27150 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DAMAGE_SHIELD, points: 25, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "retribution_aura" )
        end,

        radius = 30,
    },

-- Righteous Defense - Come to the defense of a friendly target, commanding up to 3 enemies attacking the target to attack the Paladin instead.
    righteous_defense = {
        id = 31789,
        cast = 0,
        cooldown = 15,
        gcd = "spell",
        school = "holy",
        texture = 135068,
        range = 40,
        spend_pct = 4,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 31789 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 8, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 31789 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31980

        radius = 5,

        proc_chance = 100,
    },

-- Righteous Fury - Increases the threat generated by your Holy spells by 1/60%. Lasts 1800 sec.
    righteous_fury = {
        id = 25780,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135962,
        range = 50000,
        spend_pct = 24,
        spendType = "Mana",
        max_stack = 1,
        copy = { 25780, 25781 },

        -- Effects:
        -- [x] Rank 25780 #0 -- effect: APPLY_AURA, aura: MOD_THREAT, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25780 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 25781 #0 -- effect: THREAT, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "righteous_fury" )
        end,

        proc_chance = 100,
    },

-- Sanctity Aura - Increases Holy damage done by party members within $a1 yards by 10%. Players may only have one Aura on them per Paladin at any one time.
    sanctity_aura = {
        id = 20218,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135934,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 20218 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_DAMAGE_PERCENT_DONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 20218 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_DAMAGE_PERCENT_DONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "sanctity_aura" )
        end,

        radius = 30,

        -- Related talents:
        -- talent_0 [0]
    },

-- Seal of Blood - All melee attacks deal additional Holy damage equal to 35% of normal weapon damage, but the Paladin loses health equal to 10% of the total damage inflicted. Unleashing this Seal's energy will judge an enemy, instantly causing 295 Holy damage at the cost of health equal to 33% of the damage caused.
    seal_of_blood = {
        id = 31892,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135961,
        range = 50000,
        spend = 210,
        spendType = "Mana",
        max_stack = 1,
        copy = { 31892, 31893 },

        -- Effects:
        -- [x] Rank 31892 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31892 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 31897, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31892 #2 -- effect: APPLY_AURA, aura: DUMMY, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 31893 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_blood" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Seal of Command - Gives the Paladin a chance to deal additional Holy damage equal to 70% of normal weapon damage. Only one Seal can be active on the Paladin at any one time. Lasts 30 sec. Unleashing this Seal's energy will judge an enemy, instantly causing $/2;20467s1 Holy damage, 93 if the target is stunned or incapacitated.
    seal_of_command = {
        id = 20375,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 132347,
        spend = 65,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20375, 27170 },

        -- Effects:
        -- [x] Rank 20375 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20424
        -- [x] Rank 20375 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20424, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27170 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20424
        -- [x] Rank 27170 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 27171, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_command" )
        end,

        proc_chance = 100,
        proc_category_recovery = 1,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing

        -- Related talents:
        -- talent_0 [0]
    },

-- Seal of Corruption - Fills the Paladin with holy power, granting each melee attack a chance to apply Blood Corruption, which deals $31803o1 additional Holy damage over $31803d. Blood Corruption can stack up to $31803u times. Only one Seal can be active on the Paladin at any one time. Lasts 30 sec. Unleashing this Seal's energy will judge an enemy, instantly causing 120 Holy damage for each application of Blood Corruption on the target.
    seal_of_corruption = {
        id = 348704,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135969,
        spend = 250,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 348704 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 348704 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 356112, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_corruption" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Seal of Justice - Fills the Paladin with the spirit of justice for 30 sec, giving each melee attack a chance to stun for $20170d. Only one Seal can be active on the Paladin at any one time. Unleashing this Seal's energy will judge an enemy for $20184d, preventing them from fleeing. Your melee strikes will refresh the spell's duration. Only one Judgement per Paladin can be active at any one time.
    seal_of_justice = {
        id = 20164,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135971,
        spend_pct = 10,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20164, 31895 },

        -- Effects:
        -- [x] Rank 20164 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20170
        -- [x] Rank 20164 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20183, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31895 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20170
        -- [x] Rank 31895 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 31895, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_justice" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability
    },

-- Seal of Light - Fills the Paladin with divine light for 30 sec, giving each melee attack a chance to heal the Paladin for 39. Only one Seal can be active on the Paladin at any one time. Unleashing this Seal's energy will judge an enemy for $20185d, granting melee attacks made against the judged enemy a chance of healing the attacker for 25. Your melee strikes will refresh the spell's duration. Only one Judgement per Paladin can be active at any one time.
    seal_of_light = {
        id = 20165,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135917,
        spend = 110,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20165, 20347, 20348, 20349, 27160 },

        -- Effects:
        -- [x] Rank 20165 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20167
        -- [x] Rank 20165 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20184, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20347 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20333
        -- [x] Rank 20347 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20343, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20348 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20334
        -- [x] Rank 20348 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20344, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20349 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20340
        -- [x] Rank 20349 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20345, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27160 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 27161
        -- [x] Rank 27160 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 27161, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_light" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability
    },

-- Seal of Righteousness - Fills the Paladin with holy spirit for 30 sec, granting each melee attack an additional ${$cond($eq($HND,1),0.85*($m1*1.2*1.03*$MWS/100)+0.03*($MW+$mw)/2-1,1.2*($m1*1.2*1.03*$MWS/100)+0.03*($MW+$mw)/2+1)} Holy damage. Only one Seal can be active on the Paladin at any one time.
    seal_of_righteousness = {
        id = 20154,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 132325,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20154, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 21084, 27155 },

        -- Effects:
        -- [x] Rank 20154 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 107, addl_points: 1, points_per_level: 18, sp_bonus: 0.029, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20287 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 215, addl_points: 1, points_per_level: 17, sp_bonus: 0.063, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20287 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20279, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20288 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 351, addl_points: 1, points_per_level: 23, sp_bonus: 0.093, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20288 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20280, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20289 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 540, addl_points: 1, points_per_level: 31, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20289 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20281, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20290 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 784, addl_points: 1, points_per_level: 37, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20290 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20282, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20291 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 1081, addl_points: 1, points_per_level: 41, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20291 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20283, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20292 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 1406, addl_points: 1, points_per_level: 47, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20292 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20284, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20293 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 1785, addl_points: 1, points_per_level: 47, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20293 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20285, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 21084 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 107, addl_points: 1, points_per_level: 18, sp_bonus: 0.029, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 21084 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20186, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27155 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 2111, addl_points: 1, points_per_level: 53, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27155 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 27156, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_righteousness" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Seal of the Crusader - Fills the Paladin with the spirit of a crusader for 30 sec, granting 36-474 melee attack power. The Paladin also attacks 40% faster, but deals less damage with each attack. Only one Seal can be active on the Paladin at any one time. Unleashing this Seal's energy will judge an enemy for $20188d, increasing Holy damage taken by up to 35. Your melee strikes will refresh the spell's duration. Only one Judgement per Paladin can be active at any one time.
    seal_of_the_crusader = {
        id = 20162,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135924,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20162, 20305, 20306, 20307, 20308, 21082, 27158 },

        -- Effects:
        -- [x] Rank 20162 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 58, addl_points: 1, points_per_level: 1.1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20162 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20187, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20162 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20305 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 107, addl_points: 1, points_per_level: 1.7, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20305 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20299, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20305 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20306 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 166, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20306 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20300, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20306 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20307 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 253, addl_points: 1, points_per_level: 2.2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20307 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20301, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20307 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20308 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 351, addl_points: 1, points_per_level: 2.4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20308 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20302, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20308 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 21082 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 35, addl_points: 1, points_per_level: 0.7, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 21082 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 21182, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 21082 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27158 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 473, addl_points: 1, points_per_level: 2.6, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27158 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 27158, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27158 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKSPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_the_crusader" )
        end,
    },

-- Seal of the Martyr - All melee attacks deal additional Holy damage equal to 35% of normal weapon damage, but the Paladin loses health equal to 10% of the total damage inflicted. Unleashing this Seal's energy will judge an enemy, instantly causing 295 Holy damage at the cost of health equal to 33% of the damage caused.
    seal_of_the_martyr = {
        id = 348700,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135961,
        range = 50000,
        spend = 210,
        spendType = "Mana",
        max_stack = 1,
        copy = { 348700, 348701 },

        -- Effects:
        -- [x] Rank 348700 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 348700 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 348702, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 348700 #2 -- effect: APPLY_AURA, aura: DUMMY, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 348701 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_the_martyr" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Seal of Vengeance - Fills the Paladin with holy power, granting each melee attack a chance to cause $31803o1 Holy damage over $31803d. This effect can stack up to $31803u times. Only one Seal can be active on the Paladin at any one time. Lasts 30 sec. Unleashing this Seal's energy will judge an enemy, instantly causing 120 Holy damage per application of Holy Vengeance.
    seal_of_vengeance = {
        id = 31801,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135969,
        spend = 250,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31801 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31801 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 31803, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_vengeance" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Seal of Wisdom - Fills the Paladin with divine wisdom for 30 sec, giving each melee attack a chance to restore 50 of the Paladin's mana. Only one Seal can be active on the Paladin at any one time. Unleashing this Seal's energy will judge an enemy for $20186d, granting attacks and spells used against the judged enemy a chance to restore 33 mana to the attacker. Your melee strikes will refresh the spell's duration. Only one Judgement per Paladin can be active at any one time.
    seal_of_wisdom = {
        id = 20166,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "holy",
        texture = 135960,
        spend = 135,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20166, 20356, 20357, 27166 },

        -- Effects:
        -- [x] Rank 20166 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20168
        -- [x] Rank 20166 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20185, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20356 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20350
        -- [x] Rank 20356 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20353, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20357 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 20351
        -- [x] Rank 20357 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 20354, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27166 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 27167
        -- [x] Rank 27166 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 27163, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_seals()
            applyBuff( "seal_of_wisdom" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability
    },

-- Sense Undead - Shows the location of all nearby undead on the minimap until cancelled. Only one form of tracking can be active at a time.
    sense_undead = {
        id = 5502,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135974,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5502 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "sense_undead" )
        end,
    },

-- Shadow Resistance Aura - Gives 30/45/60/70 additional Shadow resistance to all party members within $a1 yards. Players may only have one Aura on them per Paladin at any one time.
    shadow_resistance_aura = {
        id = 19876,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 136192,
        max_stack = 1,
        copy = { 19876, 19895, 19896, 27151 },

        -- Effects:
        -- [ ] Rank 19876 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19895 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19896 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27151 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_paladin_auras()
            applyBuff( "shadow_resistance_aura" )
        end,

        radius = 30,
    },

-- Summon Charger - Summons a Charger, which serves as a mount. Speed is increased by 100%.
    summon_charger = {
        id = 23214,
        cast = 3,
        gcd = "spell",
        school = "holy",
        texture = 132226,
        spend = 150,
        spendType = "Mana",
        max_stack = 1,
        copy = { 23214, 34767 },

        -- Effects:
        -- [x] Rank 23214 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23214 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23214 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34767 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34767 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34767 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "summon_charger" )
        end,

        proc_chance = 100,
    },

-- Summon Warhorse - Summons a warhorse, which serves as a mount. Speed is increased by 60%.
    summon_warhorse = {
        id = 13819,
        cast = 3,
        gcd = "spell",
        school = "holy",
        texture = 136103,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,
        copy = { 13819, 34769 },

        -- Effects:
        -- [x] Rank 13819 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 13819 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 13819 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34769 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34769 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34769 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "summon_warhorse" )
        end,

        proc_chance = 100,
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

-- Turn Evil - The targeted undead or demon enemy will be compelled to flee for up to 20 sec. Damage caused may interrupt the effect. Only one target can be turned at a time.
    turn_evil = {
        id = 10326,
        cast = 1.5,
        duration = 20,
        category_cooldown = 30,
        gcd = "spell",
        school = "holy",
        texture = 135983,
        cooldown_category_id = 33,
        cooldown_category = "Mez",
        range = 20,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 10326 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10326 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "turn_evil" )
        end,

        proc_chance = 100,
    },

-- Turn Undead - The targeted undead enemy will be compelled to flee for up to 10/15 sec. Damage caused may interrupt the effect. Only one target can be turned at a time.
    turn_undead = {
        id = 2878,
        cast = 1.5,
        duration = 15,
        category_cooldown = 30,
        gcd = "spell",
        school = "holy",
        texture = 135983,
        cooldown_category_id = 33,
        cooldown_category = "Mez",
        range = 20,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2878, 5627 },

        -- Effects:
        -- [x] Rank 2878 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2878 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5627 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5627 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "turn_undead" )
        end,

        proc_chance = 100,
    },

-- Vindication - All attributes reduced by -15/-10/-5/0%.
    vindication = {
        id = 67,
        cast = 0,
        duration = 15,
        school = "holy",
        texture = 135985,
        range = 100,
        max_stack = 1,
        copy = { 67, 9452, 26016, 26017, 26018, 26021 },

        -- Effects:
        -- [x] Rank 67 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_STAT_PERCENTAGE, points: -6, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9452 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 67
        -- [x] Rank 26016 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26017
        -- [x] Rank 26017 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_STAT_PERCENTAGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26018 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_STAT_PERCENTAGE, points: -16, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26021 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26018

        handler = function ()
            applyDebuff( "target", "vindication" )
            applyBuff( "vindication" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

} )

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "mana" )
end

spec:RegisterRanges( "holy_shock", "avengers_shield", "exorcism", "hammer_of_wrath", "blood_corruption", "eye_for_an_eye" )

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

    package = "Retribution\ \(LightClub\)",
} )

spec:RegisterStateExpr( "wowsim_paladin_prot_apply_sow_jow_ready", function()
    if debuff.judgement_of_wisdom.down and cooldown.judgement_of_wisdom.remains == 0 and buff.seal_of_wisdom.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_prot_apply_sow_jow_wait", function()
    if debuff.judgement_of_wisdom.down and buff.seal_of_wisdom.down and cooldown.judgement_of_wisdom.remains > 0 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_prot_swap_to_sor", function()
    if buff.seal_of_wisdom.down and buff.seal_of_righteousness.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_prot_judge_sor", function()
    if buff.seal_of_righteousness.up then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_prot_exorcism_mana", function()
    if mana.pct > 40 then return 1 end
    return 0
end )

spec:RegisterStateExpr( "wowsim_paladin_ret_jotc_setup", function()
    if debuff.judgement_of_the_crusader.down and buff.seal_of_command.up then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_seal_command_low", function()
    if mana.current <= 1000 and buff.seal_of_command.down and buff.seal_of_blood.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_judgement_blood_low", function()
    if mana.current <= 1000 and buff.seal_of_blood.remains < 1 and buff.seal_of_command.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_seal_blood_low", function()
    if mana.current <= 1000 and buff.seal_of_command.down and buff.seal_of_blood.remains < 1 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_crusader_strike_low", function()
    if mana.current <= 1000 and buff.seal_of_command.down and buff.seal_of_blood.up then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_seal_command_window", function()
    if mana.current > 1000 and buff.seal_of_command.down and buff.seal_of_blood.up and cooldown.crusader_strike.remains > gcd.remains then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_judgement_blood_window", function()
    if mana.current > 1000 and buff.seal_of_blood.up and buff.seal_of_command.down and cooldown.crusader_strike.remains > gcd.remains then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_crusader_strike_high", function()
    if mana.current > 1000 and buff.seal_of_command.down and ( buff.seal_of_blood.up or buff.seal_of_command.up ) then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_seal_blood_from_command", function()
    if mana.current > 1000 and buff.seal_of_command.up then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_seal_blood_missing", function()
    if mana.current > 1000 and buff.seal_of_blood.down and buff.seal_of_command.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_exorcism_window", function()
    if mana.current > 1000 and buff.seal_of_command.down and cooldown.crusader_strike.remains > gcd.remains and mana.pct > 40 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_paladin_ret_consecration_window", function()
    if mana.current > 1000 and buff.seal_of_command.down and cooldown.crusader_strike.remains > gcd.remains and mana.pct > 60 then return 1 end
    return 0
end )

--[[
spec:RegisterSetting( "scaffold_strict_range", false, {
    name = "Scaffold: Strict Range Checks",
    desc = "If checked, this generated profile can use stricter range checks where supported.",
    type = "toggle",
    width = "full",
} )
]]--

spec:RegisterPack( "Retribution (WoWSims)", 20230222.1, [[Hekili:1IvtVrokt4Fl5sRjAh5(JKjZ(UA65WE6DYHrRwVNTnTnTnBBmwaozAPi)BFl8NGBWjDNokkjwuq98qrrrvvW6G)jWpbjXb)CZQn3TAZMnERVF16vRd8LhlXb(LO4dOu4Jcef(7FJLCYUkjHvOKDmNHsu6qWQ4XG8mPSu8hlxMsKzv78Iz0LpZEwqOc4)Y8dl3LZ2TKIesmFjm8YsuokHuSKpQ4LCMeP(WlLf4VRIKl)rrWoRefqUehddcqtssWTZdlInOAD0F1ctDuVURJ2Z41r)F8bsojWpNiKIgJbEpQkxcF(ZgJdUaTlhNe8Nb(XCcWAckW)M6ibwkjfPcVmgpKII5mrD0I6O08JLzECC8bwbi3RB9nY(uDucEx1(9EsoIOehMurPh9QkRJE5L6iqVO0uoRo62aFuCRvodvKeY2hoOZa)kbggzFyACIIMs1(3fxBWtGr5EjSNlA4HsZpHdXfykbd0EBD06r8uZvH3t4IumQaovb9F37r)F3Q(bFdkS1uA)EL27LJuaRSnpZrYmDuHz(f9zwYA)VXmEqFgkdfquQyYK(68Bhtkahp6NgukMR4Fl9aL976iMb3A4GpjojefhJZXCKfs()CIpysqEGkIXfY6OVP5O9VvjPykmCd4ercJgkZ4yrglpzKawMMcX1R0zPXKYjPzYjeCTBNFGqH7yfvcpjbZxVkCtz8uFOeYtKcCOqY4TO72)e85Pmy2PoDDAeatR9OPDcXScboU12AC(OlOb57moDMC6nztFVtwcxDLiEkw6reHjyQkaI6g74GvfjyeCp)w77JTgHmYp2saBhGJsB40xUaxLoZFzogzdbnXnq8GtiM)M8jNYFv3whZReOeWAlG4WhWtT1g3Am00Kj6(UY5EO0g6ndhI4T3oq8MqVGOc8VKHLCcfXpgIKn70bZz)4IC4XWrsJ)fJhtenB9nRMZbFgp3lg9Po6BCFJ9JCF7(I9zC64Y5FJ7NDgi5Eg8AsriI98LCgBSfnc0ODjPxbXm4Ae8iNxVfaENNcpK3EX4HXDX(CKiBm0Q6h)s49BgDh61tTOdTHDOccj8BiQIJAJUieK0c1tmWiEAPo1mWiporYSzkCbqdoHQOpTEHta3ISztK4sGVpeZeKngUp)IRfOj4Nyw2UMd3NQY1c09eogYauaPPQsjBc2wL2Nl0vJcqkUYz4GvXZMR1fqcrgcUb6MfoK3NL2ztdy2a(9jN0tL(r96)qDx)GALJm5urZM33vIe02C5SrcAxSOUub)izHaS8YkiUQDMmkE(mnVsSPljyRuzib5My0pbPURMsxnMa18H3pkApy)bTKXLQs520MFN6bTM6g9QFe0ELekfmW3VcsjdYowOc5Z2tYX9iREqT7nGFB7YPXM)mz)2BQkxy)QWI5d5x)Onionc8zbYPl3bm6HBppe0xPDLBew9SuUXkTRCBXnplmSPahqzl845HLnnyhm7rbpl0SRc7WDsOo3i1p1fVHyPVoynH0E3G1OLxhSHOwVBah00RdAB8P3nITQP(XbabyoPVsFwRTsBx3G5f1Ll394svaWn9D4sNlN0Zjf6MDwArx9tD1IUDTT131tPxD1F3y1MT7rxsBhM0hzOJsMMsJ2kma)j9rYyr27uK(uS0lhLU1l8)BVT(d5uR5go)QaUALIRaZw7Emn(6vI24102pNtm5lUzU6GDBonenuFOcPpnPaZxEzAXL3oLfBNTlmwmeQcaDB0T2PL5mNM0PRbx6gtZUM4sv6J3xn6B1IyVe5fV9wbm7H)mNXxie67VRk3N3zYE3kmcBzwNF3TLpM2sCXnM4HMuBd(Vd]] )

spec:RegisterPack( "Retribution (LightClub)", 20231114.1, [[Hekili:vVrApoUT1FldcGHD6gn(yoYgmZeGMuGUlk2gu3pBjAjAB1rhguuE3byG(T3hj1bPmjLKp2MMSjWljFN8Dt7vZw9VxTmarXR(Y8PZxmB2S7CMnB6JZwSAj9T94vl3J8FfTf(qckg())lmLeUoNgMMu4n(FeUDh93IYxpHDW3IsrbmeMLMt8HdVJs3N9l3EBqyMFkjWz72BJyq4dq4hHYYc9xTCDEye9tjRwRJrEGXiz7X(WYa(cdcWItIZ8BXm)bkcfecFGKsrIL2Ksk8(74xdJcl8wJYWbfES1Rz7F63fCgae2pnogNeWbnB1YOWmAgxyct2gHHp9fUYcNGwhHdw9xxT0NesXKqetg2SXjdJICcs)AYQLiFgwayHLCt34EaNSfJsaDcLjiMqZyqLw4Dab)fythAym2LM6geIl8(XcVPoFSW7Nk8MpTWBsH3lfEc64Gy4hyt3Vsq0Do(PPrm(GFQrCCEdi)v8Ocd5KVVW793l8csPo7sJEtARmkC3ZPZDaQAKkvYXePfgfPyucYzpgmhsOfEpv4LHPua2mN)tEWwmOXPm(5RHzbPXU0DeCgWfbnetZXyu8ogf1EgUfMm3aN(EJ8hWoURttYZCIcxtqXmmW4cqXtYP7Y4kqUQdmMIdd4xm(P5LsZ9nmHpjpdfGjUzGr5R8B6h6bzPHyYSPe4VpFVFH3ZfEZ40SwpTdKhsAuudLccpeMGb6aCeJmpkRlAZgQkIFw(Ok4r9CF8eUqlr3(ims3fP02mkmBQn3akISftDcZCdWXmxwMjAZI5jbyuqL9n)6HUd7IicReeHBwdBLG)g1DpjmgrEZfr5gZ1mC16zrC7C44Qc3lCxN(zWw4DBB3e83sj(Hz8ROzMJDu5AYa7a21hI(G9j8Wq)VrkwOifY8dxsmh(6pn3dlCU38nH5yvd1U77RqnZr18IhSUoc8S7SfRrqJnPqS)exu6xpf3MJfOklxjp7keuLcYPs17qWXOWKmoQEOrk2aLbSRjSn7FHK7Bq5ruDPCRTkrrrUI)IlltTiFTROgLWKqADI2kiYZWUGgjoRvKUfYhAFAPbJ8j4Awg4PB24U1pGXvn3cqrseOafCaWo(4iCPNsFZ)CJCK(uIBmYNKkY6Sn6T97a9M)RPjW(oLWxLspalUajGALLmoipo(T605aErB3ssvnzqjbmDDnopsUSM0QDAWY762lxFtdjhMBn)4JgjvzWqCcooelmAKu6K8eJx((Gv4bCDUUEH96KU1LEH)g2pNc207GQg7hHlbrx2Z(aEzzMChG98QrxJS6cqAk(1fLtqIIIjH7fB)L0d441ycRCX5lAzYvEZvB5XUWOW)XreFlwX5Btyw1WkohrlRLXEceaYYWclkCEkfhPmqT3ZAjNNc5RSnBrzLLRcfCPiAa(qQgXvD5UcEmuIUjKGb))mWWJvJFlARDxRXeofwacWrTWdA32A0ItGjY2HG8tM5cd7BnSIn2aoDgZfxLvQw1P6dSOZVYGSHtoElR1NFHyIyrxu6yI4Ym12kH)cXfzGMNMdvDONtA2UZsSVeCtz3NAzLMot7Qaz(ycKZrU4HPs2D6MyGLAwVqTJrBYF9DAqh))2ej41Gp3rQHFBtMWuH4gB6FADzBwA8FhkogYgXixLCAo5WjkNDkFpixWCNtEXCq7l6iquMRH9rGyo0PvoYmTTeg8SKrn32N3ye0pyrMZKsXwAA3xRORQwhsmQXDfMs4SP4I3E8rMDZS0x7ynT2(0Vk1UAlDEtC6jw6UVHjvg0WP4AAqB8DG1BRFnxY3qhtY1HZ5O(AosfA5Ge0KpmDp31UbWkpl2NIYXCDK5(ZbgFXuXm8L0BsoLCew2xO8YAYP2nRuI(DqEwq3U3xyXnFQmruB3Ll7L9rFwvdWEsfusqN1cu)h7p9XKH)6hm9BJ9QIo45Au9NWxjzy2XQtS9IwxIL8Ew7lno9qvr19iZu5wYJ7zU5Csp0)K9p2ZSxk1p0oXBFRFyWI9zg(6o7dQ3CzjNP528(yUzPuLRs9awdWmO8v6mgVexxZC(zBdW3C0b7f0uNgTLNGupMYjBLDc(EMP9rZViJ5itxREye1MP9q6AIXsXqdSuoZ2VMBuAO2Vx4RQwffb6MdysgBRQVPgZDGSeGrjRmNSvl)u8(ucL9qfpuLJUWJ)1PWP4ZSHBNUjKvFYpu)D24xk8K)QC85Fq7xrdi3Fp(cLWHwD43fFgwKrTQXQx8zbBXm0lx6V88TThY9hc388n57hD8mJy7oY(eY1tIJhL9GiYXGBGmYZTEyuqgs9ixz(0dc5kqQh56ga9GOHoeyGu6MZ8WOLomONy6hN8GOMEuONCRBpZyZuQ6OJ6XqP7My8zdF2eJJLUjw94FpBcwJPUjQiM5ztrbAmyS0U9dg1oA2XpT4HPg8qBsTWGuoFWtDuNvzKYFx8c81ONftP1lU)bwNJpZ6qw(u1VYU8IIxvxEfdVA(hKEn6NNPaq7xUw9O8RJMrPv)o6Jm8g6JgBQ783F)g(7Mprr2vRSQ(6q5TWhz4DWFAUmQA9eWcTOOxBgAvR98LzDcAzN7hd7ZZgP)1S7eLmt0iCLPWNy3WqIAcSfuqIuma2DpGJkQiawQX9pWhaXZgv1JwmD6K3F)4XF0bjuKMsICud(pb92xkb)gx72GuH2wYpRCmfQEz8riCmmQD1Zazm8p6MBXpo15Jt(P5tN8IajMMtbOcgFm7)ma4KrJVX48iE)DtZI4L7MOHX1u43rbhg3VYeVDHoci3ybdZgMQGKFDdSY9UY9Lf9rp6glDqpQLVYCD4v1XTdUwZ2TgfWLI1L16V0xT(v)ADULRvTjtgBpBIEe20pb37PvRn1XdQBRzYrx0NM6dA)wh7u1jAT3)rnApACxTy)0VAT96jVOVX6tvoE8une6hf6c5rQvN1llLUk74cyLCgktrEI)MiVsdZuMOP7kYuZv0aMMKfNDa9gSF5UXVDUZ96OqROF2IQpfkCQPaSY3Y86Y1DI9wgQnNQ3PQg1lrYywMtGIN51qF542jTSLSsxXnVCxxsPL9p7CjnySprVB94JsbRn8WJMIxpurYUeDLzSHha9YXpNAS47QJfVSShKk5s0tYqJexdLUQ2nvZEFkz)cuyEnVDnciQh5TIhwFinT3M1XplQJA2L)tI6P71G9Eh6ZwOlt8Ah0Z82NGdRgKjh(PpUygcr1YX7I6vP1MBqX)VMC3cDCxpcQFv5jN71XvdpG61KjfblpIjv)50u6UjWxZV(N(AgQYMcBejpdgig)D(8YdRwY)f3(ptu(D6UAjcIFKswTCzoiZqyGm(JkT6)o]] )

spec:RegisterPack( "Protection 96", 20231129.1, [[Hekili:fNvBVTnos4FlblGRnAI8RXxtrCwS7xU2Gd5wuVa73SfTeTnVij6vKkEZbd9B)MHYwMuIu2j192p0AvYHZZdhoCMHtN1F2VpBAirsN90GEdg1ByVHE9V92b96pBQ81n0zt3qcEMSc(iHed)9VLYL0ajJNK7F3yC6xJ4KquncEwAaiYAPCJ4ZD7UIjxNTWlGh3DlFRGflGFLrp3DreFr3yIqst7cd3DdjIeYs6UPu3DHVi4hER4ZMUiJfj)AYSfwO6Wr9gaqVHgaddyZcdPfssfbM093kGj3)GYZ9xYtZ9)c9zweZl3)xjcAyUpoXEcN7hXxXcUgwdDjjqYtrbuR6UX3n(OQMnnIjKcLzG9xWppPSS0eYIiA4SFD20GugSFzKztb9WEHoNMqJzuaIhY97N73k3pGZJc5Bt8eRz0OW58LZtzRwlP8mrcvi8sPXewcSK7NK7lOsjlzLWlMLmhaDEinI8AU)h1NI8xZ3syY5aLrzkahP7AsCmnfHqUMEeMzs0m6I5Le0XQVKe0Hnaj4WttW)wTGs4Arkf87xqKn7kijr0ePhlgC9FHgEulZxML(Q3H1uIP58nFyDvUF2gLFL2MHLiH)mNKLsutrec2QeazCeW6itzlYqSudObC1zA8y4DaDapjamfPelGBzoa(rxu4tZeKq44ScYgddGE7Le0q6lClBxZHbqhFjbDjlf8wPciCfbmRvW26Saf(hxukKYfYg4G1Pbs8PljjeRjqKc3SWX8anU7DrdqAa)KvMu5WOEh(aJN8mUYJmP(uaj637hnlIXyn2zrXuilChA7cXcby6LzeiyNvMCCAKnVVGHVb2SLjc5X2PY(5qE4oY4ISLl9eusKwMOC)HJ7P54bZI67fAYkk64PuP7ODfQKeaLMmViTNzwoDvRlLsTQ4zLz04rVEysnSq5gRl3gEXVMI4oermjH4THMIbXv73YZG)tw4kAmm8rdiKnfUZburlTNfXuq(jDwziuuHZRodLyK1LKSOtKt(4rewjrHtHLk2QFGbj8HDAyZzLpdTpXQ2nChgQVXj4uOt4wid56khlJ0LmtqNdejwurOBp5PR68hxoF5Y5Rccrd4r)g4HcPqj4yO1GaAenLyrfU9pKK0vuP3AyNkx7Tjqw44oONY80UWcXDxuNKftHAZaBdSWFUuCxfPQlEht)rJcbTvQxHjUXCr)TX3C)BAOWvLT8kL58KLXVpu5jRMgLRJwrIzq2w13ZXxdv8MO5fVBmHLqTL88Cwlw2T6(RsjnE5f2GQBy7VtbvokObfUJh2vwUmp0OwZYv08nzYQvP8C)D7Y9dPkqHkuzj4fXWS44xb8ShA9uLoR0fueiSzNVjIsoqC4KBv0RBw7fYoo3ELuWdqc3XA1w1XySkpkTJqnHozn2VddDF3gA3vw3SEur)GWpAw3gRxE)zvz2cJJjhjACh6Q4aPchQ)UnlKSXIzpLPvkdv2HrQ)L5z(dk)GZlfBUFxLs64(CXD1Uak7JCZeqeOySVjOx4XbZscPKcFSc)xDIj(Zmk9)s)cCZ4pWOQhKPmQJXgVSKgy7n27t3w44waynhe932RU5PcBB41x5QzzC9gQR(hwzm9FlLX0uvU7neHCPzbHQAkAOoqvW1xa)tCwS7Ad73FWip4w2wsAsXRr(JF5Bp91N(NFo3p3)3xdPIyXB4PY9Dd7dyO5pGTj7pZyQMKj4XGqKmjpMiXbcwtG7acV8hvlFjpkIVvv2n(Wk4yBlnfgpt1doSnDsuSckN7JPdW7fYdYLWvydUy6shgIchsKKfeb9Z5pQskQfmfg5XVQyocZitaqYbwPm5AE6SPtZGd7KmbS5rLf(Vtm7N447W(8WxYIGCu)0pL7BRzJpItGwuV(99gChcFbIcVYEe9XjDnBSZ1SLtoVwd5qBv6wdQVRY20Y(JJB1CtGSdr9EY8MaP(YDaJEdyEBiOVs7k3OrlVjLBSs7k3wNuEtyytboGYwdtEByztd2bZEFrEtOzxf2HBr1MF4gPdI26m6UYPbt1JJVBWuA50Gv2gJVBal10PbTid03nIfQXHZs1hVIOvRhi3pCCphRxpr1X1ARzh3pXHo0k92Uafp41(CwszJ0qVuG7pVYaod9hv4SOLJqZeUV7cMgqSoPwML)8qFBR2XbGL1pXy9M9wqFMYEjOpyftjA9T3BGR16LaIOXsmFTDrYWkDi4(jd61QDXAoJ3zF)pVx0t)g7o37411AmSYJvVgFM6eSciKR)FLv3489(TUQ9z8o)wNXB87CYTo2EbLBlwSZVOM9M)LQGnvXHJZ9NcU8jH3mDdnkck1R9x4YV1fk9(BhvUhOfJtFdUIw2Qo6NM8LXgSB9(O7ULuHvoaaz1jTYxms0GP5hPLW1X6D1pwjy14BxtKFa)VoNUuQD8I3pkkCS8vDQCpn8w3QH2gwtBAb3vEiypz2TZv)yQTCT2DCKlMTEPvBNnDz3U22teyTvlDUS2I(10wLMmy7gtT14i)2vw6sY5GxJTd57B7lLHpmQLU9(H2NxM3UJQB5p(OFvi7k9Xy3UQ9WOtR2TD25IwTBSNfpG9ROtND7QCAmPXEuuNZ)iQfXMQJmRzDVi1kfB)UPwZgM0t1pHz)Vd]] )

spec:RegisterPack( "Holy Paladin (wowtbc.gg)", 20221002.1, [[Hekili:vA1YUTToq0pMceKG2kl5Mw3CrCw0vnErAbua6ozrjowIxtrkqsz3ayWV9ouQrMsrooDtc9WZCMhCMJDsuYJjXuIbsEyE485rHHZdIwm)MWRtInpvdjX1K8TKc8GGuH)97s(t20Fs4ektytVCVCVjlpOO4kh0N4sc1rPw2OYr4LgtT()MnRhgEYW3olNt06pw0WOGEwjY5hR7OCwsCwdJBUxKKnvM95imZ01qoAgPNrPqhsqNNe)yjtBtRvmPIzW809PmIgO2ujMTMsWM2Nk20FPiMsBABAeKeZzAJUTHaBinCdE8H2geiizCGM8TK4CKyqXijXKCdBhSMknbzajxkwl3SMZkkn20L20WoesbwqdVoX4Y9trBwZMnbAGWdOY9IJK4m5OypttLvoo(0j5WqufGjGI1drKJ18T20OqB6f20kIGeud4JJW0AFHxI()n0cOcVzyGU2fOjX0vpEjbI(ZVLoMMKRa6ADjd40X9Rbx6O8l(jazhikyII17DVEJc(cFKu2oMawZ48MkMG0zCa8Vob8Aoqgb7gFy1Yjikk0hsJgJQbQ0Jrfnr82q2jvJbo3hOB)a7gY8TJH9Voc41JBBUU3qL7neKnAbO1TSE95EbbbuXaC36oK02XQZfoC(xd5QU3axmo7uYlJXL9HHPxtHk3g9Hd(gBeuGGJtxnQ31nP4c7Gjj43svotxnSRIZZ1kixwLroQa8SlkWOyznUpSM0OgpOCM1A0SwJJUJwTF2S71yl(F9RVD)wPQFbUTM2bkTdsVAAs8EIs0gU47RQLkJtMCUnTJlBARCyGDLRFi3W4OC(7ENnD43aSYzcD6h5gzgOWZi92v2vDSOd67LVF5muZNviWvBxRBAiVOx8b2MLVSIpVZDv)P8U3FNxdLNDUCAT9LH(UouuUpy9Y3(yNqC15WOnNBJcVWxJ(2fHNKKUVSXpD8fohvhdUByvmur1)MjuqN4ANIPV5ofsFl9cIt4DR(NV9JYDdQTPfSMUf67OV0Jxp5V6l3fDXR7(rbKjD(Yrsshomwo6kF2ok5qAmLoD)(Fos7AAYFc]] )


spec:RegisterPackSelector( "retribution", "Retribution (LightClub)", "|T135873:0|t Retribution",
    "If you have spent more points in |T135873:0|t Retribution than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

spec:RegisterPackSelector( "protection", "Protection 96", "|T135893:0|t Protection",
    "If you have spent more points in |T135893:0|t Protection than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "holy", "Holy Paladin (wowtbc.gg)", "|T135920:0|t Holy",
    "If you have spent more points in |T135920:0|t Holy than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

