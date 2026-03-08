-- Warrior.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Warrior (#1)

if UnitClassBase( "player" ) ~= "WARRIOR" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 1 )


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

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "rage" )
end

spec:RegisterRanges( "bloodthirst", "hamstring", "mocking_blow", "pummel", "rend", "revenge" )

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

spec:RegisterPack( "Arms", 20230226, [[Hekili:fN1wVTTnu4Fl5fd5MunFPoPfioaBypS2h6lEy7njXirhZfDBKuj1fg63(oK6gjfPS7wrhqtJnpKNZhp3pHbld(9GDjioo4ZRwSA9IvRU1F5DlVlyh)yjoyxjk(z0tWhYrzW))Z0mwDK3h)J5cshtlqjcgWkQOXa5GDpwrs5Fmp4rBC92nFa2Bjoo4Zld2DGKKGB2jMf3X7)erPKcADuP4xe(X6O9IV(B4NjPeqQ0I9KuqwOyoPiN5xsXXfzpI4xV9NEetzy6ZyAiJJYJX3q2V9XQ979B(QFsXR51FY2jHpKHYti5pfYouuXfNeXyKNYXjnR4BULzsoNDme4apf3UlHi6PyEKjaGktSiCvY)7fCVOf3yuAAyZxdtjm(ncl8wsoHRUlwvEcOor0ScQawVGOe0JPyFbBtb0jPpRFzCgM(eop(ylfvEvwLLHtvxHwLpgconIMe8RkppZAvrgCsD1lHnj494Cg5LrCYKGKzdwyH6e4zN6PHzCsgoKxeMqW38ckTcV1lbl5gNIGtagTeqvDe41S1lwm)0jocuQCFLdEgrG)coUIJdlpGyDcPLjhWOu(b)Yy(9RwCg2OzKBzddZ5aez(nyULyioxCSKbpbfW(GN3M32EfvDOeHLXpp)nEl93CDkKUa8BMp)61NbvICmgG6QwUNH(RIwMhsXjvs2a6XtN8SjFqb7ew3Vz(zWrgyS4WpgqPxdOIt3Yz7gR0Oyb7z3F3S4IIur4R)JPffj8dekJ3rEG4RW6PVsYt6jDvJRU4qSkW0R6N7WRXi4T9g9nO56qnyqvdd0I3e5Eoi8ffbrToLqkkgjb)E3hrEpOqPOBQy4WcWX7P4KTlf8qSQiqKet4pO6tBYJdyAbjg(oL8Sl(exrP4C(dd(5)DfUclck5hOyiIinzMqaqipohNrWSTlB11q68NtXmwo8Jqd5n4lOfqE6upZ7wVxiTXrZNq5LIrV8De(p8Jf(xyffpRHrNo1VSr03us8aSaM2QdkEDOmGWNkTccNuCNn2SrjBtExwiw3nDHvIWXqNnU9kHgTOqxrqTEuCmoftrtZtWaNiUdTiw81(aVb7Uyzih4EHrpuKm2ndlEbtllEflThEsM2VeWcuISuuJtchXa7n0swOu7beG6tEoibUq94POeab5RGtBhRpDY6XuYHmFcR6lKyEb9yiTIDyI0gwAMWIE7HLRuZZIGosbMNjUc9lBeEmH)2RyCPS1lzIg24qvZaWPs71HfxiFBZrvrDsvJl01TK614(acMiS2awRNq73EYFKa3TSGmjCuAR6292sWWgrPKVQ1LVz)mIDjj23stxZfJp)KUbArvJ9(N5iMzc)QuKuzEvwXlae0kWA4MlZsm4UkoLn3BLqTtNCLaudsJLJgkvXKzRXwIgd2bAdgS7(5eFxWUxrurpWSGDFmReSS4K6OBRJAyBDKOPCMF9Nc2j)KC(v8Euvkh(4NLZZ2A4c(LUPed2zoTtZPdBMQv0muahWGXHJH5pbnbcGP1Iu1rZQJCo6ZGWvl5jKZAHC6i2mvKQCHD8oNiX1Kqdm0yagTB6idaiRnNrwgZkDHcs9ucPC70sXYCuxMGmpyGWsURFYAB(egIUvGIyJbrAtr5294m)LcK(jnZNyzODnQwhCxXn2GCV30Lalvj)9dsQhUr5pYK0zdCQC1C(5MEptAcngGqrvjNXyA7M6Kd1rpuhTAHck7M4iyNsbCbwMuPR2goWZT1rt0kUurRx2TocoYsjHRAncMDEiO5jjBVsED0PtkI1vt61rZhUTAZgz7g7oL0)9B8d)FCJBMJY2v1DgXjQd4PGn1rwAGMRXw0qKzDIZKZuD8fjeMAegfPyqwiP70Qiv08BTksVxDh9t1ySPpOUjhZ1yCKLlCEjT00yD09QUxJMXrPMbqsYF3Po8AD2gpRJMVOLw0IM3yv9Myl9EStmbudxMAki4cdXg(BKIuXvPNfY74kv9U6GrMkB3PTSQSfXLRKxf7dhPtYiOD6IPlDNpXw2bf3xJPRSfaV0DeS9752U(lTnnsD019K1Ni5Yslz5(SwZyoitj4Vv1A2Yptd5D)qUGoHOw2aTXVmb6hCc0Zo4vxu4uJFnGIXKL1(DNEXw44mNb0oc9w5o9cG8Mb1u8DHj4A7WXmKyYMCMy2THeecxn3ZWPMzCimTV9iZU5S3xMCqjliTOuAovYb1goi(uAfwMR11BCi16RxSOpR64x7qYW2g(vx2sZDNhkJEhePku053Gq0IIT1V35fZ0VtI(OJQpSJi9GN8FGn9TdM0rpCGuF9g5oL2FigU9nuAkwixzT6TsRPfB90D(B1q4ORNAPVYO9NnqRrfl3P7L375QWwTBkBTNDrO2rVztdMTsW4ypQbG3zwKC0l1OVHrVwJwhhAVzJQMWO5rB9iEELX3ODXipJwuI5FXJ2barv8dqhS7(v8(IVixk4Fc]] )

spec:RegisterPack( "Fury", 20230416, [[Hekili:fN1tpUoUn8pl5sGZ(EBAsM38MTatYHIIIU7H3LuGEZok2ktChh7uz5j7ueKp7LuYwwswYoE6GTa7FYikr(JuKuK0Hld)hHBtiCA4pwTy1dl(2YVpF5Qhx(q4w(7NPHBptIFL8c8JCYj4)(3QyVJl(EwbjbpBzrflgieUDFvAg)xZd37KHR(fyVNPXH)yz42JPjju5oPLXsUEB3)KWyPfSB7oJ)VuoS0b8p)70xtZsbPYkoKMbYIeZtlYlNFMrJloTNW)Y6)0EkRKYELYIk5K8y6xtpSEF1HdZL)58KIl53(nxNe(XjsEsA(lrLhlQ44jjLLPVKttKRm3EltfC(07rah4z06DHIqrX(i9aaDM4q46K)4cwjAuJjzzrY)mklTK)v8UDDAEkxFxLv5jG5KWovWqy9gHLs2NrNJSndqNG(u1Y0tu2l0843RPOZRZvNorZ0xHvL3fcEVeTjmV68WmR2ezXj9vVh2KqpqZltFRdNSjiyw7nmAobE2yEKmJNEIgXlIssPF9nswfDDqcvWnoJaNaU0sat17aVM(WIfZUELtaJkFU2bhqe0FNgxXPrNpskBesntosjz8JZphZFE1IbytZLCg5uuXBGHVMV1CCs71UU8UETKY5GAuQwxWbmI((e4(SIIe(Xugy)hRO0oBenhpsY9j0lWzYUKMNmArQo54eOmcPwAkMkDfQj2WW2amnFGnbbp(Z1Eo6XPy2U4xN9tblN)4xYGSWq44SzF5HbqfM62cutQ5(jY)QOM5rmAsLGnG751RbUKp436fwp)4SbWXjigGd)RfuuwaDC6xoRF0jngfzF5ZpnnUOidZkoxZHPHClr1vRI0ezge8qLvqeLE6dpbJw5eR1Ory5AqnCHEFUwxOK3AIs7tr3063josuZMJ4hzuGzzj9ylg1PH36EnJwwMd)RIbGc1UJekHFm6sA5rd6om41RzWs1QASbwJb1TmpUIXO58NxlHjUMge7KySJEjj1EK77saeztUe7NnfS1aBBwVCrZDpEq1DElwWLbMEabreMh4(GbM4(CXfLF39GLvlMgiGI6WGGjjVlI5LpvrkHmFqPzYeUaHHIRLMY8Il2z8qc4JEn56cSriQ4xVAVQcAZ0FX1UibS0keGO(91QsAubKC9L4K1lX3WfAn8gEACkFJ(ZHoyZrkRing(Bw6R(yLYaQuU)DfTIIAxR)gkdWsqZPNsPLRx6XBo4(FasjKAt4SEvK4mr2HpnnyZF4AWDwvAGZ3m08KSEQPFH2Mxbf5aVmoDI707xV2Zlw9kE86kLtpvAEX1Vll09gdA4cAJGehtZOmcU3rWbSWT2YMnYbJgpKdrGaGwjWDoTZfHDLJdhOwx2NJBvnY2cFpVxg3wANd2QiAZ0lx(OMM)OmdFckDVSqpGg5sq3hyBDOpcnvrz1jkkUy(IGdMFpMc)24bcvHOksw6)XOFE7sSXDjiQE5PjOT75hsIM9z2j1QY8REe04nl9dJATLP00cKvvY1lu02UBoJbBE3P76oynWzbJ4nTJkbXLnkXA5Iztd87sC96KoAYm)OvucfGPjAoAJV6iBU2wreWAojdW980tNzW6ALvmNrYFDZc9lk7U9h0EgUf4wjC26bHTA13c3EHWWM8ld3(RNoxW4q)I7((TDsHCBho1HY53(TWTIFjMnh9aPkJd)8hIz1v7Vg(xAgdw4w7X5ipDKCGDy9yHCadwhoMLI3peaMoFb92UP321(gUvFmTcx)XmuopGYPHOCSp6Yf2X38IeP7r3r90YqRj0yOP2heL1JdilRHbDNcs)uOu(E)sXXGIUpbzFWq8MCRA0HU8jSeDTaXi3wr6Yq539yGrHk8tK1d5yQKguDozsn3ylYkVP7bw6s(Zds6hwA8fHtoS7fWvkKpQ9OnHo4VGwEc3gCBNVr9jG0dlwCB3SB7UE92UUd9tWWA3c9LDC1nmu6017TDpFB3Qf6cXOQDxxfdlMj6jq0zNuj9pPqDC4Rmkxzs(8HKJjk6aCA7YvsNpFy1zQJoaLApUYqnmK6FOKMVoOpC6DBUTlq8ppEB3pR8572ZJWz)Ne7eNT1UVap)jhyPGYmXkp4Yvq(ceOvpnATAIcq(6EtAXdCd86q1E0PNf69mDyR3akI6F5JGANTZoeywlaJN9uxgLaYpj2vFtl0CdDghOG8K68QgfRRBjS65gng)5rBmg59IUAc(zgP4SlQbWZYfJgq9B22Swl(13Osh06(b4IRHUkIofrB67S7Wxn2NZRvdkwd)XGMrhJck69maxlGM5A0SIT64Hkhwc7r06kziUrX974F4Ut)ZiVCOjiYwUq3ruVDfPM6VLfhGg3JaZJ)f(XG5vsmhuFH1DSVYuIYsx6m6xRKDLwdOvG)Xx6GVbe3GuB9dnvsyAtrHelGQ6gxwxNzn9dxyTEtSg5EC1sUw3swK7V07ap5KBUsC2uUKKvqM0ZCwJ5ZFt6YtBeYR0Yz90cXwTEFrJxV1UdSVrsFOifvVt1bi(7OS)o8fP5w0YpDVwUdLSx3c9VNGGXR04S67q4Yq53bOBWApJMxC5IcSD88IsawoyU6ab5rvbQ9q7n8om(CjJZ14)DnEZ)p0y53vXLQ6330otLwnDbEl4ZifNv9ugiYEUm(NeYGfelTL(Q7slk2xnOTOQTAavxjwMm1wvF0dRXh9uFhYZx9WIf2vG7k3UrHoo(EhMDa5Tl127dGKRcE97pOpSFhGyp3k9sBdODkI1VqA)yaoeXLlTIWODYovrnOf8dyP6u2ZDzQ8Bu8N0XRrXN67pOoWDzV6bjUE0DM(JATPRecte52qvzTmCOxoWeiT6iRJL2Ur62Jp4hoXk9GZpFIE8VnzH89hqQUAARxR9c2OMTU5E5oMGAZt4(sG0TWgDdTGNKk(riN62)k9qXVlwk8)c]] )

spec:RegisterPack( "Protection", 20231124, [[Hekili:TRvBVPoow4FlvJugO0gGsP7oxbvA2DKw1(HUJwUAMVrIjXazBioJTdOUcLF77XoVGtIDc02DMRwns3EfeF858CSpVhwoE5xxUWhXXlF5Ur3nz847EWE04jtMC3Yf83IXlxeJ8EfTb(qeAh8))mLWXE8asKyP3cjiFblyKeQhS8wopM9LHdpC4G9bYHTyKVThz3WdeE4Rd3Ke4Jh6fIymmB4beLgqOdJlz5qok61BHVIeF7wpcj0NCiIDlAvqyapaZUnEpiLvjbH8NIwUsh2Hpd4jg7T8LXaGc89XzuIzElx81TbSu3yHGd4VL6k(2ked7N6sIsD5BXPU5ap1vIx7LlcdyCMundI2eIHp9I8GdhHwfI9x(3wUWdyhMgGeGB9A7vHeIFycJBNeN6AL66JLpNTfXf0fTXHVLsoyl0VLlq5NO1xEjh0T2LKpEnoIfSh7WGtppCnowF5LlsyyhY61oB88fQbiHjgLafU5T9sOuCep19X5PUmmNdWJz)Bj4eCoqXSTWnLupRTJu3mGyVftjbEaiObVITHRNiG(bPU7rGGabBlUt9Dyjr(yQJhHXLl3tHIDOGio8xorPUxxYDF8EeOF8so3Vy3W)kmJGd)aSqgHOD2uSGDWL)Su37K0FIBQ0vWVtNOv0eDhN3B84eadAZgkj194XstcofaI4G0pz3U3K2l9LhLAXDU5uZlgtyx14sUeyA69QaNtf4S2II9PcEGShujJI3JJerdQqYFXOgdE6bBIWaJ3ss4Iqb7qr(cTv(aPUK7yiw)0TcOr3FA167RgHNWxDcfO7VEUOBf48fIVmKPUhJOsLibI(bJisR7qM5Ij)avF9CVaHmgpYOqk9HZSaD8X7isS5KtUu9aJ1RknsrXouSFsMnMWguGOELll4affg8FoDdvnUNgcu9aNiT57RQk1PxQtMJ6Qavohsz5ag)WfBBGMVnpytikUgCnWJ6q(eEv5LeP3v15cC5oG2x3VzS5iVTh0YsE3iHAUhPtctACKRh9AlyMW6SAaKBnhjDqgToBajldscb6QDvDYQJlt4Gsc56Yrw6KIcdDY(IJi1AwcwNScmGyH8Y0EL7ylI2iQZenXVGu5BRr29vilgdYMIxhwuetfAN2EMqq3c8cYYRnzuX1a4o5SIeLWSHkuOJhjQNX5(ypf)Fr1auzvuntxuj(QyzqK7yNDe2YWc4Dy4mkY7T2Jl0s0qGCOobCeEhuPLujhRe5pjY4DgIG1fw7C2AEfvstNykgIFdblBValibAUvEoI9jC79bBccff4K6cw3Joj8YfAVwQQ(dZk9hAK5j3TOLSdpm6mV5n79)rsBQkEDPdnxEY7nDyffUwQoZEuLr4GB9xdXmwe8he)sHxykdtFfcRAU21AvNCItNTdK5QOlCW7gPNtv2MD8(FxSLFORGO8mN32BOHWykf88ND2uTZgVqmKzxjD53G9SKHrJnRuqwLQyo3mJAsBmrxPpxqRen3CvIm7k9o7WQsPGNFvwDV)U6H7D17wxo6M7LRLMc(iPC(S6uRL67FV5M(OTQn2CqQ3rBu7q)Bc15BKMP()WMpKnpOjzgjwEDPuvyEaAXNctWYahMJwyjsjpsESkUQ4I8OCiJ8oSdN44hizdnVIw1hRjjx3qPUDv(mXunQkZVOimzK3SShtLhQfjMZ2oIcgb2mrFTfPoakhBpvEkhchHqRdzwoYNmrvNegnLJJqxI1ZqRuzrHruv3cbcB1ZOIQuR8dnA5m5jrFvfrDSk6kg(DQhggBt7WBUeEgOr1HEQQguF6pAYn)EuIl8eUsPiQWRrxOfP9BIVG16rOU7k5eH7Cqz56NdoKb7FuP6Ak8Y1NP3Im4ci(9qdjc4w8(gG8ghqurWcODJF9h)xV80l)JVK6M6(vXRriyxmHcX3wtGJ4VhkZ(7HOz4FljGk8IzKDanOeozhGi4bq55qOuMD6ZYDVMegsoaSwqefbh1hWu45jY3vrqX7Qit1ah4aXeZxjYgMrxerk6KOku77li2hXrIx6XxsFwQ7ntlbl88ts8lK20QYrGr4qnHVLah5lsIXuOdfMi5jaU)zK6Bjk19xZEnpWr9t)sFrt(K1bIl6V77kxdoZu2XZIv(94fjLjPxi7X7wjCde3Qcfx80FUywePpNP6m7YXtmy(WYPkCtW65YbsyLxhCLHrmhsAONbLTTDJsXCZhlyNA2XzfnzODmewnR6z28hgPxI1zHquDu03fXF1kN0WB1LVm(wBkanpWm1FUE(PsKEkQ3zztjAU)uRRUm00LDq(ybECYiRRmnmad33Y29lSN)PSXYwsQGGAJH9gry35IsOQqvoBo9eLrTw5X1gTQ6AFQAjWVYXKQ(WYW7c2ACSOQ7O2GjZoaGa1sZxp12AFCCN7lBsMfN3pjogD)fevXgtC0kIDKdTSTPub3nY0vZ7zQqulOi0(hp2S8ZoerLS95cP9ImT0vG5J96n9wJPj7FDpOyYb5fs2V)GjDGk1e3fGsfOwx1r1Hhp2tFvlwgb5SP97av1kVspW0w8HzPoFQ21kI8nTdiv3cwlMUGtIc5E3fCbjR)6gs8CzDBvCW0CpMN0Qw9wx3Q5ZnNkDdYAM7fTi3NQaNz(yYyqvhNyzqz1XtA12Oj1W0psCFnSRYpuG2tZ)48wM(OvfkZpB187PyG5Flfd6zAIKxR)UQ)GE9ABkaZURFXoB0JFFT3xNMFLq57jNs3XJMc113YWKZQEym3egmdbbnAwnFsgAw5ZQUP7ZEQPbKbeOr4F0IQYfQUrFPxG6tIQAqD8OXPBRJD1h9KGVDo5mREfb)RnRStX81oLmRoNq2Sj91zFQoaxbclfVPFmbNasTFgbwTVZtWqRjA(8U76IPnxtRRKYVXO5S6zYzzwLyr3QpIWGYbXDnecRFre6)U8nlCcVq1tMcptymR3Bm6m2(5eGoJxzVsKp7WYQVmO)Oc6MPFQMLnVEYTZ0uO7K6e3iYynE0CbLq9noEVGa)6EPkgnUBFxTLm5CsIurZQMbj3A6pGKezs(3RmefEGFW45AFdiFYr1lG63ubmLtqC5)9d]] )



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

