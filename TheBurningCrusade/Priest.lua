-- Priest.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Priest (#5)

if UnitClassBase( "player" ) ~= "PRIEST" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 5 )


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
    absolution = { 1769, 3, 33167, 33171, 33172 },
    blackout = { 464, 5, 15268, 15323, 15324, 15325, 15326 },
    blessed_recovery = { 1636, 3, 27811, 27815, 27816 },
    blessed_resilience = { 1765, 3, 33142, 33145, 33146 },
    circle_of_healing = { 1815, 1, 34861 },
    darkness = { 462, 5, 15259, 15307, 15308, 15309, 15310 },
    divine_fury = { 1181, 5, 18530, 18531, 18533, 18534, 18535 },
    divine_spirit = { 351, 1, 14752 },
    empowered_healing = { 1767, 5, 33158, 33159, 33160, 33161, 33162 },
    enlightenment = { 1772, 5, 34908, 34909, 34910, 34911, 34912 },
    focused_mind = { 1777, 3, 33213, 33214, 33215 },
    focused_power = { 1771, 2, 33186, 33190 },
    focused_will = { 1858, 3, 45234, 45243, 45244 },
    force_of_will = { 1202, 5, 18544, 18547, 18548, 18549, 18550 },
    healing_focus = { 410, 2, 14913, 15012 },
    healing_prayers = { 413, 2, 14911, 15018 },
    holy_concentration = { 1768, 3, 34753, 34859, 34860 },
    holy_nova = { 442, 1, 15237 },
    holy_reach = { 1635, 2, 27789, 27790 },
    holy_specialization = { 401, 5, 14889, 15008, 15009, 15010, 15011 },
    improved_divine_spirit = { 1770, 2, 33174, 33182 },
    improved_fade = { 483, 2, 15274, 15311 },
    improved_healing = { 408, 3, 14912, 15013, 15014 },
    improved_inner_fire = { 346, 3, 14747, 14770, 14771 },
    improved_mana_burn = { 350, 2, 14750, 14772 },
    improved_mind_blast = { 481, 5, 15273, 15312, 15313, 15314, 15316 },
    improved_power_word_fortitude = { 344, 2, 14749, 14767 },
    improved_power_word_shield = { 343, 3, 14748, 14768, 14769 },
    improved_psychic_scream = { 542, 2, 15392, 15448 },
    improved_renew = { 406, 3, 14908, 15020, 17191 },
    improved_shadow_word_pain = { 482, 2, 15275, 15317 },
    improved_vampiric_embrace = { 1638, 2, 27839, 27840 },
    inner_focus = { 348, 1, 14751 },
    inspiration = { 361, 3, 14892, 15362, 15363 },
    lightwell = { 1637, 1, 724 },
    martyrdom = { 321, 2, 14531, 14774 },
    meditation = { 347, 3, 14521, 14776, 14777 },
    mental_agility = { 341, 5, 14520, 14780, 14781, 14782, 14783 },
    mental_strength = { 1201, 5, 18551, 18552, 18553, 18554, 18555 },
    mind_flay = { 501, 1, 15407 },
    misery = { 1816, 5, 33191, 33192, 33193, 33194, 33195 },
    pain_suppression = { 1774, 1, 33206 },
    power_infusion = { 322, 1, 10060 },
    reflective_shield = { 1773, 5, 33201, 33202, 33203, 33204, 33205 },
    searing_light = { 403, 2, 14909, 15017 },
    shadow_affinity = { 466, 3, 15318, 15272, 15320 },
    shadow_focus = { 463, 5, 15260, 15327, 15328, 15329, 15330 },
    shadow_power = { 1778, 5, 33221, 33222, 33223, 33224, 33225 },
    shadow_reach = { 881, 2, 17322, 17323 },
    shadow_resilience = { 1781, 2, 14910, 33371 },
    shadow_weaving = { 461, 5, 15257, 15331, 15332, 15333, 15334 },
    shadowform = { 521, 1, 15473 },
    silence = { 541, 1, 15487 },
    silent_resolve = { 352, 5, 14523, 14784, 14785, 14786, 14787 },
    spell_warding = { 411, 5, 27900, 27901, 27902, 27903, 27904 },
    spirit_of_redemption = { 1561, 1, 20711 },
    spirit_tap = { 465, 5, 15270, 15335, 15336, 15337, 15338 },
    spiritual_guidance = { 402, 5, 14901, 15028, 15029, 15030, 15031 },
    spiritual_healing = { 404, 5, 14898, 15349, 15354, 15355, 15356 },
    surge_of_light = { 1766, 2, 33150, 33154 },
    unbreakable_will = { 342, 5, 14522, 14788, 14789, 14790, 14791 },
    vampiric_embrace = { 484, 1, 15286 },
    vampiric_touch = { 1779, 1, 34914 },
    wand_specialization = { 345, 5, 14524, 14525, 14526, 14527, 14528 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    abolish_disease = {
        id = 552,
        duration = 20,
        tick_time = 5,
        max_stack = 1,
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    arcane_torrent = {
        id = 28730,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    blessed_recovery = {
        id = 27811,
        duration = 6,
        tick_time = 2,
        max_stack = 1,
        copy = { 27811, 27813, 27815, 27816, 27817, 27818 },
        -- Aura effects: PERIODIC_HEAL, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    blessed_resilience = {
        id = 33142,
        duration = 6,
        max_stack = 1,
        copy = { 33142, 33143, 33145, 33146 },
        -- Aura effects: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    chastise = {
        id = 44041,
        duration = 2,
        max_stack = 1,
        copy = { 44041, 44043, 44044, 44045, 44046, 44047 },
        -- Aura effects: MOD_ROOT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    clearcasting = {
        id = 34754,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    devouring_plague = {
        id = 2944,
        duration = 24,
        tick_time = 3,
        max_stack = 1,
        copy = { 2944, 19276, 19277, 19278, 19279, 19280, 25467 },
        -- Aura effects: PERIODIC_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    divine_spirit = {
        id = 14752,
        duration = 1800,
        max_stack = 1,
        copy = { 14752, 14818, 14819, 25312, 27841 },
        -- Aura effects: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, MOD_SPELL_HEALING_OF_STAT_PERCENT, MOD_STAT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    elunes_grace = {
        id = 2651,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_ATTACKER_MELEE_HIT_CHANCE, MOD_ATTACKER_RANGED_HIT_CHANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fade = {
        id = 586,
        duration = 10,
        max_stack = 1,
        copy = { 586, 9578, 9579, 9592, 10941, 10942, 25429 },
        -- Aura effects: MOD_TOTAL_THREAT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fear_ward = {
        id = 6346,
        duration = 180,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    feedback = {
        id = 13896,
        duration = 15,
        max_stack = 1,
        copy = { 13896, 19271, 19273, 19274, 19275, 25441 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    focused_casting = {
        id = 14743,
        duration = 6,
        max_stack = 1,
        copy = { 14743, 27828 },
        -- Aura effects: ADD_PCT_MODIFIER, MOD_MECHANIC_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    focused_will = {
        id = 45234,
        duration = 8,
        max_stack = 3,
        copy = { 45234, 45237, 45241, 45242, 45243, 45244 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, MOD_HEALING_PCT, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    hex_of_weakness = {
        id = 9035,
        duration = 120,
        max_stack = 1,
        copy = { 9035, 19281, 19282, 19283, 19284, 19285, 25470 },
        -- Aura effects: MOD_DAMAGE_DONE, MOD_HEALING_PCT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    holy_fire = {
        id = 14914,
        duration = 10,
        tick_time = 2,
        max_stack = 1,
        copy = { 14914, 15261, 15262, 15263, 15264, 15265, 15266, 15267, 25384 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    inner_fire = {
        id = 588,
        duration = 600,
        max_stack = 1,
        copy = { 588, 602, 1006, 7128, 10951, 10952, 25431 },
        -- Aura effects: MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    inner_focus = {
        id = 14751,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER, ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    levitate = {
        id = 1706,
        duration = 120,
        max_stack = 1,
        -- Aura effects: FEATHER_FALL, HOVER, WATER_WALK
        -- Aura targets: TARGET_UNIT_CASTER
    },

    lightwell_renew = {
        id = 7001,
        duration = 6,
        tick_time = 2,
        max_stack = 1,
        copy = { 7001, 27873, 27874, 28276 },
        -- Aura effects: PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    mind_control = {
        id = 605,
        duration = 60,
        max_stack = 1,
        copy = { 605, 10911, 10912 },
        -- Aura effects: DUMMY, MOD_MELEE_HASTE, MOD_POSSESS
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    mind_flay = {
        id = 15407,
        duration = 3,
        tick_time = 1,
        max_stack = 1,
        copy = { 15407, 17311, 17312, 17313, 17314, 18807, 25387 },
        -- Aura effects: MOD_DECREASE_SPEED, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    mind_soothe = {
        id = 453,
        duration = 15,
        max_stack = 1,
        copy = { 453, 8192, 10953, 25596 },
        -- Aura effects: MOD_DETECT_RANGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    mind_vision = {
        id = 2096,
        duration = 60,
        max_stack = 1,
        copy = { 2096, 10909 },
        -- Aura effects: BIND_SIGHT, DUMMY, MOD_STALKED
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ANY
    },

    misery = {
        id = 33191,
        duration = 24,
        max_stack = 1,
        copy = { 33191, 33192, 33193, 33194, 33195, 33196, 33197, 33198, 33199, 33200 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, OVERRIDE_CLASS_SCRIPTS, PROC_TRIGGER_SPELL
        -- Aura targets: NONE, TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    pain_suppression = {
        id = 33206,
        duration = 8,
        max_stack = 1,
        copy = { 33206, 44416 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, MOD_DISPEL_RESIST
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    power_infusion = {
        id = 10060,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_CASTING_SPEED_NOT_STACK, MOD_POWER_COST_SCHOOL_PCT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    power_word_fortitude = {
        id = 1243,
        duration = 1800,
        max_stack = 1,
        copy = { 1243, 1244, 1245, 2791, 10937, 10938, 25389 },
        -- Aura effects: MOD_STAT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    power_word_shield = {
        id = 17,
        duration = 30,
        max_stack = 1,
        copy = { 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 },
        -- Aura effects: SCHOOL_ABSORB
        -- Aura targets: TARGET_UNIT_TARGET_RAID
    },

    prayer_of_fortitude = {
        id = 21562,
        duration = 3600,
        max_stack = 1,
        copy = { 21562, 21564, 25392 },
        -- Aura effects: MOD_STAT
        -- Aura targets: TARGET_UNIT_LASTTARGET_AREA_PARTY, TARGET_UNIT_TARGET_ALLY
    },

    prayer_of_shadow_protection = {
        id = 27683,
        duration = 1200,
        max_stack = 1,
        copy = { 27683, 39374 },
        -- Aura effects: MOD_RESISTANCE_EXCLUSIVE
        -- Aura targets: TARGET_UNIT_LASTTARGET_AREA_PARTY, TARGET_UNIT_TARGET_ALLY
    },

    prayer_of_spirit = {
        id = 27681,
        duration = 3600,
        max_stack = 1,
        copy = { 27681, 32999 },
        -- Aura effects: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, MOD_SPELL_HEALING_OF_STAT_PERCENT, MOD_STAT
        -- Aura targets: TARGET_UNIT_LASTTARGET_AREA_PARTY, TARGET_UNIT_TARGET_ALLY
    },

    psychic_scream = {
        id = 8122,
        duration = 8,
        max_stack = 1,
        copy = { 8122, 8124, 10888, 10890 },
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    renew = {
        id = 139,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25221, 25222, 25315 },
        -- Aura effects: MOD_RESISTANCE, PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    shackle_undead = {
        id = 9484,
        duration = 50,
        max_stack = 1,
        copy = { 9484, 9485, 10955 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    shadow_protection = {
        id = 976,
        duration = 600,
        max_stack = 1,
        copy = { 976, 10957, 10958, 25433 },
        -- Aura effects: MOD_RESISTANCE_EXCLUSIVE
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    shadow_word_pain = {
        id = 589,
        duration = 18,
        tick_time = 3,
        max_stack = 1,
        copy = { 589, 594, 970, 992, 2767, 10892, 10893, 10894, 25367, 25368 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    shadowform = {
        id = 15473,
        max_stack = 1,
        -- Aura effects: MOD_DAMAGE_PERCENT_DONE, MOD_DAMAGE_PERCENT_TAKEN, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shadowguard = {
        id = 18137,
        duration = 600,
        max_stack = 1,
        copy = { 18137, 19308, 19309, 19310, 19311, 19312, 25477, 28377, 28378, 28379, 28380, 28381, 28382, 28385 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    silence = {
        id = 15487,
        duration = 5,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    starshards = {
        id = 10797,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 10797, 19296, 19299, 19302, 19303, 19304, 19305, 25446 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    surge_of_light = {
        id = 33150,
        duration = 10,
        max_stack = 1,
        copy = { 33150, 33151, 33154 },
        -- Aura effects: ADD_PCT_MODIFIER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    symbol_of_hope = {
        id = 32548,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_POWER_REGEN
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_PARTY
    },

    touch_of_weakness = {
        id = 2652,
        duration = 600,
        max_stack = 1,
        copy = { 2652, 2943, 19249, 19251, 19252, 19253, 19254, 19261, 19262, 19264, 19265, 19266, 25460, 25461 },
        -- Aura effects: MOD_DAMAGE_DONE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    vampiric_embrace = {
        id = 15286,
        duration = 60,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    vampiric_touch = {
        id = 34914,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 34914, 34916, 34917, 34919 },
        -- Aura effects: DUMMY, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

} )

local shadowform_conflicts = {
    "spirit_of_redemption",
}

local function clearShadowformConflicts()
    if not buff then return end

    for i = 1, #shadowform_conflicts do
        local conflict = shadowform_conflicts[ i ]
        if buff[ conflict ] then
            removeBuff( conflict )
        end
    end
end

local function applyShadowWeavingStack()
    if not debuff or not debuff.shadow_weaving then return end
    if talent and talent.shadow_weaving and talent.shadow_weaving.enabled == false then return end

    if debuff.shadow_weaving.up then
        applyDebuff( "target", "shadow_weaving", nil, min( debuff.shadow_weaving.max_stack or 1, ( debuff.shadow_weaving.stack or 0 ) + 1 ) )
    else
        applyDebuff( "target", "shadow_weaving", nil, 1 )
    end
end

-- Abilities (Hekili-style scaffold)
spec:RegisterAbilities( {

-- Abolish Disease - Attempts to cure 1 disease effect on the target, and 1 more disease effect every $t1 seconds for 20 sec.
    abolish_disease = {
        id = 552,
        cast = 0,
        duration = 20,
        gcd = "spell",
        school = "holy",
        texture = 136066,
        range = 40,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 552 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0, trigger_spell_id: 10872
        -- [ ] Rank 552 #1 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "abolish_disease" )
        end,
    },

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

-- Binding Heal - Heals a friendly target and the caster for 1042. Low threat.
    binding_heal = {
        id = 32546,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135883,
        range = 40,
        spend = 705,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32546 #0 -- effect: HEAL, aura: NONE, points: 1041, addl_points: 297, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 32546 #1 -- effect: HEAL, aura: NONE, points: 1041, addl_points: 297, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Blessed Recovery - After being struck by a melee or ranged critical hit, heal 1/8/16/25% of the damage taken over $27813d.
    blessed_recovery = {
        id = 27811,
        cast = 0,
        duration = 6,
        gcd = "spell",
        school = "physical",
        texture = 135877,
        max_stack = 1,
        copy = { 27811, 27813, 27815, 27816, 27817, 27818 },

        -- Effects:
        -- [x] Rank 27811 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [x] Rank 27813 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27815 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 15, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [x] Rank 27816 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 18350
        -- [x] Rank 27817 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27818 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blessed_recovery" )
        end,

        proc_chance = 100,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Blessed Resilience - Critical hits made against you have a $h% chance to prevent you from being critically hit again for $33143d.
    blessed_resilience = {
        id = 33142,
        cast = 0,
        duration = 6,
        texture = 135878,
        max_stack = 1,
        copy = { 33142, 33143, 33145, 33146 },

        -- Effects:
        -- [x] Rank 33142 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33143
        -- [x] Rank 33143 #0 -- effect: APPLY_AURA, aura: MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE, points: -1001, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33145 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33143
        -- [x] Rank 33146 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33143

        handler = function ()
            applyBuff( "blessed_resilience" )
        end,

        proc_chance = 20,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Chastise - Chastise the target, causing 47-370 Holy damage and Immobilizing them for up to 2 sec. Only works against Humanoids. This spell causes very low threat.
    chastise = {
        id = 44041,
        cast = 0,
        duration = 2,
        category_cooldown = 30,
        gcd = "spell",
        school = "holy",
        texture = 135886,
        cooldown_category_id = 1188,
        cooldown_category = "Chastise",
        range = 20,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 44041, 44043, 44044, 44045, 44046, 44047 },

        -- Effects:
        -- [x] Rank 44041 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 46, addl_points: 7, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44041 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 44043 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 92, addl_points: 15, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44043 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 44044 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 23, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44044 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 44045 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 208, addl_points: 33, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44045 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 44046 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 277, addl_points: 45, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44046 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 44047 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 369, addl_points: 61, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 44047 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "chastise" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "chastise" ) end
        end,

        proc_chance = 100,
    },

-- Circle of Healing - Heals friendly target and that target's party members within $a1 yards of the target for 246/288/327/370/409.
    circle_of_healing = {
        id = 34861,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135887,
        range = 40,
        spend = 300,
        spendType = "Mana",
        max_stack = 1,
        copy = { 34861, 34863, 34864, 34865, 34866 },

        -- Effects:
        -- [ ] Rank 34861 #0 -- effect: HEAL, aura: NONE, points: 245, addl_points: 25, points_per_level: 1, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [ ] Rank 34863 #0 -- effect: HEAL, aura: NONE, points: 287, addl_points: 31, points_per_level: 1.2, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [ ] Rank 34864 #0 -- effect: HEAL, aura: NONE, points: 326, addl_points: 35, points_per_level: 1.4, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [ ] Rank 34865 #0 -- effect: HEAL, aura: NONE, points: 369, addl_points: 39, points_per_level: 1.6, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [ ] Rank 34866 #0 -- effect: HEAL, aura: NONE, points: 408, addl_points: 43, points_per_level: 1.8, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
    },

-- Clearcasting - Your next Flash Heal, Binding Heal, or Greater Heal spell has its mana cost reduced by 100%.
    clearcasting = {
        id = 34754,
        cast = 0,
        duration = 15,
        school = "arcane",
        texture = 135905,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 34754 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "clearcasting" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 16384, 0 },
        -- Proc type flags: mask0: Deal Helpful Spell
    },

-- Consume Magic - Dispels one beneficial Magic effect from the caster and gives them 120 mana. The dispelled effect must be a priest spell.
    consume_magic = {
        id = 32676,
        cast = 0,
        cooldown = 120,
        gcd = "spell",
        school = "arcane",
        texture = 135754,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32676 #0 -- effect: ENERGIZE, aura: NONE, points: 119, addl_points: 35, points_per_level: 10.8, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Cure Disease - Removes 1 $ldisease:diseases; from the friendly target.
    cure_disease = {
        id = 528,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135935,
        range = 40,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 528 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Desperate Prayer - Instantly heals the caster for 134-1601.
    desperate_prayer = {
        id = 13908,
        cast = 0,
        category_cooldown = 600,
        gcd = "spell",
        school = "holy",
        texture = 135954,
        cooldown_category_id = 671,
        cooldown_category = "Desperate Prayer",
        max_stack = 1,
        copy = { 13908, 19236, 19238, 19240, 19241, 19242, 19243, 25437 },

        -- Effects:
        -- [ ] Rank 13908 #0 -- effect: HEAL, aura: NONE, points: 133, addl_points: 37, points_per_level: 2.4, sp_bonus: 0.268, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19236 #0 -- effect: HEAL, aura: NONE, points: 262, addl_points: 63, points_per_level: 3.4, sp_bonus: 0.396, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19238 #0 -- effect: HEAL, aura: NONE, points: 446, addl_points: 97, points_per_level: 4.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19240 #0 -- effect: HEAL, aura: NONE, points: 587, addl_points: 121, points_per_level: 5.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19241 #0 -- effect: HEAL, aura: NONE, points: 833, addl_points: 161, points_per_level: 6.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19242 #0 -- effect: HEAL, aura: NONE, points: 1100, addl_points: 205, points_per_level: 7.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19243 #0 -- effect: HEAL, aura: NONE, points: 1323, addl_points: 239, points_per_level: 8.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 25437 #0 -- effect: HEAL, aura: NONE, points: 1600, addl_points: 287, points_per_level: 9.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

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

-- Devouring Plague - Afflicts the target with a disease that causes 152-1216 Shadow damage over 24 sec. Damage caused by the Devouring Plague heals the caster.
    devouring_plague = {
        id = 2944,
        cast = 0,
        duration = 24,
        category_cooldown = 180,
        gcd = "spell",
        school = "shadow",
        texture = 136123,
        cooldown_category_id = 691,
        cooldown_category = "Devouring Plague",
        range = 30,
        spend = 215,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2944, 19276, 19277, 19278, 19279, 19280, 25467 },

        -- Effects:
        -- [x] Rank 2944 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 18, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19276 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 33, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19277 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19278 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 67, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19279 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 88, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19280 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 112, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25467 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 151, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "devouring_plague" )
        end,

        proc_chance = 100,
    },

-- Dispel Magic - Dispels magic on the target, removing 1/2 harmful $lspell:spells; from a friend or 1/2 beneficial $lspell:spells; from an enemy.
    dispel_magic = {
        id = 527,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135894,
        range = 30,
        spend_pct = 14,
        spendType = "Mana",
        max_stack = 1,
        copy = { 527, 988 },

        -- Effects:
        -- [ ] Rank 527 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 988 #0 -- effect: DISPEL, aura: NONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
    },

-- Divine Spirit - Holy power infuses the target, increasing their Spirit by 17/23/33/40/50 for 1800 sec.
    divine_spirit = {
        id = 14752,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135898,
        range = 30,
        spend = 250,
        spendType = "Mana",
        max_stack = 1,
        copy = { 14752, 14818, 14819, 25312, 27841 },

        -- Effects:
        -- [x] Rank 14752 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14752 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14752 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14818 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 22, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14818 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14818 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14819 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14819 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 14819 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25312 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25312 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25312 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27841 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27841 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27841 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "divine_spirit" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Elune's Grace - Reduces the chance you'll be hit by melee and ranged attacks by 20% for 15 sec.
    elunes_grace = {
        id = 2651,
        cast = 0,
        duration = 15,
        category_cooldown = 180,
        gcd = "spell",
        school = "holy",
        texture = 135900,
        cooldown_category_id = 1144,
        cooldown_category = "Priest Racial",
        spend_pct = 3,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2651 #0 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 2651 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "elunes_grace" )
        end,
    },

-- Fade - Fade out, discouraging enemies from attacking you for 10 sec.
    fade = {
        id = 586,
        cast = 0,
        duration = 10,
        cooldown = function () return max( 0, 30 + -3 * ( talent.improved_fade.rank or 0 ) ) end,
        category_cooldown = 30,
        gcd = "spell",
        school = "shadow",
        texture = 135994,
        cooldown_category_id = 82,
        cooldown_category = "Taunt/Detaunt",
        spend = 40,
        -- Talent cooldown scaling (category source): improved_fade (-3s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 586, 9578, 9579, 9592, 10941, 10942, 25429 },

        -- Effects:
        -- [x] Rank 586 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -56, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9578 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -156, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9579 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -286, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9592 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -441, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10941 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -621, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10942 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -821, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25429 #0 -- effect: APPLY_AURA, aura: MOD_TOTAL_THREAT, points: -1501, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "fade" )
        end,

        proc_chance = 100,
    },

-- Fear Ward - Wards the friendly target against Fear. The next Fear effect used against the target will fail, using up the ward. Lasts 180 sec.
    fear_ward = {
        id = 6346,
        cast = 0,
        duration = 180,
        cooldown = 180,
        gcd = "spell",
        school = "holy",
        texture = 135902,
        range = 30,
        spend_pct = 3,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 6346 #0 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "fear_ward" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139264, 0 },
        -- Proc type flags: mask0: Take Harmful Ability; Take Harmful Spell
    },

-- Feedback - The priest becomes surrounded with anti-magic energy. Any successful spell cast against the priest will burn 18 of the attacker's Mana, causing 1 Shadow damage for each point of Mana burned. Lasts 15 sec.
    feedback = {
        id = 13896,
        cast = 0,
        duration = 15,
        category_cooldown = 180,
        gcd = "spell",
        school = "shadow",
        texture = 136189,
        cooldown_category_id = 1144,
        cooldown_category = "Priest Racial",
        spend = 140,
        spendType = "Mana",
        max_stack = 1,
        copy = { 13896, 19271, 19273, 19274, 19275, 25441 },

        -- Effects:
        -- [x] Rank 13896 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6347
        -- [x] Rank 19271 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19267
        -- [x] Rank 19273 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19268
        -- [x] Rank 19274 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19269
        -- [x] Rank 19275 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19270
        -- [x] Rank 25441 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 25440

        handler = function ()
            applyBuff( "feedback" )
        end,

        proc_chance = 100,
        proc_type_mask = { 131072, 0 },
        -- Proc type flags: mask0: Take Harmful Spell
    },

-- Flash Heal - Heals a friendly target for 193-1101.
    flash_heal = {
        id = 2061,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135907,
        range = 40,
        spend = 125,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2061, 9472, 9473, 9474, 10915, 10916, 10917, 25233, 25235 },

        -- Effects:
        -- [ ] Rank 2061 #0 -- effect: HEAL, aura: NONE, points: 192, addl_points: 45, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9472 #0 -- effect: HEAL, aura: NONE, points: 257, addl_points: 57, points_per_level: 2.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9473 #0 -- effect: HEAL, aura: NONE, points: 326, addl_points: 67, points_per_level: 2.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9474 #0 -- effect: HEAL, aura: NONE, points: 399, addl_points: 79, points_per_level: 2.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10915 #0 -- effect: HEAL, aura: NONE, points: 517, addl_points: 99, points_per_level: 3.3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10916 #0 -- effect: HEAL, aura: NONE, points: 643, addl_points: 121, points_per_level: 3.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10917 #0 -- effect: HEAL, aura: NONE, points: 811, addl_points: 147, points_per_level: 4.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25233 #0 -- effect: HEAL, aura: NONE, points: 912, addl_points: 147, points_per_level: 4.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25235 #0 -- effect: HEAL, aura: NONE, points: 1100, addl_points: 179, points_per_level: 5.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Focused Casting - When cast, you no longer lose casting time due to taking damage. Lasts 6 sec.
    focused_casting = {
        id = 14743,
        cast = 0,
        duration = 6,
        school = "holy",
        texture = 135736,
        max_stack = 1,
        copy = { 14743, 27828 },

        -- Effects:
        -- [x] Rank 14743 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14743 #1 -- effect: APPLY_AURA, aura: MOD_MECHANIC_RESISTANCE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27828 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27828 #1 -- effect: APPLY_AURA, aura: MOD_MECHANIC_RESISTANCE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "focused_casting" )
        end,
    },

-- Focused Will - After taking a critical hit you gain the Focused Will effect, reducing all damage taken by 2% and increasing healing effects on you by 4%. Stacks up to $45237u times. Lasts $45237d.
    focused_will = {
        id = 45234,
        cast = 0,
        duration = 8,
        texture = 135737,
        max_stack = 3,
        copy = { 45234, 45237, 45241, 45242, 45243, 45244 },

        -- Effects:
        -- [x] Rank 45234 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 45237
        -- [x] Rank 45237 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45237 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45241 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45241 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45242 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45242 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 45243 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 45241
        -- [x] Rank 45244 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 45242

        handler = function ()
            if buff.focused_will.up then
                applyBuff( "focused_will", nil, min( buff.focused_will.max_stack, buff.focused_will.stack + 1 ) )
            else
                applyBuff( "focused_will" )
            end
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Greater Heal - A slow casting spell that heals a single target for 899-2396.
    greater_heal = {
        id = 2060,
        cast = 3,
        gcd = "spell",
        school = "holy",
        texture = 135913,
        range = 40,
        spend = 370,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2060, 10963, 10964, 10965, 25210, 25213, 25314 },

        -- Effects:
        -- [ ] Rank 2060 #0 -- effect: HEAL, aura: NONE, points: 898, addl_points: 115, points_per_level: 5.1, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10963 #0 -- effect: HEAL, aura: NONE, points: 1148, addl_points: 141, points_per_level: 5.8, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10964 #0 -- effect: HEAL, aura: NONE, points: 1436, addl_points: 173, points_per_level: 6.6, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 10965 #0 -- effect: HEAL, aura: NONE, points: 1797, addl_points: 209, points_per_level: 7.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25210 #0 -- effect: HEAL, aura: NONE, points: 2073, addl_points: 337, points_per_level: 8.4, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25213 #0 -- effect: HEAL, aura: NONE, points: 2395, addl_points: 389, points_per_level: 9.3, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25314 #0 -- effect: HEAL, aura: NONE, points: 1965, addl_points: 229, points_per_level: 8.1, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Heal - Heal your target for 295/429/566/712.
    heal = {
        id = 2054,
        cast = 3,
        gcd = "spell",
        school = "holy",
        texture = 135915,
        range = 40,
        spend = 155,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2054, 2055, 6063, 6064 },

        -- Effects:
        -- [ ] Rank 2054 #0 -- effect: HEAL, aura: NONE, points: 294, addl_points: 47, points_per_level: 2.4, sp_bonus: 0.729, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 2055 #0 -- effect: HEAL, aura: NONE, points: 428, addl_points: 63, points_per_level: 3.2, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 6063 #0 -- effect: HEAL, aura: NONE, points: 565, addl_points: 77, points_per_level: 4, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 6064 #0 -- effect: HEAL, aura: NONE, points: 711, addl_points: 93, points_per_level: 4.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Hex of Weakness - Weakens the target enemy, reducing damage caused by 2-35 and reducing the effectiveness of any healing by 20%. Lasts 120 sec.
    hex_of_weakness = {
        id = 9035,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "shadow",
        texture = 136157,
        range = 30,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 9035, 19281, 19282, 19283, 19284, 19285, 25470 },

        -- Effects:
        -- [x] Rank 9035 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9035 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19281 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19281 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19282 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19282 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19283 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19283 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19284 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19284 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19285 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19285 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25470 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25470 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "hex_of_weakness" )
        end,

        proc_chance = 100,
    },

-- Holy Fire - Consumes the enemy in Holy flames that cause 78-412 Holy damage and an additional 30-165 Holy damage over 10 sec.
    holy_fire = {
        id = 14914,
        cast = 3.5,
        duration = 10,
        gcd = "spell",
        school = "holy",
        texture = 135972,
        cooldown_category_id = 451,
        cooldown_category = "Holy Fire",
        range = 30,
        spend = 85,
        spendType = "Mana",
        max_stack = 1,
        copy = { 14914, 15261, 15262, 15263, 15264, 15265, 15266, 15267, 25384 },

        -- Effects:
        -- [x] Rank 14914 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 77, addl_points: 21, points_per_level: 1.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14914 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15261 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 354, addl_points: 95, points_per_level: 3.4, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15261 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 28, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15262 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 95, addl_points: 25, points_per_level: 1.7, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15262 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15263 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 131, addl_points: 35, points_per_level: 2, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15263 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15264 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 164, addl_points: 45, points_per_level: 2.2, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15264 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15265 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 203, addl_points: 55, points_per_level: 2.5, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15265 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15266 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 253, addl_points: 69, points_per_level: 2.9, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15266 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15267 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 303, addl_points: 83, points_per_level: 3.2, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15267 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25384 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 411, addl_points: 111, points_per_level: 3.6, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25384 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0.033, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "holy_fire" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "holy_fire" ) end
        end,

        proc_chance = 100,
    },

-- Holy Nova - Causes an explosion of holy light around the caster, causing 28-384 Holy damage to all enemy targets within $a1 yards and healing all party members within $23455a1 yards for 52. These effects cause no threat.
    holy_nova = {
        id = 15237,
        cast = 0,
        gcd = "spell",
        school = "holy",
        texture = 135922,
        cooldown_category_id = 431,
        cooldown_category = "Holy Nova",
        spend = 185,
        spendType = "Mana",
        max_stack = 1,
        copy = { 15237, 15430, 15431, 23455, 23458, 23459, 25329, 25331, 27799, 27800, 27801, 27803, 27804, 27805 },

        -- Effects:
        -- [x] Rank 15237 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 27, addl_points: 5, points_per_level: 0.2, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 15430 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 49, addl_points: 9, points_per_level: 0.4, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 15431 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 75, addl_points: 13, points_per_level: 0.6, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 23455 #0 -- effect: HEAL, aura: NONE, points: 51, addl_points: 9, points_per_level: 0.4, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 23458 #0 -- effect: HEAL, aura: NONE, points: 85, addl_points: 13, points_per_level: 0.5, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 23459 #0 -- effect: HEAL, aura: NONE, points: 120, addl_points: 19, points_per_level: 0.6, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 25329 #0 -- effect: HEAL, aura: NONE, points: 383, addl_points: 63, points_per_level: 1, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [x] Rank 25331 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 241, addl_points: 39, points_per_level: 1.4, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27799 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 105, addl_points: 17, points_per_level: 0.8, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27800 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 139, addl_points: 23, points_per_level: 1, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27801 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 180, addl_points: 29, points_per_level: 1.2, sp_bonus: 0.161, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 27803 #0 -- effect: HEAL, aura: NONE, points: 160, addl_points: 27, points_per_level: 0.7, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 27804 #0 -- effect: HEAL, aura: NONE, points: 234, addl_points: 37, points_per_level: 0.8, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 27805 #0 -- effect: HEAL, aura: NONE, points: 301, addl_points: 49, points_per_level: 0.9, sp_bonus: 0.161, radius_idx: 13, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "holy_nova" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Inner Fire - A burst of Holy energy fills the caster, increasing armor by 315-1580. Each melee or ranged damage hit against the priest will remove one charge. Lasts 600 sec or until $n charges are used.
    inner_fire = {
        id = 588,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "holy",
        texture = 135926,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 588, 602, 1006, 7128, 10951, 10952, 25431 },

        -- Effects:
        -- [x] Rank 588 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 314, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 602 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 719, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1006 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 944, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 7128 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 494, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10951 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 1169, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10952 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 1394, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25431 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 1579, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "inner_fire" )
        end,

        proc_chance = 100,
        proc_charges = 20,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability
    },

-- Inner Focus - When activated, reduces the mana cost of your next spell by 100% and increases its critical effect chance by 25% if it is capable of a critical effect.
    inner_focus = {
        id = 14751,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 135863,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 14751 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14751 #1 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "inner_focus" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Lesser Heal - Heal your target for 46/71/135.
    lesser_heal = {
        id = 2050,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135929,
        range = 40,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2050, 2052, 2053 },

        -- Effects:
        -- [ ] Rank 2050 #0 -- effect: HEAL, aura: NONE, points: 45, addl_points: 11, points_per_level: 0.9, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 2052 #0 -- effect: HEAL, aura: NONE, points: 70, addl_points: 15, points_per_level: 1.1, sp_bonus: 0.229, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 2053 #0 -- effect: HEAL, aura: NONE, points: 134, addl_points: 23, points_per_level: 1.6, sp_bonus: 0.446, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Levitate - Allows the caster to levitate, floating a few feet above the ground. While levitating, you will fall at a reduced speed and travel over water. Any damage will cancel the effect. Lasts 120 sec.
    levitate = {
        id = 1706,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "holy",
        texture = 135928,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1706 #0 -- effect: APPLY_AURA, aura: FEATHER_FALL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1706 #1 -- effect: APPLY_AURA, aura: HOVER, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1706 #2 -- effect: APPLY_AURA, aura: WATER_WALK, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "levitate" )
        end,
    },

-- Lightwell - Creates a Holy Lightwell. Members of your raid or party can click the Lightwell to restore $7001o1 health over $7001d. Any damage taken will cancel the effect. Lightwell lasts for 180 sec or 5 charges.
    lightwell = {
        id = 724,
        cast = 1.5,
        duration = 180,
        category_cooldown = 360,
        gcd = "spell",
        school = "holy",
        texture = 135980,
        cooldown_category_id = 1145,
        cooldown_category = "Lightwell",
        range = 40,
        spend = 225,
        spendType = "Mana",
        max_stack = 1,
        copy = { 724, 27870, 27871, 28275 },

        -- Effects:
        -- [ ] Rank 724 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_GAMEOBJECT_DEST_AREA, target2: NONE, mechanic: 0
        -- [ ] Rank 27870 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_GAMEOBJECT_DEST_AREA, target2: NONE, mechanic: 0
        -- [ ] Rank 27871 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_GAMEOBJECT_DEST_AREA, target2: NONE, mechanic: 0
        -- [ ] Rank 28275 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_GAMEOBJECT_DEST_AREA, target2: NONE, mechanic: 0

        radius = 2,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Lightwell Renew - Restore 267/388/533/787 health every $t1 sec.
    lightwell_renew = {
        id = 7001,
        cast = 0,
        duration = 6,
        school = "holy",
        texture = 135980,
        range = 5,
        max_stack = 1,
        copy = { 7001, 27873, 27874, 28276 },

        -- Effects:
        -- [x] Rank 7001 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 266, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27873 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 387, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 27874 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 532, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 28276 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 786, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "lightwell_renew" )
        end,

        proc_chance = 100,
    },

-- Mana Burn - Destroy 191-1021 mana from a target. For each mana destroyed in this way, the target takes 0.5 Shadow damage.
    mana_burn = {
        id = 8129,
        cast = function () return max( 0, 3 + -0.5 * ( talent.improved_mana_burn.rank or 0 ) ) end,
        gcd = "spell",
        school = "shadow",
        texture = 136170,
        range = 30,
        spend = 95,
        -- Talent cast scaling: improved_mana_burn (-0.5s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 8129, 8131, 10874, 10875, 10876, 25379, 25380 },

        -- Effects:
        -- [ ] Rank 8129 #0 -- effect: POWER_BURN, aura: NONE, points: 190, addl_points: 13, points_per_level: 1.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8131 #0 -- effect: POWER_BURN, aura: NONE, points: 308, addl_points: 21, points_per_level: 1.3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10874 #0 -- effect: POWER_BURN, aura: NONE, points: 441, addl_points: 27, points_per_level: 1.6, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10875 #0 -- effect: POWER_BURN, aura: NONE, points: 575, addl_points: 35, points_per_level: 1.9, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 10876 #0 -- effect: POWER_BURN, aura: NONE, points: 737, addl_points: 43, points_per_level: 2.1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25379 #0 -- effect: POWER_BURN, aura: NONE, points: 875, addl_points: 49, points_per_level: 2.3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25380 #0 -- effect: POWER_BURN, aura: NONE, points: 1020, addl_points: 59, points_per_level: 2.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Mass Dispel - Dispels magic in a $a1 yard radius, removing 1 harmful $lspell:spells; from each friendly target and 1 beneficial $lspell:spells; from each enemy target. Affects a maximum of $i friendly targets and $i enemy targets. This dispel is potent enough to remove Magic effects that are normally undispellable.
    mass_dispel = {
        id = 32375,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135739,
        range = 30,
        spend_pct = 33,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32375 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 18, target: TARGET_UNIT_DEST_AREA_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 32375 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 32592
        startsCombat = true,

        radius = 15,

        proc_chance = 100,
    },

-- Mass Resurrection - Brings party members within $a1 yards back to life with 500 health and $q1 mana. Cannot be cast when in combat.
    mass_resurrection = {
        id = 32841,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135917,
        range = 20,
        spend_pct = 76,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32841 #0 -- effect: 329, aura: NONE, points: 499, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 27, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_PARTY, mechanic: 0

        radius = 50,

        proc_chance = 100,
    },

-- Mind Blast - Blasts the target for 39-708 Shadow damage.
    mind_blast = {
        id = 8092,
        cast = function () return max( 0, 1.5 + -0.5 * ( talent.improved_mind_blast.rank or 0 ) ) end,
        category_cooldown = 8,
        gcd = "spell",
        school = "shadow",
        texture = 136224,
        cooldown_category_id = 19,
        cooldown_category = "Quick Damage - Spell",
        range = 30,
        spend = 50,
        -- Talent cast scaling: improved_mind_blast (-0.5s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 8092, 8102, 8103, 8104, 8105, 8106, 10945, 10946, 10947, 25372, 25375 },

        -- Effects:
        -- [x] Rank 8092 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 38, addl_points: 5, points_per_level: 0.6, sp_bonus: 0.268, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8102 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 71, addl_points: 7, points_per_level: 0.9, sp_bonus: 0.364, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8103 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 111, addl_points: 9, points_per_level: 1.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8104 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 166, addl_points: 11, points_per_level: 1.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8105 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 216, addl_points: 15, points_per_level: 1.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8106 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 278, addl_points: 19, points_per_level: 1.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10945 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 345, addl_points: 21, points_per_level: 2.1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10946 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 424, addl_points: 25, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10947 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 502, addl_points: 29, points_per_level: 2.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25372 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 556, addl_points: 31, points_per_level: 2.9, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25375 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 707, addl_points: 41, points_per_level: 3.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "mind_blast" ) end
            applyShadowWeavingStack()
        end,

        proc_chance = 100,
    },

-- Mind Control - Controls a humanoid mind up to level 32/47/62, but increases the time between its attacks by 25%. Lasts up to 60 sec.
    mind_control = {
        id = 605,
        cast = 3,
        duration = 60,
        gcd = "spell",
        school = "shadow",
        texture = 136206,
        range = 20,
        spend = 350,
        spendType = "Mana",
        max_stack = 1,
        copy = { 605, 10911, 10912 },

        -- Effects:
        -- [x] Rank 605 #0 -- effect: APPLY_AURA, aura: MOD_POSSESS, points: 31, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 605 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 605 #2 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10911 #0 -- effect: APPLY_AURA, aura: MOD_POSSESS, points: 46, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10911 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10911 #2 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10912 #0 -- effect: APPLY_AURA, aura: MOD_POSSESS, points: 61, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10912 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 10912 #2 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 100,

        handler = function ()
            applyDebuff( "target", "mind_control" )
            applyBuff( "mind_control" )
        end,

        proc_chance = 100,
    },

-- Mind Flay - Assault the target's mind with Shadow energy, causing 75-528 Shadow damage over 3 sec and slowing their movement speed by 50%.
    mind_flay = {
        id = 15407,
        cast = 0,
        duration = 3,
        gcd = "spell",
        school = "shadow",
        texture = 136208,
        range = 20,
        spend = 45,
        spendType = "Mana",
        max_stack = 1,
        copy = { 15407, 17311, 17312, 17313, 17314, 18807, 25387 },

        -- Effects:
        -- [x] Rank 15407 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 15407 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 17311 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17311 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 17312 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 61, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17312 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 17313 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 86, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17313 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 17314 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17314 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 18807 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 141, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18807 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 25387 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 175, addl_points: 1, points_per_level: 0, sp_bonus: 0.19, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25387 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "mind_flay" )
            applyShadowWeavingStack()
        end,

        channeled = true,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Mind Soothe - Soothes the target, reducing the range at which it will attack you by 10 yards. Only affects Humanoid targets level $v or lower. Lasts 15 sec.
    mind_soothe = {
        id = 453,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "shadow",
        texture = 135933,
        range = 40,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 453, 8192, 10953, 25596 },

        -- Effects:
        -- [x] Rank 453 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8192 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10953 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25596 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "mind_soothe" )
        end,

        proc_chance = 100,
    },

-- Mind Vision - Allows the caster to see through the target's eyes for 60 sec.
    mind_vision = {
        id = 2096,
        cast = 0,
        duration = 60,
        gcd = "spell",
        school = "shadow",
        texture = 135934,
        range = 50000,
        spend = 65,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2096, 10909 },

        -- Effects:
        -- [ ] Rank 2096 #0 -- effect: APPLY_AURA, aura: BIND_SIGHT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 2096 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 2096 #2 -- effect: APPLY_AURA, aura: MOD_STALKED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 10909 #0 -- effect: APPLY_AURA, aura: BIND_SIGHT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 10909 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 10909 #2 -- effect: APPLY_AURA, aura: MOD_STALKED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "mind_vision" )
        end,

        proc_chance = 100,
    },

-- Misery - Your Shadow Word: Pain, Mind Flay and Vampiric Touch spells also cause the target to take an additional 1% spell damage.
    misery = {
        id = 33191,
        cast = 0,
        duration = 24,
        texture = 136176,
        max_stack = 1,
        copy = { 33191, 33192, 33193, 33194, 33195, 33196, 33197, 33198, 33199, 33200 },

        -- Effects:
        -- [x] Rank 33191 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33196
        -- [x] Rank 33191 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33192 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33197
        -- [x] Rank 33192 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33193 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33198
        -- [x] Rank 33193 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33194 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33199
        -- [ ] Rank 33194 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 33195 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33200
        -- [x] Rank 33195 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33196 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33197 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33198 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33199 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33200 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "misery" )
            applyBuff( "misery" )
        end,

        proc_chance = 100,
        proc_type_mask = { 65536, 0 },
        -- Proc type flags: mask0: Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Pain Suppression - Instantly reduces a friendly target's threat by 5%, reduces all damage taken by 5/40% and increases resistance to Dispel mechanics by 65% for 8 sec.
    pain_suppression = {
        id = 33206,
        cast = 0,
        duration = 8,
        cooldown = 120,
        gcd = "spell",
        school = "holy",
        texture = 135936,
        range = 40,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,
        copy = { 33206, 44416 },

        -- Effects:
        -- [x] Rank 33206 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 33206 #1 -- effect: APPLY_AURA, aura: MOD_DISPEL_RESIST, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 44416 #0 -- effect: MODIFY_THREAT_PERCENT, aura: NONE, points: -6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 100,

        handler = function ()
            applyBuff( "pain_suppression" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Power Infusion - Infuses the target with power, increasing spell casting speed by 20% and reducing the mana cost of all spells by 20%. Lasts 15 sec.
    power_infusion = {
        id = 10060,
        cast = 0,
        duration = 15,
        cooldown = 180,
        school = "holy",
        texture = 135939,
        range = 30,
        spend_pct = 16,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 10060 #0 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10060 #1 -- effect: APPLY_AURA, aura: MOD_POWER_COST_SCHOOL_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "power_infusion" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Power Word: Fortitude - Power infuses the target, increasing their Stamina by 3-79 for 1800 sec.
    power_word_fortitude = {
        id = 1243,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "holy",
        texture = 135987,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1243, 1244, 1245, 2791, 10937, 10938, 25389 },

        -- Effects:
        -- [x] Rank 1243 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1244 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1245 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 2791 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10937 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10938 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 53, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25389 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 78, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "power_word_fortitude" )
        end,

        proc_chance = 100,
    },

-- Power Word: Shield - Draws on the soul of the party member to shield them, absorbing 44-1265 damage. Lasts 30 sec. While the shield holds, spellcasting will not be interrupted by damage. Once shielded, the target cannot be shielded again for $6788d.
    power_word_shield = {
        id = 17,
        cast = 0,
        duration = 30,
        category_cooldown = 4,
        gcd = "spell",
        school = "holy",
        texture = 135940,
        cooldown_category_id = 56,
        cooldown_category = "Instant Heal - Spell",
        range = 40,
        spend = 45,
        spendType = "Mana",
        max_stack = 1,
        copy = { 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901, 25217, 25218 },

        -- Effects:
        -- [ ] Rank 17 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 43, addl_points: 1, points_per_level: 0.8, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 592 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 87, addl_points: 1, points_per_level: 1.2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 600 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 157, addl_points: 1, points_per_level: 1.6, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 3747 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 233, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 6065 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 300, addl_points: 1, points_per_level: 2.3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 6066 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 380, addl_points: 1, points_per_level: 2.6, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10898 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 483, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10899 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 604, addl_points: 1, points_per_level: 3.4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10900 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 762, addl_points: 1, points_per_level: 3.9, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 10901 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 941, addl_points: 1, points_per_level: 4.3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 25217 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 1124, addl_points: 1, points_per_level: 4.7, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 25218 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 1264, addl_points: 1, points_per_level: 5.1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0

        handler = function ()
        end,

        proc_chance = 100,

        -- Aura restrictions: exclude_target_state=18
    },

-- Powerheal 4000 Lens
    powerheal_4000_lens = {
        id = 41321,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41321 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Powerheal 9000 Lens
    powerheal_9000_lens = {
        id = 46108,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46108 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Prayer of Fortitude - Power infuses the target's party, increasing their Stamina by 43/54/79 for 3600 sec.
    prayer_of_fortitude = {
        id = 21562,
        cast = 0,
        duration = 3600,
        gcd = "spell",
        school = "holy",
        texture = 135941,
        range = 40,
        spend = 1200,
        spendType = "Mana",
        max_stack = 1,
        copy = { 21562, 21564, 25392 },

        -- Effects:
        -- [x] Rank 21562 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21564 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 53, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 25392 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 78, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        handler = function ()
            applyBuff( "prayer_of_fortitude" )
        end,
    },

-- Prayer of Healing - A powerful prayer heals party members within $a1 yards for 301-1246.
    prayer_of_healing = {
        id = 596,
        cast = 3,
        gcd = "spell",
        school = "holy",
        texture = 135943,
        spend = 410,
        spendType = "Mana",
        max_stack = 1,
        copy = { 596, 996, 10960, 10961, 25308, 25316 },

        -- Effects:
        -- [ ] Rank 596 #0 -- effect: HEAL, aura: NONE, points: 300, addl_points: 21, points_per_level: 1.3, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 996 #0 -- effect: HEAL, aura: NONE, points: 443, addl_points: 29, points_per_level: 1.6, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 10960 #0 -- effect: HEAL, aura: NONE, points: 656, addl_points: 39, points_per_level: 2, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 10961 #0 -- effect: HEAL, aura: NONE, points: 938, addl_points: 53, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 25308 #0 -- effect: HEAL, aura: NONE, points: 1245, addl_points: 71, points_per_level: 2.8, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        -- [ ] Rank 25316 #0 -- effect: HEAL, aura: NONE, points: 996, addl_points: 57, points_per_level: 2.5, sp_bonus: 0.429, radius_idx: 10, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0

        radius = 30,
    },

-- Prayer of Mending - Places a spell on the target that heals them for 801 the next time they take damage. When the heal occurs, Prayer of Mending jumps to a raid member within $351575a1 yards. Jumps up to 6 times and lasts $41635d after each jump. This spell can only be placed on one target at a time.
    prayer_of_mending = {
        id = 33076,
        cast = 0,
        category_cooldown = 10,
        gcd = "spell",
        school = "holy",
        texture = 135944,
        cooldown_category_id = 1181,
        cooldown_category = "Prayer of Mending",
        range = 40,
        spend = 390,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 33076 #0 -- effect: DUMMY, aura: NONE, points: 800, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 33076 #1 -- effect: DUMMY, aura: NONE, points: 5, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
    },

-- Prayer of Shadow Protection - Power infuses the target's party, increasing their Shadow resistance by 60/70 for 1200 sec.
    prayer_of_shadow_protection = {
        id = 27683,
        cast = 0,
        duration = 1200,
        gcd = "spell",
        school = "holy",
        texture = 135945,
        range = 40,
        spend = 1300,
        spendType = "Mana",
        max_stack = 1,
        copy = { 27683, 39374 },

        -- Effects:
        -- [x] Rank 27683 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 39374 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        handler = function ()
            applyBuff( "prayer_of_shadow_protection" )
        end,
    },

-- Prayer of Spirit - Power infuses the target's party, increasing their Spirit by 40/50 for 3600 sec.
    prayer_of_spirit = {
        id = 27681,
        cast = 0,
        duration = 3600,
        gcd = "spell",
        school = "holy",
        texture = 135946,
        range = 40,
        spend = 1500,
        spendType = "Mana",
        max_stack = 1,
        copy = { 27681, 32999 },

        -- Effects:
        -- [x] Rank 27681 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 27681 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 27681 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 32999 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 32999 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_DAMAGE_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 32999 #2 -- effect: APPLY_AURA, aura: MOD_SPELL_HEALING_OF_STAT_PERCENT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        handler = function ()
            applyBuff( "prayer_of_spirit" )
        end,
    },

-- Psychic Scream - The caster lets out a psychic scream, causing $i enemies within $a1 yards to flee for 8 sec. Damage caused may interrupt the effect.
    psychic_scream = {
        id = 8122,
        cast = 0,
        duration = 8,
        cooldown = function () return max( 0, 30 + -2 * ( talent.improved_psychic_scream.rank or 0 ) ) end,
        category_cooldown = 30,
        gcd = "spell",
        school = "shadow",
        texture = 136184,
        cooldown_category_id = 43,
        cooldown_category = "Shout",
        spend = 100,
        -- Talent cooldown scaling (category source): improved_psychic_scream (-2s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 8122, 8124, 10888, 10890 },

        -- Effects:
        -- [ ] Rank 8122 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8122 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8124 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 8124 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 10888 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 10888 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 10890 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 10890 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 14, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Renew - Heals the target for 45-1110 over 15 sec.
    renew = {
        id = 139,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "holy",
        texture = 135953,
        range = 40,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25221, 25222, 25315 },

        -- Effects:
        -- [x] Rank 139 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0.11, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 139 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6074 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.155, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6074 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6075 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6075 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6076 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 48, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6076 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6077 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 62, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6077 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6078 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6078 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10927 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 101, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10927 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10928 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 129, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10928 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10929 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 161, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10929 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25221 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 201, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25221 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25222 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 221, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25222 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25315 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 193, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25315 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "renew" )
        end,
    },

-- Resurrection - Brings a dead player back to life with 70-1100 health and $q1 mana. Cannot be cast when in combat.
    resurrection = {
        id = 2006,
        cast = 10,
        gcd = "spell",
        school = "holy",
        texture = 135955,
        range = 30,
        spend_pct = 60,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2006, 2010, 10880, 10881, 20770, 25435 },

        -- Effects:
        -- [ ] Rank 2006 #0 -- effect: 329, aura: NONE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 2010 #0 -- effect: 329, aura: NONE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10880 #0 -- effect: 329, aura: NONE, points: 299, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 10881 #0 -- effect: 329, aura: NONE, points: 499, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20770 #0 -- effect: 329, aura: NONE, points: 749, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 25435 #0 -- effect: 329, aura: NONE, points: 1099, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Shackle Undead - Shackles the target undead enemy for up to 30/40/50 sec. The shackled unit is unable to move, attack or cast spells. Any damage caused will release the target. Only one target can be shackled at a time.
    shackle_undead = {
        id = 9484,
        cast = 1.5,
        duration = 50,
        gcd = "spell",
        school = "holy",
        texture = 136091,
        range = 30,
        spend = 90,
        spendType = "Mana",
        max_stack = 1,
        copy = { 9484, 9485, 10955 },

        -- Effects:
        -- [x] Rank 9484 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9485 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10955 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "shackle_undead" )
        end,

        proc_chance = 100,
    },

-- Shadow Protection - Increases the target's resistance to Shadow spells by 30/45/60/70 for 600 sec.
    shadow_protection = {
        id = 976,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "shadow",
        texture = 136121,
        range = 30,
        spend = 250,
        spendType = "Mana",
        max_stack = 1,
        copy = { 976, 10957, 10958, 25433 },

        -- Effects:
        -- [x] Rank 976 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10957 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 10958 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25433 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shadow_protection" )
        end,
    },

-- Shadow Word: Death - A word of dark binding that inflicts 450/572 Shadow damage to the target. If the target is not killed by Shadow Word: Death, the caster takes damage equal to the damage inflicted upon the target.
    shadow_word_death = {
        id = 32379,
        cast = 0,
        category_cooldown = 12,
        gcd = "spell",
        school = "shadow",
        texture = 136149,
        cooldown_category_id = 1169,
        cooldown_category = "Shadow Word: Death",
        range = 30,
        spend = 243,
        spendType = "Mana",
        max_stack = 1,
        copy = { 32379, 32996 },

        -- Effects:
        -- [x] Rank 32379 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 449, addl_points: 73, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32996 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 571, addl_points: 93, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shadow_word_death" ) end
        end,

        proc_chance = 100,
    },

-- Shadow Word: Pain - A word of darkness that causes 30-1236 Shadow damage over 18 sec.
    shadow_word_pain = {
        id = 589,
        cast = 0,
        duration = 18,
        gcd = "spell",
        school = "shadow",
        texture = 136207,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 589, 594, 970, 992, 2767, 10892, 10893, 10894, 25367, 25368 },

        -- Effects:
        -- [x] Rank 589 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0.0732, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 594 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 0.114, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 970 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 0.169, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 992 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 38, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2767 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 60, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10892 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 84, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10893 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 111, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10894 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 141, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25367 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 166, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25368 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 205, addl_points: 1, points_per_level: 0, sp_bonus: 0.183, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "shadow_word_pain" )
            applyShadowWeavingStack()
        end,

        proc_chance = 100,
    },

-- Shadowfiend - Creates a shadowy fiend to attack the target. Caster receives mana when the Shadowfiend deals damage. Lasts 15 sec.
    shadowfiend = {
        id = 34433,
        cast = 0,
        duration = 15,
        cooldown = 300,
        gcd = "spell",
        school = "shadow",
        texture = 136199,
        range = 30,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 34433 #0 -- effect: SUMMON, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "shadowfiend", 15 ) end
        end,
    },

-- Shadowform - Assume a Shadowform, increasing your Shadow damage by 15% and reducing Physical damage done to you by 15%. However, you may not cast Holy spells while in this form.
    shadowform = {
        id = 15473,
        cast = 0,
        category_cooldown = 1.5,
        gcd = "spell",
        school = "shadow",
        texture = 136200,
        cooldown_category_id = 39,
        cooldown_category = "Shapeshift",
        spend_pct = 32,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 15473 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 15473 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 15473 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clearShadowformConflicts()
            applyBuff( "shadowform" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Shadowguard - The caster is surrounded by shadows. When a spell, melee or ranged attack hits the caster, the attacker will be struck for 20 Shadow damage. Attackers can only be damaged once every few seconds. This damage causes no threat. $n charges. Lasts 600 sec.
    shadowguard = {
        id = 18137,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "shadow",
        texture = 136051,
        range = 100,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 18137, 19308, 19309, 19310, 19311, 19312, 25477, 28377, 28378, 28379, 28380, 28381, 28382, 28385 },

        -- Effects:
        -- [x] Rank 18137 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 19308 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 19309 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 50, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 19310 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 19311 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 19312 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 115, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 25477 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 129, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28376
        -- [x] Rank 28377 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28378 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28379 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 50, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28380 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28381 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28382 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 115, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 28385 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 129, addl_points: 1, points_per_level: 0, sp_bonus: 0.267, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyBuff( "shadowguard" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shadowguard" ) end
        end,

        proc_chance = 100,
        proc_charges = 3,
        proc_category_recovery = 3.5,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
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

-- Silence - Silences the target, preventing them from casting spells for 5 sec.
    silence = {
        id = 15487,
        cast = 0,
        duration = 5,
        cooldown = 45,
        gcd = "spell",
        school = "shadow",
        texture = 136164,
        range = 20,
        spend = 225,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 15487 #0 -- effect: APPLY_AURA, aura: MOD_SILENCE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "silence" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Smite - Smite an enemy for 13-545 Holy damage.
    smite = {
        id = 585,
        cast = 1.5,
        gcd = "spell",
        school = "holy",
        texture = 135924,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 585, 591, 598, 984, 1004, 6060, 10933, 10934, 25363, 25364 },

        -- Effects:
        -- [x] Rank 585 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 12, addl_points: 5, points_per_level: 0.5, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 591 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 7, points_per_level: 0.6, sp_bonus: 0.271, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 598 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 53, addl_points: 9, points_per_level: 0.9, sp_bonus: 0.554, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 984 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 90, addl_points: 15, points_per_level: 1.3, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1004 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 149, addl_points: 21, points_per_level: 1.6, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6060 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 211, addl_points: 29, points_per_level: 2, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10933 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 286, addl_points: 37, points_per_level: 2.3, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 10934 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 370, addl_points: 45, points_per_level: 2.7, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25363 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 404, addl_points: 49, points_per_level: 3.4, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25364 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 544, addl_points: 67, points_per_level: 4.1, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "smite" ) end
        end,

        proc_chance = 100,
    },

-- Starshards - Rains starshards down on the enemy target's head, causing 60-785 Arcane damage over 15 sec.
    starshards = {
        id = 10797,
        cast = 0,
        duration = 15,
        category_cooldown = 30,
        gcd = "spell",
        school = "arcane",
        texture = 135753,
        cooldown_category_id = 1192,
        cooldown_category = "Starshards",
        range = 30,
        max_stack = 1,
        copy = { 10797, 19296, 19299, 19302, 19303, 19304, 19305, 25446 },

        -- Effects:
        -- [x] Rank 10797 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19296 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 22, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19299 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19302 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 57, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19303 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 78, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19304 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19305 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 129, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25446 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 156, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "starshards" )
        end,

        proc_chance = 100,
    },

-- Surge of Light - Your spell criticals have a $h% chance to cause your next Smite spell to be instant cast, cost no mana but be incapable of a critical hit. This effect lasts $33151d.
    surge_of_light = {
        id = 33150,
        cast = 0,
        duration = 10,
        texture = 135981,
        max_stack = 1,
        copy = { 33150, 33151, 33154 },

        -- Effects:
        -- [x] Rank 33150 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33151
        -- [x] Rank 33151 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33151 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33151 #2 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -10001, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33154 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33151

        handler = function ()
            applyBuff( "surge_of_light" )
        end,

        proc_chance = 25,
        proc_charges = 1,
        proc_type_mask = { 81920, 0 },
        -- Proc type flags: mask0: Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Symbol of Hope - Greatly increases the morale of party members, giving them 33 mana every 5 sec. Effect lasts 15 sec.
    symbol_of_hope = {
        id = 32548,
        cast = 0,
        duration = 15,
        cooldown = 300,
        gcd = "spell",
        school = "holy",
        texture = 135982,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 32548 #0 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN, points: 32, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 23, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_PARTY, mechanic: 0

        radius = 40,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Touch of Weakness - The next melee attack against the caster will cause 8 Shadow damage and reduce the damage caused by the attacker by 2 for $2943d.
    touch_of_weakness = {
        id = 2652,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "shadow",
        texture = 136143,
        range = 100,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2652, 2943, 19249, 19251, 19252, 19253, 19254, 19261, 19262, 19264, 19265, 19266, 25460, 25461 },

        -- Effects:
        -- [x] Rank 2652 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 2943 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.067, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2943 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19249 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19249 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19251 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19251 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19252 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19252 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19253 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 47, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19253 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19254 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 63, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19254 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19261 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 19262 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 19264 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 19265 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 19266 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        -- [x] Rank 25460 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.107, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25460 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: -36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25461 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 28598
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "touch_of_weakness" )
            applyBuff( "touch_of_weakness" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "touch_of_weakness" ) end
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability
    },

-- Vampiric Embrace - Afflicts your target with Shadow energy that causes all party members to be healed for 15% of any Shadow spell damage you deal for 60 sec.
    vampiric_embrace = {
        id = 15286,
        cast = 0,
        duration = 60,
        cooldown = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136230,
        range = 30,
        spend_pct = 2,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 15286 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "vampiric_embrace" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Vampiric Touch - Causes 450/600/650 Shadow damage over 15 sec to your target and causes all party members to gain mana equal to 0/5% of any Shadow spell damage you deal.
    vampiric_touch = {
        id = 34914,
        cast = 1.5,
        duration = 15,
        gcd = "spell",
        school = "shadow",
        texture = 135978,
        range = 30,
        spend = 325,
        spendType = "Mana",
        max_stack = 1,
        copy = { 34914, 34916, 34917, 34919 },

        -- Effects:
        -- [x] Rank 34914 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34914 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34916 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34916 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34917 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34917 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 129, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 34919 #0 -- effect: ENERGIZE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 100,

        handler = function ()
            applyDebuff( "target", "vampiric_touch" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

} )

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "mana" )
end

spec:RegisterRanges( "chastise", "mind_flay", "devouring_plague", "holy_fire", "mind_blast", "shadow_word_death" )

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

    package = "Shadow",
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
spec:RegisterPet( "shadowfiend", 34433, "shadowfiend", 15 )

spec:RegisterPack( "Shadow", 20231124, [[Hekili:vN1wVTTnu4FlbfWWg1vXxAU0bR8W2EynpemaTNLeTeDmr0nirfpdeOF77qsDHsIK2UnDffOOjrMN7NZ35JYUlD)hxNqef7(0QfRwVC5QVyT8(f3S4wxh6XmSRtgk4f0ZWVKGIH)3zpkm9a7XhJsrHmXlslZdGp6q6HcsCH1Ze6(YTwK0k)jv(Wt3JrHwbPXxFiLg9IRZ2sse9RjUBvz6pV6lGkZWbUpDJRZEsyiwCsCrqJ5R8)7CcUGw5NLtsZj0Jv(re2FVlnVY)VWVqIiUoShvW9qsYZry43EIhV4e02iCO7V76eacJZjixNxrWpGhBrjXypAQxibx5VXUYhfqjPjwXKKqVDrOJwHL5i2JQ8F7Tk)Pv(XPVcwGhUxv5hMsTcXVczf4HEzrONlXw54yejPOYFMRJqHSqQ)HCPqQqRdUTC3olssco3BxAqzHvzwRdWmzbp14Dinp0ldSvNj3u5V06gU7z(GpOkAPKGx8yjLk)pcPzOGLeCSxC0EwwaS(cZWpu5VOtvcFBhbNeYu2N1QmipZCSM0(u()4POMWdJyffRck0ax5drMidOXlGp)o4aZAtPg0f7WRnOSnT6A2WiRlRZcVB0gES60RO4msoja0BzW(UQKCvamvaQGwxFmgER78L(AM5j3AkrBQH2C38DxAZG9W4bQeSolV0xH((Tri2qoRcXlp54SiCcPyFmoH2RFF94guUWmN6EZJy67F6uO0yitJFzGgla0lhZzT(LA9WfmaOfwR6m9beHhflxOYO1yb6AD(u789GtiL0NDI(q5XUrGfb7rqQjQ5Zn5lSiB6z4pAaDAZd6H0VQUnPUArYXCmtJtjlxmQkdYXnKEOzWqxKIBdwC82CuGq96boVQzdJkixWlHJLxMr9i7GZQynXewjR4b7vC7OhtDOrKHScXikhPyPEqRHYRcryPEKMyucYkddCjsOI2JBLYzHeGuqEb73z1Dq57qLruvl1Bejaff5j(dpgxabJapbrgsIO)HxvBKOSa7bUtCHS(AwQ1COSuXp7DIHzvgDLCsM4K7rc(b1B3sZJR8ja9H8uAnrITLpdJePL0oZS)ilEZW4qigcWrybPdHtMUBN3ZbHSy34EeMYEf7HtWXaHj(22LDMiVmrB(jicaaXQ2nCosxZ4IxPYYXa5VTiJ1QUuZGC3taYF8wmqRJXsudAntol4NjNbfQqcumWEfSjqkxi(Kl)ZYYrhHbN0DYFSCpOKOMj7iux6bqB85hWdPeAziwRf7Fc52TXkXm3OHGE8vy18a1cVPVhIJUzg862tnFqBBOmscFu7kacC)auVcmk3Cz(7IYYWsQce3GJqS4rr5pJH7xaHZfHbd4C)RxFv4CNs4(gcq)uy3BSd7BGk)W(RrTtcUOksUNkF9dHRSbCVrm5)g85FrU(YP508Rhj)3xwHdP()otkCij)lm3EnS1S51siHPOcMDTgywd8Rplxq24Vl8x1J7FE8x1VZ(S4VAG(8fXFLZ)uXYW0m2v5OY9fISm73IaNGFhpmpnrZHzbM)fwghFSPnE9IfTibc0h5cexH1S0KFSInQN2vQv)EmkIU3klGYNlxTq2i4)fhusXEz7rfcgHGgFTov08Q)(m7cD5Sybqk)ACgq0bhYX8e2w8(9kSQEKXNmDhH5eFO59a(Bv(1VyWh)a)noEoVhs(z7ZUS6r4HCTwZyT6rH5lSAjX(r7R74CoNSZwfnu1Y1J(yROJ5Jorpxu1kwffXw9RLe6qZmGIQsl1b(1Q)ren3SCHAHhIWXuXvqtRMyIx3RRi)P42EThfoWWB3nN1UzZgRKpv7n6KFyJUbfFbxndoFNk63dC1WMaPOcoSMRYnx6MC2lLfyWvReHMGanZC9XVF40IkUowtY8RSCK)FJYHpcWU6snwSShVqjMZfclHsmNp3Bpvh(Zea7z2BVng15eMOhgrTrgHTSz1IMi4p4PIoLksnGABxDPinzFVcbgIXZRMgFLCAmkBz28Eu(SxoFenq77MlVVZ246oUViwknzQjU9BGlamX0bEWw40Qi()XAcYZuezsC4zoJQf(pSqHC9PJFEPLD26jY34JBAjwmrPVyVwBq0Luox35QAg6tMovlBA7B04i3DdmhOxoWtvk4gqUzAu5svz6owVAlq2DjTPdOz)2B6PyVzTQoI(laUAmt6lX51Sq4surVb(te(xVAsZ40qObv9nDJ1x2i7Pkc1(Wj6u5ewzQt7PvbDP)WT0p5htIQ6g7BBXvDQ3t0iUyVHgBPS)DmqtZ3wkmouN8nIVotH1LQe9jDuN(bv))j8yRFDHWJdKtcr6NjAJc)Ba897o0SX2QZC7B)MJF8iGT2tQ1Ba9)HflfcZ(wRAYN6IXn2lSwnVahy8uNq5Q)s7MmQpV7lSBI(A8g7P1cQ7RPRDkH73t1RQpDcfziJ)DTZzCV9fVZrfC0fTyyeWVsabTa)gNA0FyJa)WD7lP7tZDDCkHhNuwuWVGU7)n]] )


spec:RegisterPackSelector( "discipline", "none", "|T135987:0|t Discipline",
    "If you have spent more points in |T135987:0|t Discipline than in any other tree, this priority will be automatically selected for you.",
    -- Criteria
    -- The pack selector hook passes the points spent in tab1 (Discipline), tab2 (Holy), and tab3 (Shadow).
    function( tab1, tab2, tab3 )
        -- If we spent the most points in Shadow, then swap to this package.
        -- We could also reference anything else we wanted; e.g., talent.shadowform.enabled or something else entirely.
        return tab1 > max( tab2, tab3 )
    end )


spec:RegisterPackSelector( "holy", "none", "|T237542:0|t Holy",
    "If you have spent more points in |T237542:0|t Holy than in any other tree, this priority will be automatically selected for you.",
    -- Criteria
    -- The pack selector hook passes the points spent in tab1 (Discipline), tab2 (Holy), and tab3 (Shadow).
    function( tab1, tab2, tab3 )
        -- If we spent the most points in Shadow, then swap to this package.
        -- We could also reference anything else we wanted; e.g., talent.shadowform.enabled or something else entirely.
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "shadow", "Shadow", "|T136207:0|t Shadow",
    "If you have spent more points in |T136207:0|t Shadow than in any other tree, this priority will be automatically selected for you.",
    -- Criteria
    -- The pack selector hook passes the points spent in tab1 (Discipline), tab2 (Holy), and tab3 (Shadow).
    function( tab1, tab2, tab3 )
        -- If we spent the most points in Shadow, then swap to this package.
        -- We could also reference anything else we wanted; e.g., talent.shadowform.enabled or something else entirely.
        return tab3 > max( tab1, tab2 )
    end )

-- Settings
spec:RegisterSetting( "dots_in_aoe", false, {
    type = "toggle",
    name = "|T252997:0|t|T136207:0|t|T135978:0|t Apply DoTs in AOE",
    desc = "When enabled, the Shadow priority will recommend applying DoTs to your current target in multi-target scenarios before channeling |T237565:0|t Mind Sear.",
    width = "full",
} )

spec:RegisterSetting( "optimize_mind_blast", false, {
    type = "toggle",
    name = "|T136224:0|t Mind Blast: Optimize Use",
    desc = "When enabled, the Shadow priority will only recommend |T136224:0|t Mind Blast below an internally-calculated haste threshold (vs. using |T136208:0|t Mind Flay).",
    width = "full",
} )

spec:RegisterSetting( "min_shadowfiend_mana", 25, {
    type = "range",
    name = "|T136199:0|t Shadowfiend Mana Threshold",
    desc = "If set above zero, |T136199:0|t Shadowfiend cannot be recommended until your mana falls below this percentage.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

