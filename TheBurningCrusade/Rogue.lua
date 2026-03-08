-- Rogue.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Rogue (#4)

if UnitClassBase( "player" ) ~= "ROGUE" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 4 )


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
    adrenaline_rush = { 205, 1, 13750 },
    aggression = { 1122, 3, 18427, 18428, 18429 },
    blade_flurry = { 223, 1, 13877 },
    blade_twisting = { 1706, 2, 31124, 31126 },
    camouflage = { 244, 5, 13975, 14062, 14063, 14064, 14065 },
    cheat_death = { 1722, 3, 31228, 31229, 31230 },
    cold_blood = { 280, 1, 14177 },
    combat_potency = { 1825, 5, 35541, 35550, 35551, 35552, 35553 },
    dagger_specialization = { 182, 5, 13706, 13804, 13805, 13806, 13807 },
    deadened_nerves = { 1723, 5, 31380, 31382, 31383, 31384, 31385 },
    deadliness = { 1702, 5, 30902, 30903, 30904, 30905, 30906 },
    deflection = { 187, 5, 13713, 13853, 13854, 13855, 13856 },
    dirty_deeds = { 265, 2, 14082, 14083 },
    dirty_tricks = { 262, 2, 14076, 14094 },
    dual_wield_specialization = { 221, 5, 13715, 13848, 13849, 13851, 13852 },
    elusiveness = { 247, 2, 13981, 14066 },
    endurance = { 204, 2, 13742, 13872 },
    enveloping_shadows = { 1711, 3, 31211, 31212, 31213 },
    find_weakness = { 1718, 5, 31233, 31239, 31240, 31241, 31242 },
    fist_weapon_specialization = { 183, 5, 13707, 13966, 13967, 13968, 13969 },
    fleet_footed = { 1721, 2, 31208, 31209 },
    ghostly_strike = { 303, 1, 14278 },
    heightened_senses = { 1701, 2, 30894, 30895 },
    hemorrhage = { 681, 1, 16511 },
    improved_ambush = { 263, 3, 14079, 14080, 14081 },
    improved_eviscerate = { 276, 3, 14162, 14163, 14164 },
    improved_expose_armor = { 278, 2, 14168, 14169 },
    improved_gouge = { 203, 3, 13741, 13793, 13792 },
    improved_kick = { 206, 2, 13754, 13867 },
    improved_kidney_shot = { 279, 3, 14174, 14175, 14176 },
    improved_poisons = { 268, 5, 14113, 14114, 14115, 14116, 14117 },
    improved_sinister_strike = { 201, 2, 13732, 13863 },
    improved_slice_and_dice = { 1827, 3, 14165, 14166, 14167 },
    improved_sprint = { 222, 2, 13743, 13875 },
    initiative = { 245, 3, 13976, 13979, 13980 },
    lethality = { 269, 5, 14128, 14132, 14135, 14136, 14137 },
    lightning_reflexes = { 186, 5, 13712, 13788, 13789, 13790, 13791 },
    mace_specialization = { 184, 5, 13709, 13800, 13801, 13802, 13803 },
    malice = { 270, 5, 14138, 14139, 14140, 14141, 14142 },
    master_of_deception = { 241, 5, 13958, 13970, 13971, 13972, 13973 },
    master_of_subtlety = { 1713, 3, 31221, 31222, 31223 },
    master_poisoner = { 1715, 2, 31226, 31227 },
    murder = { 274, 2, 14158, 14159 },
    mutilate = { 1719, 1, 1329 },
    nerves_of_steel = { 1707, 2, 31130, 31131 },
    opportunity = { 261, 5, 14057, 14072, 14073, 14074, 14075 },
    precision = { 181, 5, 13705, 13832, 13843, 13844, 13845 },
    premeditation = { 381, 1, 14183 },
    preparation = { 284, 1, 14185 },
    puncturing_wounds = { 277, 3, 13733, 13865, 13866 },
    quick_recovery = { 1762, 2, 31244, 31245 },
    relentless_strikes = { 281, 1, 14179 },
    remorseless_attacks = { 272, 2, 14144, 14148 },
    riposte = { 301, 1, 14251 },
    ruthlessness = { 273, 3, 14156, 14160, 14161 },
    seal_fate = { 283, 5, 14186, 14190, 14193, 14194, 14195 },
    serrated_blades = { 1123, 3, 14171, 14172, 14173 },
    setup = { 246, 3, 13983, 14070, 14071 },
    shadowstep = { 1714, 1, 36554 },
    sinister_calling = { 1712, 5, 31216, 31217, 31218, 31219, 31220 },
    sleight_of_hand = { 1700, 2, 30892, 30893 },
    surprise_attacks = { 1709, 1, 32601 },
    sword_specialization = { 242, 5, 13960, 13961, 13962, 13963, 13964 },
    vigor = { 382, 1, 14983 },
    vile_poisons = { 682, 5, 16513, 16514, 16515, 16719, 16720 },
    vitality = { 1705, 2, 31122, 31123 },
    weapon_expertise = { 1703, 2, 30919, 30920 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    adrenaline_rush = {
        id = 13750,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_POWER_REGEN_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    arcane_torrent = {
        id = 25046,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    blade_flurry = {
        id = 13877,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_MELEE_HASTE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blind = {
        id = 2094,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MOD_CONFUSE, MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    blood_fury = {
        id = 20572,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_ATTACK_POWER, MOD_RANGED_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    cheap_shot = {
        id = 1833,
        duration = 4,
        max_stack = 1,
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    cloak_of_shadows = {
        id = 31224,
        duration = 5,
        max_stack = 1,
        -- Aura effects: MOD_ATTACKER_SPELL_HIT_CHANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    cold_blood = {
        id = 14177,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    dazed = {
        id = 31125,
        duration = 8,
        max_stack = 1,
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    deadly_throw = {
        id = 26679,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    evasion = {
        id = 5277,
        duration = 15,
        max_stack = 1,
        copy = { 5277, 26669 },
        -- Aura effects: MOD_ATTACKER_RANGED_HIT_CHANCE, MOD_DODGE_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    expose_armor = {
        id = 8647,
        duration = 30,
        max_stack = 1,
        copy = { 8647, 8649, 8650, 11197, 11198, 26866 },
        -- Aura effects: MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    find_weakness = {
        id = 31233,
        duration = 10,
        max_stack = 1,
        copy = { 31233, 31234, 31235, 31236, 31237, 31238, 31239, 31240, 31241, 31242 },
        -- Aura effects: ADD_PCT_MODIFIER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    garrote = {
        id = 703,
        duration = 18,
        tick_time = 3,
        max_stack = 1,
        copy = { 703, 8631, 8632, 8633, 11289, 11290, 26839, 26884 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    ghostly_strike = {
        id = 14278,
        duration = 7,
        max_stack = 1,
        -- Aura effects: MOD_DODGE_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    gouge = {
        id = 1776,
        duration = 4,
        max_stack = 1,
        copy = { 1776, 1777, 8629, 11285, 11286, 38764 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    hemorrhage = {
        id = 16511,
        duration = 15,
        max_stack = 1,
        copy = { 16511, 17347, 17348, 26864 },
        -- Aura effects: MOD_DAMAGE_TAKEN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    kidney_shot = {
        id = 408,
        duration = 1,
        max_stack = 1,
        copy = { 408, 8643 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    premeditation = {
        id = 14183,
        duration = 10,
        max_stack = 1,
        -- Aura effects: RETAIN_COMBO_POINTS
        -- Aura targets: TARGET_UNIT_CASTER
    },

    riposte = {
        id = 14251,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_DISARM
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    rupture = {
        id = 1943,
        duration = 6,
        tick_time = 2,
        max_stack = 1,
        copy = { 1943, 8639, 8640, 11273, 11274, 11275, 26867 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    sap = {
        id = 2070,
        duration = 45,
        max_stack = 1,
        copy = { 2070, 6770, 11297 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    shadowstep = {
        id = 36554,
        duration = 3,
        max_stack = 1,
        -- Aura effects: MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    slice_and_dice = {
        id = 5171,
        duration = 6,
        max_stack = 1,
        copy = { 5171, 6774 },
        -- Aura effects: MOD_MELEE_HASTE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    sprint = {
        id = 2983,
        duration = 15,
        max_stack = 1,
        copy = { 2983, 8696, 11305 },
        -- Aura effects: MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    stealth = {
        id = 1784,
        max_stack = 1,
        copy = { 1784, 1785, 1786, 1787 },
        -- Aura effects: MOD_DECREASE_SPEED, MOD_SHAPESHIFT, MOD_STEALTH
        -- Aura targets: TARGET_UNIT_CASTER
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

-- Adrenaline Rush - Increases your Energy regeneration rate by 100% for 15 sec.
    adrenaline_rush = {
        id = 13750,
        cast = 0,
        duration = 15,
        cooldown = 300,
        gcd = "spell",
        school = "physical",
        texture = 136206,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13750 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN_PERCENT, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "adrenaline_rush" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Ambush - Ambush the target, causing 275% weapon damage plus 70 to the target. Must be stealthed and behind the target. Requires a dagger in the main hand. Awards 1 combo $lpoint:points;.
    ambush = {
        id = 8676,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132282,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,
        copy = { 8676, 8724, 8725, 11267, 11268, 11269, 27441 },

        -- Effects:
        -- [ ] Rank 8676 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 27, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8676 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8676 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8724 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8724 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8724 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8725 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8725 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8725 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11267 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 73, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11267 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11267 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11268 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 91, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11268 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11268 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11269 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 115, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11269 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11269 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27441 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 133, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27441 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 274, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27441 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Anesthetic Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a $26785h% chance of poisoning the enemy which instantly inflicts 134 Nature damage, but causes no additional threat.
    anesthetic_poison = {
        id = 26786,
        cast = 3,
        texture = 136093,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 26786 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Arcane Torrent - Silence all enemies within $a1 yards for 2 sec. In addition, you gain 10 Energy for each Mana Tap charge currently affecting you.
    arcane_torrent = {
        id = 25046,
        cast = 0,
        duration = 2,
        cooldown = 120,
        gcd = "spell",
        school = "arcane",
        texture = 136222,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 25046 #0 -- effect: APPLY_AURA, aura: MOD_SILENCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Backstab - Backstab the target, causing 150% weapon damage plus 15 to the target. Must be behind the target. Requires a dagger in the main hand. Awards 1 combo $lpoint:points;.
    backstab = {
        id = 53,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132090,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,
        copy = { 53, 2589, 2590, 2591, 8721, 11279, 11280, 11281, 25300, 26863 },

        -- Effects:
        -- [ ] Rank 53 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 53 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 53 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2589 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2589 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2589 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2590 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2590 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2590 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2591 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 45, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2591 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2591 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8721 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8721 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8721 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11279 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11279 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11279 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11280 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11280 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11280 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11281 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 139, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11281 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11281 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25300 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25300 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25300 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26863 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 169, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26863 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26863 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Berserking - Increases your attack speed by $26635m1% to $26635M1%. At full health the speed increase is $26635m1% with a greater effect up to $26635M1% if you are badly hurt when you activate Berserking. Lasts $26635d.
    berserking = {
        id = 26297,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 135727,
        spend = 10,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 26297 #0 -- effect: DUMMY, aura: NONE, points: 4, addl_points: 21, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Blade Flurry - Increases your attack speed by 20%. In addition, attacks strike an additional nearby opponent. Lasts 15 sec.
    blade_flurry = {
        id = 13877,
        cast = 0,
        duration = 15,
        cooldown = 120,
        gcd = "spell",
        school = "physical",
        texture = 132350,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13877 #0 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blade_flurry" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Blind - Blinds the target, causing it to wander disoriented for up to 10 sec. Any damage caused will remove the effect.
    blind = {
        id = 2094,
        cast = 0,
        duration = 10,
        cooldown = 180,
        category_cooldown = 20,
        gcd = "spell",
        school = "physical",
        texture = 136175,
        cooldown_category_id = 1187,
        cooldown_category = "Blind",
        range = 10,
        spend = 30,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2094 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2094 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "blind" )
        end,

        proc_chance = 100,
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

-- Cheap Shot - Stuns the target for 4 sec. Must be stealthed. Awards 2 combo $lpoint:points;.
    cheap_shot = {
        id = 1833,
        cast = 0,
        duration = 4,
        gcd = "spell",
        school = "physical",
        texture = 132092,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1833 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1833 #1 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "cheap_shot" )
        end,

        proc_chance = 100,
    },

-- Cloak of Shadows - Instantly removes all existing harmful spell effects and increases your chance to resist all spells by 90% for 5 sec. Does not remove effects that prevent you from using Cloak of Shadows.
    cloak_of_shadows = {
        id = 31224,
        cast = 0,
        duration = 5,
        cooldown = 60,
        gcd = "spell",
        school = "physical",
        texture = 136177,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31224 #0 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_HIT_CHANCE, points: -91, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 31224 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35729

        handler = function ()
            applyBuff( "cloak_of_shadows" )
        end,

        proc_chance = 100,
    },

-- Cold Blood - When activated, increases the critical strike chance of your next offensive ability by 10%.
    cold_blood = {
        id = 14177,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 135988,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 14177 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "cold_blood" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Crippling Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, slowing their movement speed by 50% for $3409d.
    crippling_poison = {
        id = 3420,
        cast = 3,
        texture = 132274,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3420 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Crippling Poison II - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, slowing their movement speed by 70% for $11201d.
    crippling_poison_ii = {
        id = 3421,
        cast = 3,
        texture = 132274,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3421 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Dazed - A concussive strike that reduces movement speed by 50%.
    dazed = {
        id = 31125,
        cast = 0,
        duration = 8,
        texture = 135860,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 31125 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "dazed" )
        end,

        proc_chance = 100,
    },

-- Deadly Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $2818o1 Nature damage over $2818d. Stacks up to 5 times on a single target.
    deadly_poison = {
        id = 2835,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2835 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Deadly Poison II - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $2819o1 Nature damage over $2819d. Stacks up to 5 times on a single target.
    deadly_poison_ii = {
        id = 2837,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2837 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Deadly Poison III - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $11353o1 Nature damage over $11353d. Stacks up to 5 times on a single target.
    deadly_poison_iii = {
        id = 11357,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11357 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Deadly Poison IV - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $11354o1 Nature damage over $11354d. Stacks up to 5 times on a single target.
    deadly_poison_iv = {
        id = 11358,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11358 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Deadly Poison V - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $25349o1 Nature damage over $25349d. Stacks up to 5 times on a single target.
    deadly_poison_v = {
        id = 25347,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 25347 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Deadly Poison VI - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $26968o1 Nature damage over $26968d. Stacks up to 5 times on a single target.
    deadly_poison_vi = {
        id = 26969,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 26969 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Deadly Poison VII - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy for $27187o1 Nature damage over $27187d. Stacks up to 5 times on a single target.
    deadly_poison_vii = {
        id = 27282,
        cast = 3,
        texture = 132290,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 27282 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Deadly Throw - Finishing move that reduces the movement of the target by 50% for 6 sec and causes increased thrown weapon damage: 1 point : ${$m1+($b1*1)+$rwb} - ${$M1+($b1*1)+$RWB} damage 2 points: ${$m1+($b1*2)+$rwb} - ${$M1+($b1*2)+$RWB} damage 3 points: ${$m1+($b1*3)+$rwb} - ${$M1+($b1*3)+$RWB} damage 4 points: ${$m1+($b1*4)+$rwb} - ${$M1+($b1*4)+$RWB} damage 5 points: ${$m1+($b1*5)+$rwb} - ${$M1+($b1*5)+$RWB} damage
    deadly_throw = {
        id = 26679,
        duration = 6,
        gcd = "spell",
        school = "physical",
        texture = 135430,
        range = 30,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 26679 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 58, addl_points: 17, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26679 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [ ] Rank 26679 #2 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "deadly_throw" )
        end,
    },

-- Deathblow X11 Goggles
    deathblow_x11_goggles = {
        id = 41317,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41317 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Disarm Trap - Sneak up on the trap in order to disarm it. Don't get too close or the trap will go off.
    disarm_trap = {
        id = 1842,
        cast = 2,
        texture = 136162,
        range = 5,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1842 #0 -- effect: OPEN_LOCK, aura: NONE, points: 199, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_GAMEOBJECT_TARGET, target2: NONE, mechanic: 0
    },

-- Distract - Throws a distraction, attracting the attention of all nearby monsters for 10 seconds. Does not break stealth.
    distract = {
        id = 1725,
        cast = 0,
        category_cooldown = 30,
        gcd = "spell",
        school = "physical",
        texture = 132289,
        cooldown_category_id = 22,
        cooldown_category = "Quick Debuff - Spell",
        range = 30,
        spend = 30,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1725 #0 -- effect: DISTRACT, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 10,
    },

-- Envenom - Finishing move that consumes your Deadly Poison doses on the target and deals instant poison damage. One dose is consumed for each combo point: 1 dose: ${$m2*1+$AP*0.03} damage 2 doses: ${$m2*2+$AP*0.06} damage 3 doses: ${$m2*3+$AP*0.09} damage 4 doses: ${$m2*4+$AP*0.12} damage 5 doses: ${$m2*5+$AP*0.15} damage
    envenom = {
        id = 32645,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132287,
        range = 5,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,
        copy = { 32645, 32684, 39967 },

        -- Effects:
        -- [x] Rank 32645 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 143, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 32645 #1 -- effect: DUMMY, aura: NONE, points: 143, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32684 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 179, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 32684 #1 -- effect: DUMMY, aura: NONE, points: 179, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 39967 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 152, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "envenom" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: target_state=16
    },

-- Evasion - The rogue's dodge chance will increase by 50% for 15 sec.
    evasion = {
        id = 5277,
        cast = 0,
        duration = 15,
        category_cooldown = 300,
        school = "physical",
        texture = 136205,
        cooldown_category_id = 66,
        cooldown_category = "Dodge Maneuver",
        spendType = "Energy",
        max_stack = 1,
        copy = { 5277, 26669 },

        -- Effects:
        -- [x] Rank 5277 #0 -- effect: APPLY_AURA, aura: MOD_DODGE_PERCENT, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26669 #0 -- effect: APPLY_AURA, aura: MOD_DODGE_PERCENT, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26669 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "evasion" )
        end,

        proc_chance = 100,
    },

-- Eviscerate - Finishing move that causes damage per combo point: 1 point : ${$m1+($b1*1)+$AP*0.03}-${$M1+($b1*1)+$AP*0.03} damage 2 points: ${$m1+($b1*2)+$AP*0.06}-${$M1+($b1*2)+$AP*0.06} damage 3 points: ${$m1+($b1*3)+$AP*0.09}-${$M1+($b1*3)+$AP*0.09} damage 4 points: ${$m1+($b1*4)+$AP*0.12}-${$M1+($b1*4)+$AP*0.12} damage 5 points: ${$m1+($b1*5)+$AP*0.15}-${$M1+($b1*5)+$AP*0.15} damage
    eviscerate = {
        id = 2098,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132292,
        range = 5,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,
        copy = { 2098, 6760, 6761, 6762, 8623, 8624, 11299, 11300, 26865, 31016 },

        -- Effects:
        -- [x] Rank 2098 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 0, addl_points: 5, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 2098 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6760 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 2, addl_points: 9, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6760 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6761 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 5, addl_points: 15, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6761 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6762 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 9, addl_points: 21, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6762 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8623 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 14, addl_points: 31, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8623 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8624 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 21, addl_points: 45, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8624 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11299 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 33, addl_points: 69, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11299 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11300 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 47, addl_points: 97, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11300 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26865 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 59, addl_points: 121, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26865 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31016 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 53, addl_points: 109, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 31016 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "eviscerate" ) end
        end,

        proc_chance = 100,
    },

-- Expose Armor - Finishing move that exposes the target for 30 sec, reducing armor per combo point: 1 point : ${0-$b1*1} armor 2 points: ${0-$b1*2} armor 3 points: ${0-$b1*3} armor 4 points: ${0-$b1*4} armor 5 points: ${0-$b1*5} armor
    expose_armor = {
        id = 8647,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "physical",
        texture = 132354,
        range = 5,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,
        copy = { 8647, 8649, 8650, 11197, 11198, 26866 },

        -- Effects:
        -- [x] Rank 8647 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8647 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8649 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8649 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8650 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8650 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11197 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11197 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11198 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11198 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26866 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26866 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "expose_armor" )
        end,

        proc_chance = 100,
    },

-- Feint - Performs a feint, causing no damage but lowering your threat by a small amount, making the enemy less likely to attack you.
    feint = {
        id = 1966,
        cast = 0,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132294,
        cooldown_category_id = 82,
        cooldown_category = "Taunt/Detaunt",
        range = 5,
        spend = 20,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1966, 6768, 8637, 11303, 25302, 27448 },

        -- Effects:
        -- [ ] Rank 1966 #0 -- effect: THREAT, aura: NONE, points: -151, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6768 #0 -- effect: THREAT, aura: NONE, points: -241, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8637 #0 -- effect: THREAT, aura: NONE, points: -391, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11303 #0 -- effect: THREAT, aura: NONE, points: -601, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25302 #0 -- effect: THREAT, aura: NONE, points: -801, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27448 #0 -- effect: THREAT, aura: NONE, points: -1051, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Find Weakness - Your finishing moves increase the damage of all your offensive abilities by 2% for $31234d.
    find_weakness = {
        id = 31233,
        cast = 0,
        duration = 10,
        texture = 132295,
        max_stack = 1,
        copy = { 31233, 31234, 31235, 31236, 31237, 31238, 31239, 31240, 31241, 31242 },

        -- Effects:
        -- [x] Rank 31233 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31234
        -- [x] Rank 31234 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31234 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31235 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31235 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31236 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31236 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31237 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31237 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31238 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31238 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 31239 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31235
        -- [x] Rank 31240 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31236
        -- [x] Rank 31241 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31237
        -- [x] Rank 31242 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 31238

        handler = function ()
            applyBuff( "find_weakness" )
        end,

        proc_chance = 100,
        proc_type_mask = { 1296, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Ability; Deal Helpful Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Garrote - Garrote the enemy, causing 144-810 damage over 18 sec, increased by your attack power. Must be stealthed and behind the target. Awards 1 combo $lpoint:points;.
    garrote = {
        id = 703,
        cast = 0,
        duration = 18,
        gcd = "spell",
        school = "physical",
        texture = 132297,
        range = 5,
        spend = 50,
        spendType = "Energy",
        max_stack = 1,
        copy = { 703, 8631, 8632, 8633, 11289, 11290, 26839, 26884 },

        -- Effects:
        -- [x] Rank 703 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 703 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8631 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 33, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8631 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8632 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 46, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8632 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8633 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 58, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8633 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11289 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 73, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11289 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11290 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 91, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11290 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26839 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 110, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26839 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26839 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1330
        -- [x] Rank 26884 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 134, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26884 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26884 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1330
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "garrote" )
        end,

        proc_chance = 100,
    },

-- Ghostly Strike - A strike that deals 125% weapon damage and increases your chance to dodge by 15% for 7 sec. Awards 1 combo $lpoint:points;.
    ghostly_strike = {
        id = 14278,
        cast = 0,
        duration = 7,
        cooldown = 20,
        gcd = "spell",
        school = "physical",
        texture = 136136,
        range = 5,
        spend = 40,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 14278 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 124, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14278 #1 -- effect: APPLY_AURA, aura: MOD_DODGE_PERCENT, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 14278 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "ghostly_strike" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Gouge - Causes 10-105 damage, incapacitating the opponent for 4 sec, and turns off your attack. Target must be facing you. Any damage caused will revive the target. Awards 1 combo $lpoint:points;.
    gouge = {
        id = 1776,
        cast = 0,
        duration = 4,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132155,
        cooldown_category_id = 33,
        cooldown_category = "Mez",
        range = 5,
        spend = 45,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1776, 1777, 8629, 11285, 11286, 38764 },

        -- Effects:
        -- [x] Rank 1776 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1776 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1776 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        -- [x] Rank 1777 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1777 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1777 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        -- [x] Rank 8629 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8629 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8629 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        -- [x] Rank 11285 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11285 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11285 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        -- [x] Rank 11286 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11286 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11286 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        -- [x] Rank 38764 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 38764 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 38764 #2 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "gouge" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "gouge" ) end
        end,

        proc_chance = 100,
    },

-- Hemorrhage - An instant strike that deals 110% weapon damage and causes the target to hemorrhage, increasing any Physical damage dealt to the target by up to 13/21/29/42. Lasts $n charges or 15 sec. Awards 1 combo point.
    hemorrhage = {
        id = 16511,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "physical",
        texture = 136168,
        range = 5,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,
        copy = { 16511, 17347, 17348, 26864 },

        -- Effects:
        -- [ ] Rank 16511 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 16511 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 16511 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17347 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17347 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17347 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17348 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17348 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17348 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 28, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26864 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26864 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26864 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_TAKEN, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "hemorrhage" )
        end,

        proc_chance = 100,
        proc_charges = 10,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Instant Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 19 Nature damage.
    instant_poison = {
        id = 8681,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8681 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison II - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 30 Nature damage.
    instant_poison_ii = {
        id = 8687,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8687 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison III - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 44 Nature damage.
    instant_poison_iii = {
        id = 8691,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8691 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison IV - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 67 Nature damage.
    instant_poison_iv = {
        id = 11341,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11341 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison V - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 92 Nature damage.
    instant_poison_v = {
        id = 11342,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11342 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison VI - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 112 Nature damage.
    instant_poison_vi = {
        id = 11343,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11343 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Instant Poison VII - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 146 Nature damage.
    instant_poison_vii = {
        id = 26892,
        cast = 3,
        texture = 132273,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 26892 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Kick - A quick kick that injures a single foe for 15/30/45/80/110 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 5 sec.
    kick = {
        id = 1766,
        cast = 0,
        duration = 5,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132219,
        cooldown_category_id = 88,
        cooldown_category = "Silence",
        range = 5,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1766, 1767, 1768, 1769, 38768 },

        -- Effects:
        -- [ ] Rank 1766 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1766 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1767 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1767 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1768 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1768 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1769 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 1769 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 38768 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 38768 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "kick" ) end
        end,

        proc_chance = 100,
    },

-- Kidney Shot - Finishing move that stuns the target. Lasts longer per combo point: 1 point : 1 second 2 points: 2 seconds 3 points: 3 seconds 4 points: 4 seconds 5 points: 5 seconds
    kidney_shot = {
        id = 408,
        cast = 0,
        duration = 1,
        category_cooldown = 20,
        gcd = "spell",
        school = "physical",
        texture = 132298,
        cooldown_category_id = 270,
        cooldown_category = "Kidney Shot",
        range = 5,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,
        copy = { 408, 8643 },

        -- Effects:
        -- [x] Rank 408 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 408 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 408 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8643 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8643 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8643 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "kidney_shot" )
        end,

        proc_chance = 100,
    },

-- Mind-numbing Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 40% for $5760d.
    mind_numbing_poison = {
        id = 5763,
        cast = 3,
        texture = 136066,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5763 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Mind-numbing Poison II - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 50% for $8692d.
    mind_numbing_poison_ii = {
        id = 8694,
        cast = 3,
        texture = 136066,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8694 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Mind-numbing Poison III - Coats a weapon with poison that lasts for 1 hour. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 60% for $11398d.
    mind_numbing_poison_iii = {
        id = 11400,
        cast = 3,
        texture = 136066,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 11400 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Mutilate - Instantly attacks with both weapons for an additional 44 with each weapon. Damage is increased by 50% against Poisoned targets. Must be behind the target. Awards 2 combo points.
    mutilate = {
        id = 1329,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132304,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1329, 34411, 34412, 34413 },

        -- Effects:
        -- [ ] Rank 1329 #0 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1329 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 5374
        -- [ ] Rank 1329 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 27576
        -- [ ] Rank 34411 #0 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 34411 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34414
        -- [ ] Rank 34411 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34415
        -- [ ] Rank 34412 #0 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 34412 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34416
        -- [ ] Rank 34412 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34417
        -- [ ] Rank 34413 #0 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 34413 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34419
        -- [ ] Rank 34413 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 34418

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Pick Lock - Allows opening of locked chests and doors.
    pick_lock = {
        id = 1804,
        cast = 5,
        texture = 136058,
        range = 5,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1804 #0 -- effect: OPEN_LOCK, aura: NONE, points: 4, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_GAMEOBJECT_ITEM_TARGET, target2: NONE, mechanic: 0
    },

-- Pick Pocket - Pick the target's pocket.
    pick_pocket = {
        id = 921,
        cast = 0,
        texture = 133644,
        range = 5,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 921 #0 -- effect: PICKPOCKET, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Poisons - You can create and mix poisons, with both found and storebought ingredients.
    poisons = {
        id = 2842,
        cast = 0,
        texture = 136242,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2842 #0 -- effect: TRADE_SKILL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
    },

-- Premeditation - When used, adds 2 combo points to your target. You must add to or use those combo points within 10 sec or the combo points are lost.
    premeditation = {
        id = 14183,
        cast = 0,
        duration = 10,
        cooldown = 120,
        school = "physical",
        texture = 136183,
        range = 30,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 14183 #0 -- effect: 328, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14183 #1 -- effect: APPLY_AURA, aura: RETAIN_COMBO_POINTS, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "premeditation" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Preparation - When activated, this ability immediately finishes the cooldown on your Evasion, Sprint, Vanish, Cold Blood, Shadowstep and Premeditation abilities.
    preparation = {
        id = 14185,
        cast = 0,
        cooldown = 600,
        gcd = "spell",
        school = "physical",
        texture = 136121,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 14185 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
    },

-- Quad Deathblow X44 Goggles
    quad_deathblow_x44_goggles = {
        id = 46116,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46116 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Riposte - A strike that becomes active after parrying an opponent's attack. This attack deals 150% weapon damage and disarms the target for 6 sec.
    riposte = {
        id = 14251,
        cast = 0,
        duration = 6,
        cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 132336,
        range = 5,
        spend = 10,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 14251 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14251 #1 -- effect: APPLY_AURA, aura: MOD_DISARM, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: disarmed

        handler = function ()
            applyDebuff( "target", "riposte" )
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=1

        -- Related talents:
        -- talent_0 [0]
    },

-- Rupture - Finishing move that causes damage over time, increased by your attack power. Lasts longer per combo point: 1 point : 40 damage over 8 secs 2 points: 60 damage over 10 secs 3 points: 84 damage over 12 secs 4 points: 112 damage over 14 secs 5 points: 144 damage over 16 secs
    rupture = {
        id = 1943,
        cast = 0,
        duration = 6,
        gcd = "spell",
        school = "physical",
        texture = 132302,
        range = 5,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1943, 8639, 8640, 11273, 11274, 11275, 26867 },

        -- Effects:
        -- [x] Rank 1943 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1943 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8639 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8639 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8640 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8640 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11273 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11273 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11274 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11274 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11275 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11275 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26867 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26867 #1 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "rupture" )
        end,

        proc_chance = 100,
    },

-- Sap - Incapacitates the target for up to 25/35/45 sec. Must be stealthed. Only works on Humanoids that are not in combat. Any damage caused will revive the target. Only 1 target may be sapped at a time.
    sap = {
        id = 2070,
        cast = 0,
        duration = 45,
        gcd = "spell",
        school = "physical",
        texture = 132310,
        range = 5,
        spend = 65,
        spendType = "Energy",
        max_stack = 1,
        copy = { 2070, 6770, 11297 },

        -- Effects:
        -- [x] Rank 2070 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6770 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11297 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "sap" )
        end,

        proc_chance = 100,
        proc_type_mask = { 69648, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Harmful Ability; Deal Harmful Spell
    },

-- Shadowstep - Attempts to step through the shadows and reappear behind your enemy and increases movement speed by 70% for 3 sec. The damage of your next ability is increased by 20% and the threat caused is reduced by 50%. Lasts $36563d.
    shadowstep = {
        id = 36554,
        cast = 0,
        duration = 3,
        cooldown = 30,
        school = "physical",
        texture = 132303,
        range = 25,
        spend = 10,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 36554 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 36563
        -- [ ] Rank 36554 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44373
        -- [x] Rank 36554 #2 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shadowstep" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Shiv - Performs an instant off-hand weapon attack that automatically applies the poison from your off-hand weapon to the target. Slower weapons require more Energy. Awards 1 combo point.
    shiv = {
        id = 5938,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 135428,
        range = 5,
        spend = 20,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 5938 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
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

-- Sinister Strike - An instant strike that causes 3-98 damage in addition to your normal weapon damage. Awards 1 combo $lpoint:points;.
    sinister_strike = {
        id = 1752,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 136189,
        cooldown_category_id = 40,
        cooldown_category = "Melee (Generic)",
        range = 5,
        spend = function () return max( 0, 45 + -2 * ( talent.improved_sinister_strike.rank or 0 ) ) end,
        -- Talent spend flat scaling: improved_sinister_strike (-2 energy per rank)
        spendType = "Energy",
        max_stack = 1,
        copy = { 1752, 1757, 1758, 1759, 1760, 8621, 11293, 11294, 26861, 26862 },

        -- Effects:
        -- [ ] Rank 1752 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1752 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1757 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1757 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1758 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1758 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1759 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1759 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1760 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1760 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8621 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8621 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11293 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 51, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11293 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11294 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 67, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 11294 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26861 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26861 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26862 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 97, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26862 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Slice and Dice - Finishing move that increases melee attack speed by 20/30%. Lasts longer per combo point: 1 point : 9 seconds 2 points: 12 seconds 3 points: 15 seconds 4 points: 18 seconds 5 points: 21 seconds
    slice_and_dice = {
        id = 5171,
        cast = 0,
        duration = 6,
        gcd = "spell",
        school = "physical",
        texture = 132306,
        range = 100,
        spend = 25,
        spendType = "Energy",
        max_stack = 1,
        copy = { 5171, 6774 },

        -- Effects:
        -- [ ] Rank 5171 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5171 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 6774 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6774 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "slice_and_dice" )
        end,
    },

-- Sprint - Increases the rogue's movement speed by 50/60/70% for 15 sec. Does not break stealth.
    sprint = {
        id = 2983,
        cast = 0,
        duration = 15,
        category_cooldown = 300,
        school = "physical",
        texture = 132307,
        cooldown_category_id = 44,
        cooldown_category = "Speed",
        spendType = "Energy",
        max_stack = 1,
        copy = { 2983, 8696, 11305 },

        -- Effects:
        -- [x] Rank 2983 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8696 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11305 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "sprint" )
        end,
    },

-- Stealth - Allows the rogue to sneak around, but reduces your speed by 30/35/40/50%. Lasts until cancelled.
    stealth = {
        id = 1784,
        cast = 0,
        category_cooldown = 10,
        school = "physical",
        texture = 132320,
        cooldown_category_id = 38,
        cooldown_category = "Aura",
        max_stack = 1,
        copy = { 1784, 1785, 1786, 1787 },

        -- Effects:
        -- [x] Rank 1784 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1784 #1 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 4, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1784 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1785 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1785 #1 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 99, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1785 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1786 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1786 #1 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 199, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1786 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1787 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1787 #1 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 299, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1787 #2 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "stealth" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Aura restrictions: exclude_caster_state=12
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
    },

-- Vanish - Allows the rogue to vanish from sight, entering an improved stealth mode for $11327d. Also breaks movement impairing effects.
    vanish = {
        id = 1856,
        cast = 0,
        category_cooldown = 300,
        school = "physical",
        texture = 132331,
        cooldown_category_id = 39,
        cooldown_category = "Shapeshift",
        spendType = "Energy",
        max_stack = 1,
        copy = { 1856, 1857, 26889 },

        -- Effects:
        -- [ ] Rank 1856 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 11327
        -- [ ] Rank 1856 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18461
        -- [ ] Rank 1856 #2 -- effect: SANCTUARY, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 1857 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 11329
        -- [ ] Rank 1857 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18461
        -- [ ] Rank 1857 #2 -- effect: SANCTUARY, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 26889 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26888
        -- [ ] Rank 26889 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18461
        -- [ ] Rank 26889 #2 -- effect: SANCTUARY, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Aura restrictions: exclude_caster_state=12
    },

-- Wound Poison - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, causing 17 Nature damage and reducing all healing effects used on them by 10% for $13218d. Stacks up to 5 times on a single target.
    wound_poison = {
        id = 13220,
        cast = 3,
        texture = 134197,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13220 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Wound Poison II - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, causing 25 Nature damage and reducing all healing effects used on them by 10% for $13222d. Stacks up to 5 times on a single target.
    wound_poison_ii = {
        id = 13228,
        cast = 3,
        texture = 134197,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13228 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Wound Poison III - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, causing 38 Nature damage and reducing all healing effects used on them by 10% for $13223d. Stacks up to 5 times on a single target.
    wound_poison_iii = {
        id = 13229,
        cast = 3,
        texture = 134197,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13229 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Wound Poison IV - Coats a weapon with poison that lasts for 1 hour. Each strike has a 30% chance of poisoning the enemy, causing 53 Nature damage and reducing all healing effects used on them by 10% for $13224d. Stacks up to 5 times on a single target.
    wound_poison_iv = {
        id = 13230,
        cast = 3,
        texture = 134197,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13230 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Wound Poison V - Coats a weapon with poison that lasts for 1 hour. Each strike has a $27188h% chance of poisoning the enemy, causing 65 Nature damage and reducing all healing effects used on them by 10% for $27189d. Stacks up to 5 times on a single target.
    wound_poison_v = {
        id = 27283,
        cast = 3,
        texture = 134197,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 27283 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

} )

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "combo_points" )
    spec:RegisterResource( "energy" )
end

spec:RegisterRanges( "envenom", "eviscerate", "garrote", "gouge", "kick", "rupture" )

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

    package = "Assassination\ \(wowtbc\.gg\)",
} )

--[[
spec:RegisterSetting( "scaffold_strict_range", false, {
    name = "Scaffold: Strict Range Checks",
    desc = "If checked, this generated profile can use stricter range checks where supported.",
    type = "toggle",
    width = "full",
} )
]]--

spec:RegisterPack( "Assassination (wowtbc.gg)", 20230126, [[Hekili:TAvBVTTnq4FmfiVG1i)wR3wwsa6(Yqcg8aQsr)WqLiTeTeHPi1iPIRbc4V9DhLSLKR0YA2qacK5D85EUJhFognl6XOWuQLfTA(05lMoB(YG5tF)YflIcT7lzrHL0KT0m4djTa()hmgQXWLulxjDKl2P2zxNeKLDj66EHIMIqAuv6eW9CRT0C9KjhDd(Yk2ojraOCvwfpLzMq7I5vAvwfBsu46kUWEVmADhcoF20zlb0lzjrREhappnLv7cZKef(yo34iLAUsZT7De8xRPgwQJuvI81MZCKJKXr(SMAZDeprcGmqR2WfaVFZBCKts1pI8Y9aAz2sh5psSQ1mTJG0Y9G7bAc6NjOuZsufRP2F42jwnpzRjwTjgcCSvttzVLV52mTQQC4DuQ8rBqBglJka6oOXmQwRSE4nkHQdJaJBbA093gbpHftLPXPWh4EwxTztq)Ldsv7K9XHMQzsQGlzX6ktoUr04tSyMKvWzM7M1191ciHJ3iQ069VKVBOsSoTvcEyg25UURRkTvAp1TubtAdYRKzmD8gLoETqPsdaMUwWspZNAFJvm5olL5n2u7As42GC6MowOgeTEf4CkSubtK2HHQNy6TCHOpZoU6Py8evYRRXVU9)VQ5d8JjFIjvfOnSBsfxQ4sRjiLTHNWT3oToojkrAt22F)TgghIVJ4DZ8ZUO5CPXtFM98ZqNGoBFGLxazJkUG(1BoXpnRGYLMl7gTIklxqRVymu4UBAuiubnG7DLy2r1sUmZef(5p8Xv3V63U2rCKhr5dErPsBDe403rohGHwjSN7iA2FvX1OwJrva(rRSQciYWcj5uOHXe4E43H7ooY7b0(K0uvIiHouZxaUExdopaB6piQ5LMQ10k4OWeOF1ardzYWsepbK50C5wgKKiPV3wVjVyrbtMIb0MtHLzqMVVNGPmrubAPGjo01OVgia5kh5p)KHHiXkmF5TGcAopjVR3u5(2O6isfc(xlfyfw0IBk(vJk8HG(locW9MW8yneGe7xqqt7U08orEh0W3jJAG0EWvF1WVKSQauP9hkcLfQN3xCOMpVTSl4gSy9quiCOLR0W5)HzerHEJ(5K1h1WNR8ZnR3DuiQUgf2CPm6xJSqJeAVDLWeitHJgkowByH2w46BerBXOO1xK0rUdQCTiDICnc17ELq1vkhX59VsC61FJaTCuGEbDDh5my4(4QXO5H03X1TuDgZg0yUzwYjhdnRIC8h)Npnhm(TaDQzeXF6LY6t16BZ2E69D6AooXbX)N)Fh)6Pri2ZMok4(zlT7zGjqEaMnkadPq7i36itBjyVbrTbRziGpaJF9B8a0IuBa8Gn(TVHb7gV0cW2lo2a2DqMJ88ZG443mmZVXHhO5ixoCEo(T5HP2D9YZdJgbOS4BFBEm5r9T)dhXZ7Qpw)M2tuix01JMx2EIlJND4lCB3DZ1BFAu)x0F)d]] )

spec:RegisterPack( "Combat", 20230211, [[Hekili:Dw1Y2TTnq0VfTrBQRI1d300ALfnBI9cVHoztpbeqGdLWrKa8aaAfTbF7DgsjtqgkDS7cjboZCVdMh8k2C2ZSKmHhypT42flVDX85ZMVC5NUBblXFScyjvc5EXw8GwuIF)ft5gHNmFSWiYi4otTvIUyjBQvf(h0SnJZjgAfizpTILStLLbTbcojl55DkxGtFeb(Pug4MC8zPxz0bEHY5r35gBG)vyVQqnJL0yKUdcdG)8ut5aAXMciJ9pSePv5bRsGbG08cKcAOubipFoWNh4tB5p2X9b(Y2WnASIkezqAErT1EK5Xc69KGiEYf6utE6EngJJiA5aIu5tyj1vDiCfkjKk0zPz4bcYQMc9SBLgRDWM68w1EiMlm07OqL4OYKwzuAVBMeRaqJdU764aEr5KGLMu9G7PPsUOUW)Ap9mK9k5(b56YTKn155Z6xhZYmh0xRih2x6yBR1e3FWYwU3rnv)oi1BX50)NM0OPAsGxx1SDmwpmWxh4rTrBDLV22K9)4IuI7f2Th7OaxZwfXHidnlkuAi1w72rC9XR3xhGywCVz4w7F(EPQP2B8ftvVCGVbIi2M6QSa0U0GNKTYdx9vX32GCr8GSYCAJnE(D5vfNPW0bERWAn(27iElFbSoYER4085FKLCqy1yT4oRdvzn5QcOvqQu5W9OTbURUQYy9N0G2stuLmWX7VEpGRhbEG)GVfutNOe0zqggXobAgWeFK4wzWlkEsPLf1zKwbOWs3(xHhd8FpW)3V5aIjO09JBc8d7uYDXrl0h7YAGRne5)ScFvs5l64nJorjh6s6FJAQ2ZP55wkqHWFqKMfBAruMpGt6Ok6eL(ZH20nAmPRl3awkXUcJFw4XhkPggzy5aHC0joGQ97mwwY3Xfa63tT9Zto3SxxO(T1FyK1KBu5RBwMcpogI2LMX9DANGyGwwWwYRHH)vcgq8EpfvF59ppFAFd3VCib9u8hHHFbqFTqeXK1Xv2PG6ROn0DNI(nJPCT(oQqFfecG0ZJF(xUeRVKiEmQ30S5k3E01jruc2K6QPx623byGOfbSVg79R6f)Wb6Lu(61CIK4UcMPJQusInS)7p]] )


spec:RegisterPackSelector( "assassination", "Assassination (wowtbc.gg)", "|T132292:0|t Assassination",
    "If you have spent more points in |T132292:0|t Assassination than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "combat", "Combat", "|T132090:0|t Combat",
    "If you have spent more points in |T132090:0|t Combat than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "subtlety", nil, "|T132320:0|t Subtlety",
    "If you have spent more points in |T132320:0|t Subtlety than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

