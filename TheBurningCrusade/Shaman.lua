-- Shaman.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Shaman (#7)

if UnitClassBase( "player" ) ~= "SHAMAN" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 7 )

local totem_element = {
    disease_cleansing_totem = "water",
    earth_elemental_totem = "earth",
    earthbind_totem = "earth",
    fire_nova_totem = "fire",
    fire_resistance_totem = "fire",
    flametongue_totem = "fire",
    frost_resistance_totem = "fire",
    grace_of_air_totem = "air",
    grounding_totem = "air",
    healing_stream_totem = "water",
    magma_totem = "fire",
    mana_spring_totem = "water",
    mana_tide_totem = "water",
    nature_resistance_totem = "earth",
    poison_cleansing_totem = "water",
    searing_totem = "fire",
    stoneclaw_totem = "earth",
    stoneskin_totem = "earth",
    strength_of_earth_totem = "earth",
    totem_of_wrath = "fire",
    tremor_totem = "earth",
    windfury_totem = "air",
    windwall_totem = "air",
    wrath_of_air_totem = "air",
}


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
    ancestral_healing = { 581, 3, 16176, 16235, 16240 },
    ancestral_knowledge = { 614, 5, 17485, 17486, 17487, 17488, 17489 },
    anticipation = { 601, 5, 16254, 16271, 16272, 16273, 16274 },
    call_of_flame = { 561, 3, 16038, 16160, 16161 },
    call_of_thunder = { 562, 5, 16041, 16117, 16118, 16119, 16120 },
    concussion = { 563, 5, 16035, 16105, 16106, 16107, 16108 },
    convection = { 564, 5, 16039, 16109, 16110, 16111, 16112 },
    dual_wield = { 1690, 1, 30798 },
    dual_wield_specialization = { 1692, 3, 30816, 30818, 30819 },
    earth_shield = { 1698, 1, 974 },
    earths_grasp = { 572, 2, 16043, 16130 },
    elemental_devastation = { 1645, 3, 30160, 29179, 29180 },
    elemental_focus = { 574, 1, 16164 },
    elemental_fury = { 565, 1, 16089 },
    elemental_mastery = { 573, 1, 16166 },
    elemental_precision = { 1685, 3, 30672, 30673, 30674 },
    elemental_shields = { 1683, 3, 30669, 30670, 30671 },
    elemental_warding = { 1640, 3, 28996, 28997, 28998 },
    elemental_weapons = { 611, 3, 16266, 29079, 29080 },
    enhancing_totems = { 610, 2, 16259, 16295 },
    eye_of_the_storm = { 1642, 3, 29062, 29064, 29065 },
    flurry = { 602, 5, 16256, 16281, 16282, 16283, 16284 },
    focused_mind = { 1695, 3, 30864, 30865, 30866 },
    guardian_totems = { 609, 2, 16258, 16293 },
    healing_focus = { 587, 5, 16181, 16230, 16232, 16233, 16234 },
    healing_grace = { 1646, 3, 29187, 29189, 29191 },
    healing_way = { 1648, 3, 29206, 29205, 29202 },
    improved_chain_heal = { 1697, 2, 30872, 30873 },
    improved_fire_totems = { 567, 2, 16086, 16544 },
    improved_ghost_wolf = { 605, 2, 16262, 16287 },
    improved_healing_wave = { 586, 5, 16182, 16226, 16227, 16228, 16229 },
    improved_lightning_shield = { 607, 3, 16261, 16290, 16291 },
    improved_reincarnation = { 589, 2, 16184, 16209 },
    improved_weapon_totems = { 1647, 2, 29192, 29193 },
    lightning_mastery = { 721, 5, 16578, 16579, 16580, 16581, 16582 },
    lightning_overload = { 1686, 5, 30675, 30678, 30679, 30680, 30681 },
    mana_tide_totem = { 590, 1, 16190 },
    mental_quickness = { 1691, 3, 30812, 30813, 30814 },
    natures_blessing = { 1696, 3, 30867, 30868, 30869 },
    natures_guardian = { 1699, 5, 30881, 30883, 30884, 30885, 30886 },
    natures_guidance = { 583, 3, 16180, 16196, 16198 },
    natures_swiftness = { 591, 1, 16188 },
    purification = { 592, 5, 16178, 16210, 16211, 16212, 16213 },
    restorative_totems = { 588, 5, 16187, 16205, 16206, 16207, 16208 },
    reverberation = { 575, 5, 16040, 16113, 16114, 16115, 16116 },
    shamanistic_focus = { 617, 1, 43338 },
    shamanistic_rage = { 1693, 1, 30823 },
    shield_specialization = { 612, 5, 16253, 16298, 16299, 16300, 16301 },
    spirit_weapons = { 616, 1, 16268 },
    storm_reach = { 1641, 2, 28999, 29000 },
    stormstrike = { 901, 1, 17364 },
    thundering_strikes = { 613, 5, 16255, 16302, 16303, 16304, 16305 },
    tidal_focus = { 593, 5, 16179, 16214, 16215, 16216, 16217 },
    tidal_mastery = { 594, 5, 16194, 16218, 16219, 16220, 16221 },
    totem_of_wrath = { 1687, 1, 30706 },
    totemic_focus = { 595, 5, 16173, 16222, 16223, 16224, 16225 },
    totemic_mastery = { 582, 1, 16189 },
    toughness = { 615, 5, 16252, 16306, 16307, 16308, 16309 },
    unleashed_rage = { 1689, 5, 30802, 30808, 30809, 30810, 30811 },
    unrelenting_storm = { 1682, 5, 30664, 30665, 30666, 30667, 30668 },
    weapon_mastery = { 1643, 5, 29082, 29084, 29086, 29087, 29088 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    air_totem = {
        max_stack = 1,
    },

    ancestral_fortitude = {
        id = 16177,
        duration = 15,
        max_stack = 1,
        copy = { 16177, 16236, 16237 },
        -- Aura effects: MOD_RESISTANCE_PCT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    blood_fury = {
        id = 33697,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_ATTACK_POWER, MOD_DAMAGE_DONE, MOD_HEALING_DONE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    bloodlust = {
        id = 2825,
        duration = 40,
        max_stack = 1,
        -- Aura effects: MOD_CASTING_SPEED_NOT_STACK, MOD_MELEE_RANGED_HASTE, MOD_SCALE
        -- Aura targets: TARGET_UNIT_CASTER_AREA_RAID
    },

    earth_totem = {
        max_stack = 1,
    },

    earth_shield = {
        id = 379,
        duration = 600,
        max_stack = 1,
        copy = { 379, 974, 32593, 32594 },
        -- Aura effects: DUMMY, REDUCE_PUSHBACK
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    elemental_devastation = {
        id = 29177,
        duration = 10,
        max_stack = 1,
        copy = { 29177, 29178, 29179, 29180, 30160 },
        -- Aura effects: MOD_WEAPON_CRIT_PERCENT, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    elemental_mastery = {
        id = 16166,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER, ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    far_sight = {
        id = 6196,
        duration = 60,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    flame_shock = {
        id = 8050,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 8050, 8052, 8053, 10447, 10448, 25457, 29228 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    focused = {
        id = 43339,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    focused_casting = {
        id = 29063,
        duration = 6,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fire_totem = {
        max_stack = 1,
    },

    frost_shock = {
        id = 8056,
        duration = 8,
        max_stack = 1,
        copy = { 8056, 8058, 10472, 10473, 25464 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    ghost_wolf = {
        id = 2645,
        max_stack = 1,
        -- Aura effects: MOD_INCREASE_SPEED, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    gift_of_the_water_spirit = {
        id = 30874,
        duration = 10,
        tick_time = 1,
        max_stack = 1,
        -- Aura effects: OBS_MOD_HEALTH, OBS_MOD_POWER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    healing_way = {
        id = 29202,
        duration = 15,
        max_stack = 3,
        copy = { 29202, 29203, 29205, 29206 },
        -- Aura effects: ADD_TARGET_TRIGGER, DUMMY
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ALLY
    },

    heroism = {
        id = 32182,
        duration = 40,
        max_stack = 1,
        -- Aura effects: MOD_CASTING_SPEED_NOT_STACK, MOD_MELEE_RANGED_HASTE, MOD_SCALE
        -- Aura targets: TARGET_UNIT_CASTER_AREA_RAID
    },

    exhausted = {
        id = 57723,
        duration = 600,
        max_stack = 1,
        -- Aura effects: PACIFY, SILENCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    lightning_shield = {
        id = 324,
        duration = 600,
        max_stack = 1,
        copy = { 324, 325, 905, 945, 8134, 10431, 10432, 25469, 25472 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    natures_swiftness = {
        id = 16188,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    mainhand_imbued = {
        duration = 1800,
        max_stack = 1,
    },

    offhand_imbued = {
        duration = 1800,
        max_stack = 1,
    },

    reincarnation = {
        id = 20608,
        max_stack = 1,
        copy = { 20608, 21169 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    sentry_totem = {
        id = 6495,
        duration = 300,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    sated = {
        id = 57724,
        duration = 600,
        max_stack = 1,
        -- Aura effects: PACIFY, SILENCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shamanistic_rage = {
        id = 30823,
        duration = 15,
        max_stack = 1,
        copy = { 30823, 30824 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    spirit_weapons = {
        id = 16268,
        max_stack = 1,
        copy = { 16268, 18848, 36591 },
        -- Aura effects: MOD_THREAT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    stormstrike = {
        id = 17364,
        duration = 12,
        max_stack = 1,
        copy = { 17364, 32175, 32176 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    unleashed_rage = {
        id = 30802,
        duration = 10,
        max_stack = 1,
        copy = { 30802, 30803, 30804, 30805, 30806, 30807, 30808, 30809, 30810, 30811 },
        -- Aura effects: MOD_ATTACK_POWER_PCT, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_CASTER_AREA_PARTY
    },

    water_breathing = {
        id = 131,
        duration = 600,
        max_stack = 1,
        -- Aura effects: WATER_BREATHING
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    water_totem = {
        max_stack = 1,
    },

    water_shield = {
        id = 24398,
        duration = 600,
        max_stack = 1,
        copy = { 24398, 33736 },
        -- Aura effects: MOD_POWER_REGEN, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    water_walking = {
        id = 546,
        duration = 600,
        max_stack = 1,
        -- Aura effects: WATER_WALK
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
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

-- Ancestral Fortitude - Increases your armor value by 8/16/25%.
    ancestral_fortitude = {
        id = 16177,
        cast = 0,
        duration = 15,
        school = "holy",
        texture = 136109,
        max_stack = 1,
        copy = { 16177, 16236, 16237 },

        -- Effects:
        -- [x] Rank 16177 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_PCT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 16236 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_PCT, points: 15, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 16237 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_PCT, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "ancestral_fortitude" )
        end,

        proc_chance = 100,
        proc_type_mask = { 4, 0 },
        -- Proc type flags: mask0: Deal Melee Swing
    },

-- Ancestral Spirit - Returns the spirit to the body, restoring a dead target to life with 65/150/250/400/600 health and $q1 mana. Cannot be cast when in combat.
    ancestral_spirit = {
        id = 2008,
        cast = 10,
        gcd = "spell",
        school = "nature",
        texture = 136077,
        range = 30,
        spend_pct = 72,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2008, 20609, 20610, 20776, 20777 },

        -- Effects:
        -- [ ] Rank 2008 #0 -- effect: 329, aura: NONE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20609 #0 -- effect: 329, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20610 #0 -- effect: 329, aura: NONE, points: 249, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20776 #0 -- effect: 329, aura: NONE, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20777 #0 -- effect: 329, aura: NONE, points: 599, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
    },

-- Astral Recall - Yanks the caster through the twisting nether back to $z. Speak to an Innkeeper in a different place to change your home location.
    astral_recall = {
        id = 556,
        cast = 10,
        category_cooldown = 900,
        gcd = "spell",
        school = "nature",
        texture = 136010,
        cooldown_category_id = 511,
        cooldown_category = "Astral Recall",
        spend = 150,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 556 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_HOME, mechanic: 0
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

-- Blood Fury - Increases melee attack power by 6 and your damage and healing from spells and effects by up to 5, but reduces healing effects on you by 50%. Lasts 15 sec.
    blood_fury = {
        id = 33697,
        cast = 0,
        duration = 15,
        cooldown = 120,
        school = "physical",
        texture = 135726,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 33697 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 5, addl_points: 1, points_per_level: 4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33697 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 4, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33697 #2 -- effect: APPLY_AURA, aura: MOD_HEALING_DONE, points: 4, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blood_fury" )
        end,

        proc_chance = 100,
    },

-- Bloodlust - Increases melee, ranged, and spell casting speed by 30% for all party members. Lasts 40 sec.
    bloodlust = {
        id = 2825,
        cast = 0,
        duration = 40,
        cooldown = 600,
        gcd = "spell",
        school = "nature",
        texture = 136012,
        spend = 750,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2825 #0 -- effect: APPLY_AURA, aura: MOD_MELEE_RANGED_HASTE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 2825 #1 -- effect: APPLY_AURA, aura: MOD_SCALE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 2825 #2 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "bloodlust" )
            applyBuff( "sated", 600 )
        end,
    },

-- Chain Heal - Heals the friendly target for 320/405/551/605/826, then jumps to heal additional nearby targets. If cast on a party member, the heal will only jump to other party members. Each jump reduces the effectiveness of the heal by 50%. Heals $x1 total targets.
    chain_heal = {
        id = 1064,
        cast = 2.5,
        gcd = "spell",
        school = "nature",
        texture = 136042,
        range = 40,
        spend = 260,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1064, 10622, 10623, 25422, 25423 },

        -- Effects:
        -- [ ] Rank 1064 #0 -- effect: HEAL, aura: NONE, points: 319, addl_points: 49, points_per_level: 2.5, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10622 #0 -- effect: HEAL, aura: NONE, points: 404, addl_points: 61, points_per_level: 2.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10623 #0 -- effect: HEAL, aura: NONE, points: 550, addl_points: 79, points_per_level: 3.3, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25422 #0 -- effect: HEAL, aura: NONE, points: 604, addl_points: 87, points_per_level: 3.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25423 #0 -- effect: HEAL, aura: NONE, points: 825, addl_points: 117, points_per_level: 3.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
    },

-- Chain Lightning - Hurls a lightning bolt at the enemy, dealing 191-734 Nature damage and then jumping to additional nearby enemies. Each jump reduces the damage by 30%. Affects $x1 total targets.
    chain_lightning = {
        id = 421,
        cast = 2,
        category_cooldown = 6,
        gcd = "spell",
        school = "nature",
        texture = 136015,
        cooldown_category_id = 85,
        cooldown_category = "Direct Damage (AE-Chain) - Ability",
        range = 30,
        spend = 255,
        spendType = "Mana",
        max_stack = 1,
        copy = { 421, 930, 2860, 10605, 25439, 25442 },

        -- Effects:
        -- [x] Rank 421 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 190, addl_points: 27, points_per_level: 1.9, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 930 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 276, addl_points: 35, points_per_level: 2.3, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2860 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 377, addl_points: 47, points_per_level: 2.7, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10605 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 492, addl_points: 59, points_per_level: 3.1, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25439 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 602, addl_points: 85, points_per_level: 3.5, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25442 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 733, addl_points: 105, points_per_level: 3.9, sp_bonus: 0.651, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "chain_lightning" ) end
        end,

        proc_chance = 100,
    },

-- Cure Disease - Cures 1 $ldisease:diseases; on the target.
    cure_disease = {
        id = 2870,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136083,
        range = 40,
        spend_pct = 7,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2870 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Cure Poison - Cures 1 poison $leffect:effects; on the target.
    cure_poison = {
        id = 526,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136067,
        range = 40,
        spend_pct = 7,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 526 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Disease Cleansing Totem - Summons a Disease Cleansing Totem with 5 health at the feet of the caster that attempts to remove 1 disease effect from party members within $8171a1 yards every $8172t1 seconds. Lasts 120 sec.
    disease_cleansing_totem = {
        id = 8170,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136019,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8170 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "disease_cleansing_totem", totem_element.disease_cleansing_totem, 120 ) end
        end,
    },

-- Dual Wield - Allows one-hand and off-hand weapons to be equipped in the off-hand.
    dual_wield = {
        id = 674,
        cast = 0,
        texture = 132147,
        max_stack = 1,
        copy = { 674, 30798 },

        -- Effects:
        -- [ ] Rank 674 #0 -- effect: DUAL_WIELD, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 30798 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 674

        -- Related talents:
        -- talent_0 [0]
    },

-- Earth Elemental Totem - Summon an elemental totem that calls forth a greater earth elemental to protect the caster and $ghis:her; allies. Lasts 120 sec.
    earth_elemental_totem = {
        id = 2062,
        cast = 0,
        duration = 120,
        cooldown = 1200,
        category_cooldown = 120,
        gcd = "totem",
        school = "nature",
        texture = 136024,
        cooldown_category_id = 23,
        cooldown_category = "Summoning",
        spend = 705,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2062 #0 -- effect: SUMMON, aura: NONE, points: 7399, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 8, target: TARGET_SRC_CASTER, target2: TARGET_DEST_CASTER_FRONT_RIGHT, mechanic: 0

        radius = 5,

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "earth_elemental_totem", totem_element.earth_elemental_totem, 120 ) end
        end,
    },

-- Earth Shield - Protects the target with an earthen shield, giving a 30% chance of ignoring spell interruption when damaged and causing attacks to heal the shielded target for 0/150/205/270. This effect can only occur once every few seconds. $n charges. Lasts 600 sec. Earth Shield can only be placed on one target at a time and only one Elemental Shield can be active on a target at a time.
    earth_shield = {
        id = 379,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 136089,
        cooldown_category_id = 1195,
        cooldown_category = "Earth Shield",
        range = 50000,
        spend = 300,
        spendType = "Mana",
        max_stack = 1,
        copy = { 379, 974, 32593, 32594 },

        -- Effects:
        -- [ ] Rank 379 #0 -- effect: HEAL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 974 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 974 #1 -- effect: APPLY_AURA, aura: REDUCE_PUSHBACK, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 32593 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 204, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 32593 #1 -- effect: APPLY_AURA, aura: REDUCE_PUSHBACK, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 32594 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 269, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 32594 #1 -- effect: APPLY_AURA, aura: REDUCE_PUSHBACK, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "earth_shield" )
        end,

        proc_chance = 100,
        proc_charges = 6,
        proc_category_recovery = 3.5,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Earth Shock - Instantly shocks the target with concussive force, causing 17-658 Nature damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 2 sec.
    earth_shock = {
        id = 8042,
        cast = 0,
        duration = 2,
        category_cooldown = 6,
        gcd = "spell",
        school = "nature",
        texture = 136026,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 20,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8042, 8044, 8045, 8046, 10412, 10413, 10414, 25454 },

        -- Effects:
        -- [ ] Rank 8042 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 8042 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 16, addl_points: 3, points_per_level: 0.5, sp_bonus: 0.154, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8044 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 8044 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 31, addl_points: 3, points_per_level: 0.7, sp_bonus: 0.212, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8045 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 8045 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 59, addl_points: 5, points_per_level: 1, sp_bonus: 0.299, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8046 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 8046 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 118, addl_points: 9, points_per_level: 1.4, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10412 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 10412 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 224, addl_points: 15, points_per_level: 2, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10413 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 10413 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 358, addl_points: 23, points_per_level: 2.6, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10414 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 10414 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 516, addl_points: 29, points_per_level: 3.1, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25454 #0 -- effect: INTERRUPT_CAST, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: interrupted
        -- [x] Rank 25454 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 657, addl_points: 35, points_per_level: 3.6, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "earth_shock" ) end
        end,

        proc_chance = 100,
    },

-- Earthbind Totem - Summons an Earthbind Totem with 5 health at the feet of the caster for 45 sec that slows the movement speed of enemies within $3600a1 yards.
    earthbind_totem = {
        id = 2484,
        cast = 0,
        duration = 45,
        cooldown = 15,
        gcd = "totem",
        school = "nature",
        texture = 136102,
        spend_pct = 5,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2484 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "earthbind_totem", totem_element.earthbind_totem, 45 ) end
        end,
    },

-- Elemental Devastation - Increases your chance to get a critical strike with melee attacks by 0/6/9%.
    elemental_devastation = {
        id = 29177,
        cast = 0,
        duration = 10,
        texture = 135791,
        max_stack = 1,
        copy = { 29177, 29178, 29179, 29180, 30160 },

        -- Effects:
        -- [x] Rank 29177 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29178 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 29179 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29177
        -- [x] Rank 29180 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29178
        -- [x] Rank 30160 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30165

        handler = function ()
            applyBuff( "elemental_devastation" )
        end,

        proc_chance = 100,
        proc_type_mask = { 65536, 0 },
        -- Proc type flags: mask0: Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Elemental Mastery - When activated, this spell gives your next Fire, Frost, or Nature damage spell a 10% critical strike chance and reduces the mana cost by 100%.
    elemental_mastery = {
        id = 16166,
        cast = 0,
        cooldown = 180,
        school = "nature",
        texture = 136115,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 16166 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 16166 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "elemental_mastery" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Far Sight - Changes the caster's viewpoint to the targeted location. Lasts 60 sec. Only useable outdoors.
    far_sight = {
        id = 6196,
        cast = 2,
        duration = 60,
        gcd = "spell",
        school = "nature",
        texture = 136034,
        range = 50000,
        spend = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 6196 #0 -- effect: ADD_FARSIGHT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 6196 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "far_sight" )
        end,
    },

-- Fire Nova Totem - Summons a Fire Nova Totem that has 5 health and lasts 5 sec. Unless it is destroyed within $8443t1 sec., the totem inflicts 48 fire damage to enemies within $8349a1 yd.
    fire_nova_totem = {
        id = 1535,
        cast = 0,
        duration = 5,
        category_cooldown = 15,
        gcd = "totem",
        school = "fire",
        texture = 135824,
        cooldown_category_id = 35,
        cooldown_category = "Direct Damage (AE) - Spell",
        spend = 95,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1535, 8498, 8499, 11314, 11315, 25546, 25547 },

        -- Effects:
        -- [x] Rank 1535 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 8498 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 8499 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 11314 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 11315 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25546 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25547 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "fire_nova_totem", totem_element.fire_nova_totem, 5 ) end
        end,

        proc_chance = 100,
    },

-- Fire Resistance Totem - Summons a Fire Resistance Totem with 5 health at the feet of the caster for 120 sec that increases the fire resistance of party members within $8185a1 yards by 30.
    fire_resistance_totem = {
        id = 8184,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "frost",
        texture = 135832,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8184, 10537, 10538, 25563 },

        -- Effects:
        -- [x] Rank 8184 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10537 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10538 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25563 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "fire_resistance_totem", totem_element.fire_resistance_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Flame Shock - Instantly sears the target with fire, causing 21-377 Fire damage immediately and 28-420 Fire damage over 12 sec.
    flame_shock = {
        id = 8050,
        cast = 0,
        duration = 12,
        category_cooldown = 6,
        gcd = "spell",
        school = "fire",
        texture = 135813,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 20,
        spend = 55,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8050, 8052, 8053, 10447, 10448, 25457, 29228 },

        -- Effects:
        -- [x] Rank 8050 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 20, addl_points: 1, points_per_level: 0.8, sp_bonus: 0.134, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8050 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0.063, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8052 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 1.2, sp_bonus: 0.198, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8052 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0.093, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8053 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 85, addl_points: 1, points_per_level: 1.7, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8053 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10447 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 151, addl_points: 1, points_per_level: 2.3, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10447 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10448 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 229, addl_points: 1, points_per_level: 2.9, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10448 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 63, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25457 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 376, addl_points: 1, points_per_level: 3.8, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25457 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 29228 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 308, addl_points: 1, points_per_level: 3.5, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 29228 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 85, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "flame_shock" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "flame_shock" ) end
        end,

        proc_chance = 100,
    },

-- Flametongue Totem - Summons a Flametongue Totem that enchants all party members' main-hand weapons with fire if they are within $8230a1 yards. Each hit causes $/77;8253m1 to $/25;8253M1 additional Fire damage. Lasts 120 sec.
    flametongue_totem = {
        id = 8227,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "fire",
        texture = 136040,
        spend = 90,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8227, 8249, 10526, 16387, 25557 },

        -- Effects:
        -- [x] Rank 8227 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 8249 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10526 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 16387 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25557 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "flametongue_totem", totem_element.flametongue_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Flametongue Weapon - Imbue the Shaman's weapon with fire. Each hit causes $/77;8026m1 to $/25;8026M1 additional Fire damage, based on the speed of the weapon. Slower weapons cause more fire damage per swing. Lasts 30 minutes.
    flametongue_weapon = {
        id = 8024,
        cast = 0,
        gcd = "spell",
        school = "fire",
        texture = 135814,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8024, 8027, 8030, 16339, 16341, 16342, 25489 },

        -- Effects:
        -- [ ] Rank 8024 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 8027 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 8030 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16339 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16341 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16342 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 25489 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mainhand_imbued", 1800 )
            applyBuff( "offhand_imbued", 1800 )
        end,

        proc_chance = 100,
    },

-- Focused - Your next Shock spell has its mana cost reduced by 60%.
    focused = {
        id = 43339,
        cast = 0,
        duration = 15,
        school = "arcane",
        texture = 136027,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 43339 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "focused" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell
    },

-- Focused Casting - When cast, you no longer lose casting time on Shaman spells due to taking damage. Lasts 6 sec.
    focused_casting = {
        id = 29063,
        cast = 0,
        duration = 6,
        school = "holy",
        texture = 136213,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 29063 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "focused_casting" )
        end,
    },

-- Frost Resistance Totem - Summons a Frost Resistance Totem with 5 health at the feet of the caster for 120 sec. The totem increases party members' frost resistance by 30, if within $8182a1 yards.
    frost_resistance_totem = {
        id = 8181,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "fire",
        texture = 135866,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8181, 10478, 10479, 25560 },

        -- Effects:
        -- [x] Rank 8181 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10478 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10479 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25560 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "frost_resistance_totem", totem_element.frost_resistance_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Frost Shock - Instantly shocks the target with frost, causing 89/206/333/486/640 Frost damage and slowing movement speed by 50%. Lasts 8 sec. Causes a high amount of threat.
    frost_shock = {
        id = 8056,
        cast = 0,
        duration = 8,
        category_cooldown = 6,
        gcd = "spell",
        school = "frost",
        texture = 135849,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 20,
        spend = 115,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8056, 8058, 10472, 10473, 25464 },

        -- Effects:
        -- [x] Rank 8056 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 8056 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 88, addl_points: 7, points_per_level: 1.2, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8058 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 8058 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 205, addl_points: 15, points_per_level: 1.9, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10472 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 10472 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 332, addl_points: 21, points_per_level: 2.5, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10473 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 10473 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 485, addl_points: 29, points_per_level: 3, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25464 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 25464 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 639, addl_points: 37, points_per_level: 3.5, sp_bonus: 0.386, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "frost_shock" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "frost_shock" ) end
        end,

        proc_chance = 100,
    },

-- Frostbrand Weapon - Imbue the Shaman's weapon with frost. Each hit has a chance of causing 35 additional Frost damage and slowing the target's movement speed by 25% for $8034d. Lasts 30 minutes.
    frostbrand_weapon = {
        id = 8033,
        cast = 0,
        gcd = "spell",
        school = "frost",
        texture = 135847,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8033, 8038, 10456, 16355, 16356, 25500 },

        -- Effects:
        -- [ ] Rank 8033 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 8038 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10456 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16355 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16356 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 25500 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mainhand_imbued", 1800 )
            applyBuff( "offhand_imbued", 1800 )
        end,

        proc_chance = 100,
    },

-- Gadgetstorm Goggles
    gadgetstorm_goggles = {
        id = 41315,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41315 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Ghost Wolf - Turns the Shaman into a Ghost Wolf, increasing speed by 40%. Only useable outdoors.
    ghost_wolf = {
        id = 2645,
        cast = function () return max( 0, 2 + -1 * ( talent.improved_ghost_wolf.rank or 0 ) ) end,
        gcd = "spell",
        school = "nature",
        texture = 136095,
        spend = 100,
        -- Talent cast scaling: improved_ghost_wolf (-1s per rank)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2645 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 2645 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "ghost_wolf" )
        end,
    },

-- Gift of the Water Spirit - Regenerates 50% of your total health and mana over 10 sec.
    gift_of_the_water_spirit = {
        id = 30874,
        cast = 0,
        duration = 10,
        cooldown = 300,
        gcd = "spell",
        school = "nature",
        texture = 136037,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 30874 #0 -- effect: APPLY_AURA, aura: OBS_MOD_HEALTH, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30874 #1 -- effect: APPLY_AURA, aura: OBS_MOD_POWER, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "gift_of_the_water_spirit" )
        end,

        proc_chance = 100,
    },

-- Grace of Air Totem - Summons a Grace of Air Totem with 5 health at the feet of the caster. The totem increases the agility of party members within $8836a1 yards by 43. Lasts 120 sec.
    grace_of_air_totem = {
        id = 8835,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136046,
        spend = 155,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8835, 10627, 25359 },

        -- Effects:
        -- [x] Rank 8835 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10627 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25359 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "grace_of_air_totem", totem_element.grace_of_air_totem, 120 ) end
        end,
    },

-- Grounding Totem - Summons a Grounding Totem with 5 health at the feet of the caster that will redirect one harmful spell cast on a nearby party member to itself, destroying the totem. Will not redirect area of effect spells. Lasts 45 sec.
    grounding_totem = {
        id = 8177,
        cast = 0,
        duration = 45,
        category_cooldown = 15,
        gcd = "totem",
        school = "nature",
        texture = 136039,
        cooldown_category_id = 230,
        cooldown_category = "Totem (Grounding)",
        spend_pct = 5,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8177 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "grounding_totem", totem_element.grounding_totem, 45 ) end
        end,
    },

-- Healing Stream Totem - Summons a Healing Stream Totem with 5 health at the feet of the caster for 120 sec that heals group members within $5672a1 yards for 6 every $5672t1 seconds.
    healing_stream_totem = {
        id = 5394,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "frost",
        texture = 135127,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5394, 6375, 6377, 10462, 10463, 25567 },

        -- Effects:
        -- [x] Rank 5394 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 6375 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 6377 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10462 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10463 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25567 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "healing_stream_totem", totem_element.healing_stream_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Healing Wave - Heals a friendly target for 34-2134.
    healing_wave = {
        id = 331,
        cast = function () return max( 0, 1.5 + -0.1 * ( talent.improved_healing_wave.rank or 0 ) ) end,
        gcd = "spell",
        school = "nature",
        texture = 136052,
        range = 40,
        spend = 25,
        -- Talent cast scaling: improved_healing_wave (-0.1s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 331, 332, 547, 913, 939, 959, 8005, 10395, 10396, 25357, 25391, 25396 },

        -- Effects:
        -- [ ] Rank 331 #0 -- effect: HEAL, aura: NONE, points: 33, addl_points: 11, points_per_level: 0.7, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 332 #0 -- effect: HEAL, aura: NONE, points: 63, addl_points: 15, points_per_level: 1, sp_bonus: 0.271, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 547 #0 -- effect: HEAL, aura: NONE, points: 128, addl_points: 27, points_per_level: 1.5, sp_bonus: 0.5, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 913 #0 -- effect: HEAL, aura: NONE, points: 267, addl_points: 49, points_per_level: 2.3, sp_bonus: 0.793, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 939 #0 -- effect: HEAL, aura: NONE, points: 375, addl_points: 65, points_per_level: 2.7, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 959 #0 -- effect: HEAL, aura: NONE, points: 535, addl_points: 87, points_per_level: 3.3, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8005 #0 -- effect: HEAL, aura: NONE, points: 739, addl_points: 115, points_per_level: 3.9, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10395 #0 -- effect: HEAL, aura: NONE, points: 1016, addl_points: 151, points_per_level: 4.7, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10396 #0 -- effect: HEAL, aura: NONE, points: 1366, addl_points: 195, points_per_level: 5.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25357 #0 -- effect: HEAL, aura: NONE, points: 1619, addl_points: 231, points_per_level: 5.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_CHAINHEAL_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25391 #0 -- effect: HEAL, aura: NONE, points: 1724, addl_points: 245, points_per_level: 6.3, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25396 #0 -- effect: HEAL, aura: NONE, points: 2133, addl_points: 303, points_per_level: 7.1, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Healing Way - Your Healing Wave spells have a 6/33/66/100% chance to increase the effect of subsequent Healing Wave spells on that target by 6% for $29203d. This effect will stack up to $29203u times.
    healing_way = {
        id = 29202,
        cast = 0,
        duration = 15,
        texture = 136044,
        range = 100,
        max_stack = 3,
        copy = { 29202, 29203, 29205, 29206 },

        -- Effects:
        -- [x] Rank 29202 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29203
        -- [x] Rank 29203 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 29205 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 65, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29203
        -- [x] Rank 29206 #0 -- effect: APPLY_AURA, aura: ADD_TARGET_TRIGGER, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 29203

        handler = function ()
            if buff.healing_way.up then
                applyBuff( "healing_way", nil, min( buff.healing_way.max_stack, buff.healing_way.stack + 1 ) )
            else
                applyBuff( "healing_way" )
            end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Heroism - Increases melee, ranged, and spell haste by 30% for all party and raid members. Lasts 40 sec. Allies receiving this effect will become Exhausted and be unable to benefit from Heroism again for $57723d.
    heroism = {
        id = 32182,
        cast = 0,
        duration = 40,
        cooldown = 600,
        gcd = "spell",
        school = "nature",
        texture = 132313,
        spend = 750,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32182 #0 -- effect: APPLY_AURA, aura: MOD_MELEE_RANGED_HASTE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 32182 #1 -- effect: APPLY_AURA, aura: MOD_SCALE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 32182 #2 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_RAID, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "heroism" )
            applyBuff( "exhausted", 600 )
        end,
    },

-- Lesser Healing Wave - Heals a friendly target for 162-1039.
    lesser_healing_wave = {
        id = 8004,
        cast = 1.5,
        gcd = "spell",
        school = "nature",
        texture = 136043,
        range = 40,
        spend = 105,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8004, 8008, 8010, 10466, 10467, 10468, 25420 },

        -- Effects:
        -- [ ] Rank 8004 #0 -- effect: HEAL, aura: NONE, points: 161, addl_points: 25, points_per_level: 1.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8008 #0 -- effect: HEAL, aura: NONE, points: 246, addl_points: 35, points_per_level: 2.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8010 #0 -- effect: HEAL, aura: NONE, points: 336, addl_points: 45, points_per_level: 2.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10466 #0 -- effect: HEAL, aura: NONE, points: 457, addl_points: 57, points_per_level: 3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10467 #0 -- effect: HEAL, aura: NONE, points: 630, addl_points: 75, points_per_level: 3.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10468 #0 -- effect: HEAL, aura: NONE, points: 831, addl_points: 97, points_per_level: 4.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25420 #0 -- effect: HEAL, aura: NONE, points: 1038, addl_points: 147, points_per_level: 4.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Lightning Bolt - Casts a bolt of lightning at the target for 13-563 Nature damage.
    lightning_bolt = {
        id = 403,
        cast = 1.5,
        gcd = "spell",
        school = "nature",
        texture = 136048,
        range = 30,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 403, 529, 548, 915, 943, 6041, 10391, 10392, 15207, 15208, 25448, 25449 },

        -- Effects:
        -- [x] Rank 403 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 12, addl_points: 3, points_per_level: 0.4, sp_bonus: 0.137, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 529 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 25, addl_points: 5, points_per_level: 0.5, sp_bonus: 0.349, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 548 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 9, points_per_level: 0.7, sp_bonus: 0.616, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 915 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 82, addl_points: 13, points_per_level: 1, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 943 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 124, addl_points: 19, points_per_level: 1.2, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6041 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 171, addl_points: 23, points_per_level: 1.5, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10391 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 226, addl_points: 29, points_per_level: 1.7, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10392 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 281, addl_points: 35, points_per_level: 1.9, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15207 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 346, addl_points: 43, points_per_level: 2.1, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15208 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 418, addl_points: 49, points_per_level: 2.4, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25448 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 494, addl_points: 71, points_per_level: 2.6, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25449 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 562, addl_points: 81, points_per_level: 2.8, sp_bonus: 0.794, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "lightning_bolt" ) end
        end,

        proc_chance = 100,
    },

-- Lightning Etched Specs
    lightning_etched_specs = {
        id = 46112,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46112 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Lightning Shield - The caster is surrounded by $n balls of lightning. When a spell, melee or ranged attack hits the caster, the attacker will be struck for 13 Nature damage. This expends one lightning ball. Only one ball will fire every few seconds. Lasts 600 sec. Only one Elemental Shield can be active on the Shaman at any one time.
    lightning_shield = {
        id = 324,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 136051,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 324, 325, 905, 945, 8134, 10431, 10432, 25469, 25472 },

        -- Effects:
        -- [x] Rank 324 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0.147, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 325 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 28, addl_points: 1, points_per_level: 0, sp_bonus: 0.227, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 905 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 50, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 945 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 8134 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 113, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 10431 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 153, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 10432 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 197, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 25469 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 231, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545
        -- [x] Rank 25472 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 286, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 26545

        handler = function ()
            applyBuff( "lightning_shield" )
        end,

        proc_chance = 100,
        proc_charges = 3,
        proc_category_recovery = 3.5,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Living Replicator Specs
    living_replicator_specs = {
        id = 41316,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41316 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Magma Totem - Summons a Magma Totem with 5 health at the feet of the caster for ${21 sec-1} sec that causes 22 Fire damage to creatures within $8187a1 yards every $8188t1 seconds.
    magma_totem = {
        id = 8190,
        cast = 0,
        duration = 21,
        gcd = "totem",
        school = "fire",
        texture = 135826,
        spend = 230,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8190, 10585, 10586, 10587, 25552 },

        -- Effects:
        -- [x] Rank 8190 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10585 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10586 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10587 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25552 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "magma_totem", totem_element.magma_totem, 21 ) end
        end,

        proc_chance = 100,
    },

-- Mana Spring Totem - Summons a Mana Spring Totem with 5 health at the feet of the caster for 120 sec that restores 6 mana every $5677t1 seconds to group members within $5677a1 yards.
    mana_spring_totem = {
        id = 5675,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "frost",
        texture = 136053,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5675, 10495, 10496, 10497, 25570 },

        -- Effects:
        -- [x] Rank 5675 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10495 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10496 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10497 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25570 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "mana_spring_totem", totem_element.mana_spring_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Mana Tide Totem - Summons a Mana Tide Totem with 5 health at the feet of the caster for ${13 sec-1} sec that restores 6% of total mana every $16191t1 seconds to group members within $39610a1 yards.
    mana_tide_totem = {
        id = 16190,
        cast = 0,
        duration = 13,
        category_cooldown = 300,
        gcd = "totem",
        school = "frost",
        texture = 135861,
        cooldown_category_id = 591,
        cooldown_category = "Totem (Mana Tide)",
        spend_pct = 3,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 16190 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "mana_tide_totem", totem_element.mana_tide_totem, 13 ) end
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Nature Resistance Totem - Summons a Nature Resistance Totem with 5 health at the feet of the caster for 120 sec that increases the nature resistance of party members within $10596a1 yards by 30.
    nature_resistance_totem = {
        id = 10595,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136061,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,
        copy = { 10595, 10600, 10601, 25574 },

        -- Effects:
        -- [x] Rank 10595 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10600 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10601 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25574 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "nature_resistance_totem", totem_element.nature_resistance_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Nature's Swiftness - When activated, your next Nature spell with a casting time less than 10 sec. becomes an instant cast spell.
    natures_swiftness = {
        id = 16188,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 136076,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 16188 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "natures_swiftness" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Poison Cleansing Totem - Summons a Poison Cleansing Totem with 5 health at the feet of the caster that attempts to remove 1 poison effect from party members within $8168a1 yards every $8167t1 seconds. Lasts 120 sec.
    poison_cleansing_totem = {
        id = 8166,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136070,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8166 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "poison_cleansing_totem", totem_element.poison_cleansing_totem, 120 ) end
        end,
    },

-- Primal-Attuned Goggles
    primal_attuned_goggles = {
        id = 46110,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46110 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Purge - Purges the enemy target, removing $m1 beneficial magic $leffect:effects;.
    purge = {
        id = 370,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136075,
        range = 30,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,
        copy = { 370, 8012 },

        -- Effects:
        -- [ ] Rank 370 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8012 #0 -- effect: DISPEL, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Reincarnation - Allows you to resurrect yourself upon death with 20% health and mana.
    reincarnation = {
        id = 20608,
        cast = 0,
        cooldown = function () return max( 0, 3600 + -600 * ( talent.improved_reincarnation.rank or 0 ) ) end,
        category_cooldown = 3600,
        school = "nature",
        texture = 136080,
        cooldown_category_id = 1161,
        cooldown_category = "Reincarnation",
        -- Talent cooldown scaling (category source): improved_reincarnation (-600s per rank)
        max_stack = 1,
        copy = { 20608, 21169 },

        -- Effects:
        -- [x] Rank 20608 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 21169 #0 -- effect: SELF_RESURRECT, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "reincarnation" )
        end,
    },

-- Rockbiter Weapon - Imbue the Shaman's weapon, increasing its damage per second by 49/62. Lasts 30 minutes.
    rockbiter_weapon = {
        id = 8017,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136086,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8017, 8018, 8019, 10399, 16314, 16315, 16316, 25479, 25485 },

        -- Effects:
        -- [ ] Rank 8017 #0 -- effect: DUMMY, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 8018 #0 -- effect: DUMMY, aura: NONE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 8019 #0 -- effect: DUMMY, aura: NONE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10399 #0 -- effect: DUMMY, aura: NONE, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 16314 #0 -- effect: DUMMY, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 16315 #0 -- effect: DUMMY, aura: NONE, points: 27, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 16316 #0 -- effect: DUMMY, aura: NONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 25479 #1 -- effect: DUMMY, aura: NONE, points: 48, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 25485 #1 -- effect: DUMMY, aura: NONE, points: 61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 16, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 1,

        handler = function ()
            applyBuff( "mainhand_imbued", 1800 )
            applyBuff( "offhand_imbued", 1800 )
        end,

        proc_chance = 100,
    },

-- Searing Totem - Summons a Searing Totem with 5 health at your feet for 30-60 sec that repeatedly attacks an enemy within $3606r yards for 9 Fire damage.
    searing_totem = {
        id = 3599,
        cast = 0,
        duration = 60,
        gcd = "totem",
        school = "fire",
        texture = 135825,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 3599, 6363, 6364, 6365, 10437, 10438, 25533 },

        -- Effects:
        -- [x] Rank 3599 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 6363 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 6364 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 6365 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10437 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10438 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25533 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "searing_totem", totem_element.searing_totem, 60 ) end
        end,
    },

-- Sentry Totem - Summons an immobile Sentry Totem with 100 health at your feet for 300 sec that allows vision of nearby area and warns of enemies that attack it. Right-Click on buff to switch back and forth between totem sight and shaman sight.
    sentry_totem = {
        id = 6495,
        cast = 0,
        duration = 300,
        gcd = "totem",
        school = "nature",
        texture = 136082,
        spend = 65,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 6495 #0 -- effect: SUMMON, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 6495 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "sentry_totem" )
            if type( summonTotem ) == "function" then summonTotem( "sentry_totem", nil, 300 ) end
        end,
    },

-- Shamanistic Rage - Reduces all damage taken by 30% and gives your successful melee attacks a chance to regenerate mana equal to 0/30% of your attack power. Lasts 15 sec.
    shamanistic_rage = {
        id = 30823,
        cast = 0,
        duration = 15,
        cooldown = 120,
        gcd = "spell",
        school = "physical",
        texture = 136088,
        max_stack = 1,
        copy = { 30823, 30824 },

        -- Effects:
        -- [x] Rank 30823 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30824
        -- [x] Rank 30823 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 30824 #0 -- effect: ENERGIZE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shamanistic_rage" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Spirit Weapons - Gives a chance to parry enemy melee attacks and reduces the threat generated by your melee attacks by 30%.
    spirit_weapons = {
        id = 16268,
        cast = 0,
        texture = 132269,
        max_stack = 1,
        copy = { 16268, 18848, 36591 },

        -- Effects:
        -- [ ] Rank 16268 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 6, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18848
        -- [ ] Rank 16268 #1 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 36591
        -- [ ] Rank 18848 #0 -- effect: PARRY, aura: NONE, points: 0, addl_points: 6, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 36591 #1 -- effect: APPLY_AURA, aura: MOD_THREAT, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "spirit_weapons" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Stoneclaw Totem - Summons a Stoneclaw Totem with 50-1315 health at the feet of the caster for 15 sec that taunts creatures within $5729a1 yards to attack it. Enemies attacking the Stoneclaw Totem have a $5728h% chance to be stunned for $39796d.
    stoneclaw_totem = {
        id = 5730,
        cast = 0,
        duration = 15,
        category_cooldown = 30,
        gcd = "totem",
        school = "nature",
        texture = 136097,
        cooldown_category_id = 45,
        cooldown_category = "Totem (Stoneclaw)",
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5730, 6390, 6391, 6392, 10427, 10428, 25525 },

        -- Effects:
        -- [x] Rank 5730 #0 -- effect: SUMMON, aura: NONE, points: 49, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 6390 #0 -- effect: SUMMON, aura: NONE, points: 149, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 6391 #0 -- effect: SUMMON, aura: NONE, points: 219, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 6392 #0 -- effect: SUMMON, aura: NONE, points: 279, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10427 #0 -- effect: SUMMON, aura: NONE, points: 389, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10428 #0 -- effect: SUMMON, aura: NONE, points: 479, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25525 #0 -- effect: SUMMON, aura: NONE, points: 1314, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "stoneclaw_totem", totem_element.stoneclaw_totem, 15 ) end
        end,

        proc_chance = 100,
    },

-- Stoneskin Totem - Summons a Stoneskin Totem with 5 health at the feet of the caster. The totem protects party members within $8072a1 yards, reducing melee damage taken by 4. Lasts 120 sec.
    stoneskin_totem = {
        id = 8071,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136098,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8071, 8154, 8155, 10406, 10407, 10408, 25508, 25509 },

        -- Effects:
        -- [x] Rank 8071 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 8154 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 8155 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10406 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10407 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10408 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25508 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25509 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "stoneskin_totem", totem_element.stoneskin_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Stormstrike - Instantly attack with both weapons. In addition, the next 2 sources of Nature damage dealt to the target are increased by 1/20%. Lasts 12 sec.
    stormstrike = {
        id = 17364,
        cast = 0,
        duration = 12,
        cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132314,
        range = 5,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,
        copy = { 17364, 32175, 32176 },

        -- Effects:
        -- [x] Rank 17364 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17364 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 32175
        -- [ ] Rank 17364 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 32176
        -- [ ] Rank 32175 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 32176 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "stormstrike" )
        end,

        proc_chance = 100,
        proc_charges = 2,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Strength of Earth Totem - Summons a Strength of Earth Totem with 5 health at the feet of the caster. The totem increases the strength of party members within $8076a1 yards by 10. Lasts 120 sec.
    strength_of_earth_totem = {
        id = 8075,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136023,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8075, 8160, 8161, 10442, 25361, 25528 },

        -- Effects:
        -- [x] Rank 8075 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 8160 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 8161 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 10442 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25361 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0
        -- [x] Rank 25528 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "strength_of_earth_totem", totem_element.strength_of_earth_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Surestrike Goggles v2.0
    surestrike_goggles_v2_0 = {
        id = 41314,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41314 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Surestrike Goggles v3.0
    surestrike_goggles_v3_0 = {
        id = 46113,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46113 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Totem of Wrath - Summons a Totem of Wrath with 3/5 health at the feet of the caster. The totem increases the chance to hit and critically strike with spells by 3% for all party members within $30708a1 yards. Lasts 120 sec.
    totem_of_wrath = {
        id = 30706,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "fire",
        texture = 135829,
        spend_pct = 5,
        spendType = "Mana",
        max_stack = 1,
        copy = { 30706, 30708 },

        -- Effects:
        -- [x] Rank 30706 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_LEFT, target2: NONE, mechanic: 0
        -- [ ] Rank 30708 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_SPELL_CRIT_CHANCE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 30708 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_SPELL_HIT_CHANCE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 9, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 20,

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "totem_of_wrath", totem_element.totem_of_wrath, 120 ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Totemic Call - Returns your totems to the earth, giving you 25% of the mana required to cast each totem destroyed by Totemic Call.
    totemic_call = {
        id = 36936,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136233,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 36936 #0 -- effect: DESTROY_ALL_TOTEMS, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        handler = function ()
            removeBuff( "fire_totem" )
            removeBuff( "air_totem" )
            removeBuff( "water_totem" )
            removeBuff( "earth_totem" )
        end,

        proc_chance = 100,
    },

-- Tremor Totem - Summons a Tremor Totem with 5 health at the feet of the caster that shakes the ground around it, removing Fear, Charm and Sleep effects from party members within $8146a1 yards. Lasts 120 sec.
    tremor_totem = {
        id = 8143,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136108,
        spend = 60,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 8143 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT_RIGHT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "tremor_totem", totem_element.tremor_totem, 120 ) end
        end,
    },

-- Unleashed Rage - Causes your critical hits with melee attacks to increase all party members' melee attack power by 2% if within $30803a1 yards of the Shaman. Lasts $30803d.
    unleashed_rage = {
        id = 30802,
        cast = 0,
        duration = 10,
        texture = 136110,
        max_stack = 1,
        copy = { 30802, 30803, 30804, 30805, 30806, 30807, 30808, 30809, 30810, 30811 },

        -- Effects:
        -- [x] Rank 30802 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30803
        -- [ ] Rank 30803 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER_PCT, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 30804 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER_PCT, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 30805 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER_PCT, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 30806 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER_PCT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 30807 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER_PCT, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 9, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [x] Rank 30808 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30804
        -- [x] Rank 30809 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30805
        -- [x] Rank 30810 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30806
        -- [x] Rank 30811 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30807

        radius = 20,

        handler = function ()
            applyBuff( "unleashed_rage" )
        end,

        proc_chance = 100,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Water Breathing - Allows the target to breathe underwater for 600 sec.
    water_breathing = {
        id = 131,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 136148,
        range = 30,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 131 #0 -- effect: APPLY_AURA, aura: WATER_BREATHING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "water_breathing" )
        end,
    },

-- Water Shield - The caster is surrounded by $n globes of water, granting 43/50 mana per 5 sec. When a spell, melee or ranged attack hits the caster, 170 mana is restored to the caster. This expends one water globe. Only one globe will activate every few seconds. Lasts 600 sec. Only one Elemental Shield can be active on the Shaman at any one time.
    water_shield = {
        id = 24398,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 132315,
        max_stack = 1,
        copy = { 24398, 33736 },

        -- Effects:
        -- [x] Rank 24398 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 169, addl_points: 1, points_per_level: 3, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 23575
        -- [x] Rank 24398 #1 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33736 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 199, addl_points: 1, points_per_level: 3.5, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33737
        -- [x] Rank 33736 #1 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "water_shield" )
        end,

        proc_chance = 100,
        proc_charges = 3,
        proc_category_recovery = 3.5,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Water Walking - Allows the friendly target to walk across water for 600 sec. Any damage will cancel the effect.
    water_walking = {
        id = 546,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 135863,
        range = 30,
        spend = 95,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 546 #0 -- effect: APPLY_AURA, aura: WATER_WALK, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "water_walking" )
        end,
    },

-- Windfury Totem - Summons a Windfury Totem with 5 health at the feet of the caster. The totem enchants all party members main-hand weapons with wind, if they are within $8514a1 yards. Each hit has a 20% chance of granting the attacker 1 extra $lattack:attacks; with 122 extra melee attack power. Lasts 120 sec.
    windfury_totem = {
        id = 8512,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136114,
        spend = 95,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8512, 10613, 10614, 25585, 25587 },

        -- Effects:
        -- [x] Rank 8512 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10613 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 10614 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25585 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25587 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "windfury_totem", totem_element.windfury_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Windfury Weapon - Imbue the Shaman's weapon with wind. Each hit has a 20% chance of dealing additional damage equal to two extra attacks with 46 extra attack power. Lasts 30 minutes.
    windfury_weapon = {
        id = 8232,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136018,
        spend = 90,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8232, 8235, 10486, 16362, 25505 },

        -- Effects:
        -- [ ] Rank 8232 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 8235 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10486 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 16362 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 25505 #0 -- effect: ENCHANT_ITEM_TEMPORARY, aura: NONE, points: 1799, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mainhand_imbued", 1800 )
            applyBuff( "offhand_imbued", 1800 )
        end,

        proc_chance = 100,
    },

-- Windwall Totem - Summons a Windwall Totem with 5 health at the feet of the caster. The totem protects party members within $15108a1 yards, reducing ranged damage taken by 32. Lasts 120 sec.
    windwall_totem = {
        id = 15107,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "nature",
        texture = 136022,
        spend = 115,
        spendType = "Mana",
        max_stack = 1,
        copy = { 15107, 15111, 15112, 25577 },

        -- Effects:
        -- [x] Rank 15107 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 15111 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 15112 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0
        -- [x] Rank 25577 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "windwall_totem", totem_element.windwall_totem, 120 ) end
        end,

        proc_chance = 100,
    },

-- Wrath of Air Totem - Summons a Wrath of Air Totem with 5 health at the feet of the caster. Party members within $2895a1 yards of the totem have their spell damage and healing increased by up to 101. Lasts 120 sec.
    wrath_of_air_totem = {
        id = 3738,
        cast = 0,
        duration = 120,
        gcd = "totem",
        school = "physical",
        texture = 136092,
        spend = 320,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3738 #0 -- effect: SUMMON, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_DEST_CASTER_BACK_LEFT, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonTotem ) == "function" then summonTotem( "wrath_of_air_totem", totem_element.wrath_of_air_totem, 120 ) end
        end,
    },

} )

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "mana" )
end

spec:RegisterRanges( "earth_shock", "flame_shock", "frost_shock", "chain_lightning", "lightning_bolt", "stormstrike" )

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

    package = "Enhancement",
} )

--[[
spec:RegisterSetting( "scaffold_strict_range", false, {
    name = "Scaffold: Strict Range Checks",
    desc = "If checked, this generated profile can use stricter range checks where supported.",
    type = "toggle",
    width = "full",
} )
]]--

spec:RegisterPack( "Elemental", 20260228, [[Hekili:vFvtVnUnq0Fl5Irw0cvl50KDbIZHcSaDtdspOcS3OeL0ilIirkqs5adyOF7lPuSeP(kXzZEOxsCm58EdN5roVGCr)hYpblb0JER9UETN3ND8246Ub5lpuci)sC8t4DQpqXfQF(1COaOsCUELd5mCIgabRIhRwf5hvrYLFJIIMa11FzTcwrjeJE8gKFgjjbA3jiIr(FNjF4FQdbAgMg3WsDOidxGP1HCMeljm1Nsz86W)gEIKtq(5eHu0CcGuCvUu9XhBorafhLdjO)c5hZjsGtWi)lQdlWen8jbKIOk16(4ynSi)0C1XtYO7QGGNbCP67KQKFwSIQstDezeipXjH9mThPNvhBEq7sAm2SmgycpqYKqHdh0zNOo82T1H5kuOXhmGLJLzbS0GUa0GF1SGRArQkOtZo1H1eVZlBToCvDyd9Peo8M43gin3)5sf6xNEnW7HaGcfeqZAD4M3rEjamNq31xsUE20AiJ3T9COCWgHtxeEjeBrqbExbUpNU59Mtg44uvAix1PaLT3GJpVGuGVdu9csH(8fKqafp1HUERha4GZKg1VyIA0Ba1RmankNXsYResnsUR1qDAPkbeOqQqyMZ6D5AURsw7VT3Y83k13Wz7vYHMk4LJfz6YRxD4XJAf648xPb9wxh(P(mOVKuGfkwo0KbZFN(fDpflR4Giq8mjvsbHWs6FzFAUqM4ANjJGSjtM)bGjp69WfNPu4b5KDzsQktAaB5B0K4NovzNS3VvlPg8IQ6Dqw8tnGp)9YeM0Xy3oDmTuXXGj1laQNg7z6gtju3jmiIPgqyjLu)zjhIzfr4)Fp6yam)YhvyZ3h(OHLPB6x8x6jJMo9EGl0Ry5izJ316Yoxlqupf9TIsgxQZcV23o0ooAmz4uFVwSWsj5WjYeoDQNFB7Fmwg87K0Txmq2uF)uXA241rnuImtuJ6ZDXAlnMoC7gGo0f7mRMQRmnYwDOMQWhfYTD3677w98l8Nt5(TwKFXVWTBp5vWaGF2Y8syFUfA7zc3U5SiZWlIMkBSUB7Rd2QLDpz1tT93SaF2oKgHXaIAl)dNOCNYkKzKD(wMz7xzT7oRmMF5jHA)3mYjrRkTXhWQlhE68oECmX36T(tMqoYsGH6AwhiRUSLZjjW1MGbMeMQn4n6Qy7K4w1y7K8vtud36AfPXmCDKZyjy6C2cOHZ7JWci5Fvde(Q5)x5dWEixB7XhxjZyCKVFvjWPvn2QKi0pc]] )
spec:RegisterPack( "Enhancement", 20260228, [[Hekili:TJvWUnUnq0VLCXOlARQLI3SjaX5qbkqtAr6bv0EJsusuweMIuGKkU5I(27qP1wK0sYBq2IIc0lgYKZ8MHdFZBKnke97O4cSMGEoAD0nRJIUni661xhDdkw)Adbf3GZ3J3bpWX1WN)eVcZZj1eU2S3RmbUWGHs0kZH9rXzTuM(rokBkGJ(4DGTnKC0ZFcfxrlkidwsu5O4)uO)1FPlLmgJUuvfUgZ7sLcnwtfWtLczx6pt2tzuifKIskdcmo3SRkOrsYf1zy93U9hoq5fLTYxtoqWnc(3rl3EvnMAGViHwN1skwnUqfwLaPgJ1ioqKDpnfILmOkOf8DTKJGkX89BhSn48TdQX)vIXKVpCYW)EJUbtrzPfKt7kJURsZP8DjQkkHvyCmRTSmy4RbfId8P9uPLe(oDvIOmHGLWdAHMuFcaR1waLtxfUoJPYl6kC9JHsJ0K8UEFa4xx2FfKHN7BjvsUORnIEk3tN29RfP6FdQ0BMa9wPnVrYIKyYy19BzW1ip)1jlYZrxwY5VmcZsimi6qvAAouX3rmaOXYDeDWbQUIYdxVYeLGMC99kIwdHsfm4vVdj6kjrvjyovZmMquWAvAl800AdpmPGsEyZABRBvKekKPk7fpYiTUtnezcRxUeZgpWtGFy0AxUCnExnE0fZgVaGXj1uI6HWv(Dk(1mld8YGZyg9gXfVCXWzLtbTno3k(nYUaC)2VUjSPxbO9I89thRRa2XEiFwnrLEByKBBHqwd9g09KXoOX1ol2dTj9XEgyqXVqKky9(5RBwVj8Au8bS00RQqXpw3iKAOxonQlDaGUugqOvbDpHI7FQF0pPe3Y0WJp3)QaeooJrkq)ikoxcKpjfJIVQl1tRPlDvxQ9YUsohNgdzKRyjsdPRxCoA65AtFb5WSjGrN8i2lRLAYPRx6S7QoUycdqTzwO81nhrYxL1GZhxgNjes7sVFlCjpq0hbFgjztmUz5yCMA7mrWvS2a8Nwg4jKHNb6ZKYnOF7SO7Pr)zkYGoneb4TjxuR2QO5naWe27SdB2eH1saOl9HU0nRhb8K0VbPW1gOoU1jDE7dLXQqBRge(9nXVz6I5emcWIbpHoypSZ3p4kdoazFzEgLxN7vpdNsb2(Q)0CG(CA(gRLZj35jEh(Xbs9Xy(Mo)yyov)dDWDgZ1NwZ3NoFAbcxFE(u)xNKoymoYtqByQtFyVqxS)amBjNX5ugGU1MiBnBZNnFNTDod7STZ8dpp(o6))GR)lp4YN18(hu5I47AWKVA0BAq0u)eZf6WV7sk99S(mSIu8BCN)eMU0V5X)4dWNrFaqOvxjaouCBdrYBvQE)q)9d]] )
spec:RegisterPack( "Enhancement WoWSims", 20260228, [[Hekili:TJvtVnUnq0Fl7fJUOTQ2kFSjaX5qbkqtAr6bv0CJs0suweMIuGKkU(I(TVdPITjPLKtq2IIc0lcmuZ8MHCEZBKdAb6prjfynb9u884RNhhFtu8fZVEXnOe9UgckPbNVbVgwWX1WZFHxH55KAcx3L9S45eATXMDmbUWGLs0kZb7qjRAPm9dC0QHcWvX3c22qYrp9fusfTOG0BjrLJsEwO)9FRlJ4glvfUgZ7YKcnwtfWQsHSl7xjBOmkKcsrjLbbgNBERkQrsYf1RW6VF5pTLYlkBL7s3sWnc(pqlx(PAm1aFrkTEvlPy2XnQWQui1ySgXwIS7XHqSKb3gAbFDlzpOsmFZYEBJo91r14)o1yYpUyWW)rJUbtrzPdKd7kJUUsZP81PQkkHvyCCvBzzu)Fgvi2Yh2tLws4R1vPIYucwcl0cnP(aao7nbkhkf(oJPYZ6ku(XWvJ0K8(EVf4xVf)xxJd8SKkjN1XgHLW94H3(TIs9Vbr6DtFEVKM3jvrsmzS6ULmOiYZ3n4L8yKLPC(TrxMcbl5GWScqy2rq0y5AIostRnCN0ck5(fXZD9CftikyTk9iMFPN19sBuLMMdv21ehN2s1vu(I5ZmNMOMC9DkIwdhjvuVxwhs1vsIQsW8QATkskfszL7M75YUflHSgQy0nKJ11J7DsX1YEaIGiFJL2az9giHMnWXC5Iyxp7l7wp9luE9LMx8cCVZj1uI6(fZcBudlzogeuSon3ngXfVC2W5KtrTnExxWPWJs5dWDl)MMWofcuYlePc23Fs6fXxJs2ILM2tfk5H6gHudTVzXDz940LXaULkQ7ruIDLDMpPe3Y0WYNSFdaHJxXifOFgLKlbwJKIrjFQllqEPlBwxM72(Qm7h)czKV(isdzDqC2B6PYrVHCy0eWinUh7PLpn50ftD29feNmHbOUCuOcLkpIuOWQbNRMgNb0o7YUBjuK7jxhbFevytmUE6yCIa7irWxF2a8xMg4buEhb6tuVnOFZOOFQ4tx29DzGSStzBGgodQ36I6Q3aQx6a6bLEdslMFUeCVE(RC4EnD4ka((2j11DQQbdlSX12cV3Id6(UPIXQyxR6heeAY49ddoxWLSDuOYa04DdqJ1RJmSxcdEhV0u6cA46hCyb)k3dIZuLWtZ40CFr7EUInDgr72JLgy4qA4Ue5dtsS504DitNt(tKcy1hhPzJX49jHXWCQ(h6G7nO0Mw36w28MS5w20MFm3RF89)pE6)YJNcvi(4JJ8r8dn(jSl9DnUzOF74OT83EozxlNFfwrk(dEW)HLV7H)6ZWZ4pdi0QReadkPTHi5TkL1p0x)]] )

spec:RegisterPackSelector( "elemental", "Elemental", "|T136048:0|t Elemental",
    "If you have spent more points in |T136048:0|t Elemental than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "enhancement", "Enhancement WowSims", "|T136051:0|t Enhancement",
    "If you have spent more points in |T136051:0|t Enhancement than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "restoration", "Elemental", "|T136052:0|t Restoration",
    "If you have spent more points in |T136052:0|t Restoration than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

