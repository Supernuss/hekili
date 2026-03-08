-- Warlock.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Warlock (#9)

if UnitClassBase( "player" ) ~= "WARLOCK" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 9 )

local function clear_warlock_armor()
    removeBuff( "demon_armor" )
    removeBuff( "demon_skin" )
    removeBuff( "fel_armor" )
end

local life_tap_base_by_id = {
    [1454] = 20,
    [1455] = 65,
    [1456] = 130,
    [11687] = 210,
    [11688] = 300,
    [11689] = 420,
    [27222] = 580,
}

local function get_life_tap_base_amount()
    local spell_id

    if action and action.life_tap and action.life_tap.id then
        spell_id = action.life_tap.id
    elseif class and class.abilities and class.abilities.life_tap and class.abilities.life_tap.id then
        spell_id = class.abilities.life_tap.id
    end

    local base = spell_id and life_tap_base_by_id[ spell_id ]

    if not base and class and class.abilities and class.abilities.life_tap and type( class.abilities.life_tap.copy ) == "table" then
        local copies = class.abilities.life_tap.copy

        for i = #copies, 1, -1 do
            local rank_base = life_tap_base_by_id[ copies[ i ] ]
            if rank_base then
                base = rank_base
                break
            end
        end
    end

    return base or 200
end

local function maybe_apply_shadow_trance()
    if class and class.auras and class.auras.shadow_trance and buff and buff.shadow_trance then
        applyBuff( "shadow_trance" )
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
    aftermath = { 982, 5, 18119, 18120, 18121, 18122, 18123 },
    amplify_curse = { 1061, 1, 18288 },
    backlash = { 1817, 3, 34935, 34938, 34939 },
    bane = { 943, 5, 17788, 17789, 17790, 17791, 17792 },
    cataclysm = { 941, 5, 17778, 17779, 17780, 17781, 17782 },
    conflagrate = { 968, 1, 17962 },
    contagion = { 1669, 5, 30060, 30061, 30062, 30063, 30064 },
    curse_of_exhaustion = { 1081, 1, 18223 },
    dark_pact = { 1022, 1, 18220 },
    demonic_aegis = { 1671, 3, 30143, 30144, 30145 },
    demonic_embrace = { 1223, 5, 18697, 18698, 18699, 18700, 18701 },
    demonic_knowledge = { 1263, 3, 35691, 35692, 35693 },
    demonic_resilience = { 1680, 3, 30319, 30320, 30321 },
    demonic_sacrifice = { 1281, 1, 18788 },
    demonic_tactics = { 1673, 5, 30242, 30245, 30246, 30247, 30248 },
    destructive_reach = { 964, 2, 17917, 17918 },
    devastation = { 981, 5, 18130, 18131, 18132, 18133, 18134 },
    emberstorm = { 966, 5, 17954, 17955, 17956, 17957, 17958 },
    empowered_corruption = { 1764, 3, 32381, 32382, 32383 },
    fel_concentration = { 1001, 5, 17783, 17784, 17785, 17786, 17787 },
    fel_domination = { 1226, 1, 18708 },
    fel_intellect = { 1242, 3, 18731, 18743, 18744 },
    fel_stamina = { 1241, 3, 18748, 18749, 18750 },
    grim_reach = { 1021, 2, 18218, 18219 },
    improved_corruption = { 1003, 5, 17810, 17811, 17812, 17813, 17814 },
    improved_curse_of_agony = { 1284, 2, 18827, 18829 },
    improved_curse_of_weakness = { 1006, 2, 18179, 18180 },
    improved_drain_soul = { 1101, 2, 18213, 18372 },
    improved_firebolt = { 983, 2, 18126, 18127 },
    improved_health_funnel = { 1224, 2, 18703, 18704 },
    improved_healthstone = { 1221, 2, 18692, 18693 },
    improved_howl_of_terror = { 1668, 2, 30054, 30057 },
    improved_immolate = { 961, 5, 17815, 17833, 17834, 17835, 17836 },
    improved_imp = { 1222, 3, 18694, 18695, 18696 },
    improved_lash_of_pain = { 984, 2, 18128, 18129 },
    improved_life_tap = { 1007, 2, 18182, 18183 },
    improved_sayaad = { 1243, 3, 18754, 18755, 18756 },
    improved_searing_pain = { 965, 3, 17927, 17929, 17930 },
    improved_shadow_bolt = { 944, 5, 17793, 17796, 17801, 17802, 17803 },
    improved_subjugate_demon = { 1283, 2, 18821, 18822 },
    improved_voidwalker = { 1225, 3, 18705, 18706, 18707 },
    intensity = { 985, 2, 18135, 18136 },
    malediction = { 1667, 3, 32477, 32483, 32484 },
    mana_feed = { 1681, 3, 30326, 30327, 30328 },
    master_conjuror = { 1261, 2, 18767, 18768 },
    master_demonologist = { 1244, 5, 23785, 23822, 23823, 23824, 23825 },
    master_summoner = { 1227, 2, 18709, 18710 },
    nether_protection = { 1679, 3, 30299, 30301, 30302 },
    nightfall = { 1002, 2, 18094, 18095 },
    pyroclasm = { 986, 2, 18096, 18073 },
    ruin = { 967, 1, 17959 },
    shadow_and_flame = { 1677, 5, 30288, 30289, 30290, 30291, 30292 },
    shadow_embrace = { 1763, 5, 32385, 32387, 32392, 32393, 32394 },
    shadow_mastery = { 1042, 5, 18271, 18272, 18273, 18274, 18275 },
    shadowburn = { 963, 1, 17877 },
    shadowfury = { 1676, 1, 30283 },
    siphon_life = { 1041, 1, 18265 },
    soul_leech = { 1678, 3, 30293, 30295, 30296 },
    soul_link = { 1282, 1, 19028 },
    soul_siphon = { 1004, 2, 17804, 17805 },
    summon_felguard = { 1672, 1, 30146 },
    suppression = { 1005, 5, 18174, 18175, 18176, 18177, 18178 },
    unholy_power = { 1262, 5, 18769, 18770, 18771, 18772, 18773 },
    unstable_affliction = { 1670, 1, 30108 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    amplify_curse = {
        id = 18288,
        duration = 30,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER, ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    arcane_torrent = {
        id = 28730,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    backlash = {
        id = 34935,
        duration = 8,
        max_stack = 1,
        copy = { 34935, 34936, 34938, 34939 },
        -- Aura effects: ADD_PCT_MODIFIER, MOD_SPELL_CRIT_CHANCE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    banish = {
        id = 710,
        duration = 30,
        max_stack = 1,
        copy = { 710, 18647 },
        -- Aura effects: MOD_STUN, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    blood_fury = {
        id = 33702,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_DAMAGE_DONE, MOD_HEALING_DONE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    corruption = {
        id = 172,
        duration = 18,
        tick_time = 3,
        max_stack = 1,
        copy = { 172, 6222, 6223, 7648, 11671, 11672, 25311, 27216 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_agony = {
        id = 980,
        duration = 24,
        tick_time = 2,
        max_stack = 1,
        copy = { 980, 6217, 11711, 11712, 11713, 27218 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_doom = {
        id = 603,
        duration = 60,
        tick_time = 60,
        max_stack = 1,
        copy = { 603, 30910 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_exhaustion = {
        id = 18223,
        duration = 12,
        max_stack = 1,
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_idiocy = {
        id = 1010,
        duration = 120,
        tick_time = 3,
        max_stack = 15,
        -- Aura effects: MOD_STAT, PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_recklessness = {
        id = 704,
        duration = 120,
        max_stack = 1,
        copy = { 704, 7658, 7659, 11717, 27226 },
        -- Aura effects: MOD_ATTACK_POWER, MOD_RESISTANCE, PREVENTS_FLEEING
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_the_elements = {
        id = 1490,
        duration = 300,
        max_stack = 1,
        copy = { 1490, 11721, 11722, 27228 },
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_tongues = {
        id = 1714,
        duration = 30,
        max_stack = 1,
        copy = { 1714, 11719 },
        -- Aura effects: HASTE_SPELLS, MOD_LANGUAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    curse_of_weakness = {
        id = 702,
        duration = 120,
        max_stack = 1,
        copy = { 702, 1108, 6205, 7646, 11707, 11708, 27224, 30909 },
        -- Aura effects: MOD_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    death_coil = {
        id = 6789,
        duration = 3,
        max_stack = 1,
        copy = { 6789, 17925, 17926, 27223 },
        -- Aura effects: MOD_FEAR
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    demon_armor = {
        id = 706,
        duration = 1800,
        max_stack = 1,
        copy = { 706, 1086, 11733, 11734, 11735, 27260 },
        -- Aura effects: MOD_HEALTH_REGEN_IN_COMBAT, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    demon_skin = {
        id = 687,
        duration = 1800,
        max_stack = 1,
        copy = { 687, 696 },
        -- Aura effects: MOD_HEALTH_REGEN_IN_COMBAT, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    detect_invisibility = {
        id = 132,
        duration = 600,
        max_stack = 1,
        -- Aura effects: MOD_INVISIBILITY_DETECT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    drain_life = {
        id = 689,
        duration = 5,
        tick_time = 1,
        max_stack = 1,
        copy = { 689, 699, 709, 7651, 11699, 11700, 27219, 27220 },
        -- Aura effects: PERIODIC_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    drain_mana = {
        id = 5138,
        duration = 5,
        tick_time = 1,
        max_stack = 1,
        copy = { 5138, 6226, 11703, 11704, 27221, 30908 },
        -- Aura effects: DUMMY, PERIODIC_MANA_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    drain_soul = {
        id = 1120,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 1120, 8288, 8289, 11675, 27217 },
        -- Aura effects: CHANNEL_DEATH_ITEM, PERIODIC_DAMAGE, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    eye_of_kilrogg = {
        id = 126,
        duration = 45,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fear = {
        id = 5782,
        duration = 20,
        max_stack = 1,
        copy = { 5782, 6213, 6215 },
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    fel_armor = {
        id = 28176,
        duration = 1800,
        max_stack = 1,
        copy = { 28176, 28189 },
        -- Aura effects: MOD_DAMAGE_DONE, MOD_HEALING_PCT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    fel_domination = {
        id = 18708,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_FLAT_MODIFIER, ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    health_funnel = {
        id = 755,
        duration = 10,
        tick_time = 1,
        max_stack = 1,
        copy = { 755, 3698, 3699, 3700, 11693, 11694, 11695, 27259 },
        -- Aura effects: MOD_HEALTH_REGEN_PERCENT, PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_PET
    },

    hellfire = {
        id = 1949,
        duration = 15,
        tick_time = 1,
        max_stack = 1,
        copy = { 1949, 11683, 11684, 27213 },
        -- Aura effects: MECHANIC_IMMUNITY, PERIODIC_DAMAGE, PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    howl_of_terror = {
        id = 5484,
        duration = 8,
        max_stack = 1,
        copy = { 5484, 17928 },
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    immolate = {
        id = 348,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 348, 707, 1094, 2941, 11665, 11667, 11668, 25309, 27215 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    master_demonologist = {
        id = 23759,
        max_stack = 1,
        copy = { 23759, 23760, 23761, 23762, 23785, 23822, 23823, 23824, 23825, 23826, 23827, 23828, 23829, 23833, 23834, 23835, 23836, 23837, 23838, 23839, 23840, 23841, 23842, 23843, 23844, 35702, 35703, 35704, 35705, 35706 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    nether_protection = {
        id = 30299,
        duration = 4,
        max_stack = 1,
        copy = { 30299, 30300, 30301, 30302 },
        -- Aura effects: PROC_TRIGGER_SPELL, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    rain_of_fire = {
        id = 5740,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 5740, 6219, 11677, 11678, 27212, 42218, 42223, 42224, 42225, 42226 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    seed_of_corruption = {
        id = 27243,
        duration = 18,
        tick_time = 3,
        max_stack = 1,
        -- Aura effects: DUMMY, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    sense_demons = {
        id = 5500,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shadow_embrace = {
        id = 32385,
        max_stack = 1,
        copy = { 32385, 32386, 32387, 32388, 32389, 32390, 32391, 32392, 32393, 32394 },
        -- Aura effects: MOD_DAMAGE_PERCENT_DONE, OVERRIDE_CLASS_SCRIPTS, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    shadow_ward = {
        id = 6229,
        duration = 30,
        max_stack = 1,
        copy = { 6229, 11739, 11740, 28610 },
        -- Aura effects: SCHOOL_ABSORB
        -- Aura targets: TARGET_UNIT_CASTER
    },

    shadowfury = {
        id = 30283,
        duration = 2,
        max_stack = 1,
        copy = { 30283, 30413, 30414 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_DEST_AREA_ENEMY
    },

    siphon_life = {
        id = 18265,
        duration = 30,
        tick_time = 3,
        max_stack = 1,
        copy = { 18265, 18879, 18880, 18881, 27264, 30911 },
        -- Aura effects: PERIODIC_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    subjugate_demon = {
        id = 1098,
        duration = 300,
        max_stack = 1,
        copy = { 1098, 11725, 11726 },
        -- Aura effects: MOD_CASTING_SPEED_NOT_STACK, MOD_CHARM, MOD_MELEE_HASTE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    summon_dreadsteed = {
        id = 23161,
        max_stack = 1,
        -- Aura effects: MOD_INCREASE_MOUNTED_SPEED, MOUNTED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    summon_felsteed = {
        id = 5784,
        max_stack = 1,
        -- Aura effects: MOD_INCREASE_MOUNTED_SPEED, MOUNTED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    unending_breath = {
        id = 5697,
        duration = 600,
        max_stack = 1,
        -- Aura effects: WATER_BREATHING
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    unstable_affliction = {
        id = 30108,
        duration = 5,
        tick_time = 3,
        max_stack = 1,
        copy = { 30108, 30404, 30405, 31117 },
        -- Aura effects: MOD_SILENCE, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ANY, TARGET_UNIT_TARGET_ENEMY
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

-- Amplify Curse - Increases the effect of your next Curse of Doom or Curse of Agony by 50%, or your next Curse of Exhaustion by an additional 2%. Lasts 30 sec.
    amplify_curse = {
        id = 18288,
        cast = 0,
        duration = 30,
        cooldown = 180,
        school = "shadow",
        texture = 136132,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18288 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 18288 #1 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "amplify_curse" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
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

-- Backlash - Increases your critical strike chance with spells by an additional 1/2/3% and gives you a $h% chance when hit by a physical attack to reduce the cast time of your next Shadow Bolt or Incinerate spell by 100%. This effect lasts $34936d and will not occur more than once every 8 seconds.
    backlash = {
        id = 34935,
        cast = 0,
        duration = 8,
        school = "fire",
        texture = 135823,
        max_stack = 1,
        copy = { 34935, 34936, 34938, 34939 },

        -- Effects:
        -- [x] Rank 34935 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34936
        -- [x] Rank 34935 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_CRIT_CHANCE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34936 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34938 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34936
        -- [x] Rank 34938 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_CRIT_CHANCE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34939 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34936
        -- [x] Rank 34939 #1 -- effect: APPLY_AURA, aura: MOD_SPELL_CRIT_CHANCE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "backlash" )
        end,

        proc_chance = 8,
        proc_category_recovery = 8,
        proc_type_mask = { 680, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Banish - Banishes the enemy target, preventing all action but making it invulnerable for up to 20/30 sec. Only one target can be banished at a time. Only works on Demons and Elementals.
    banish = {
        id = 710,
        cast = 1.5,
        duration = 30,
        gcd = "spell",
        school = "shadow",
        texture = 136135,
        range = 30,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,
        copy = { 710, 18647 },

        -- Effects:
        -- [x] Rank 710 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 710 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18647 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18647 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "banish" )
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

-- Blood Fury - Increases your damage and healing from spells and effects by up to 5, but reduces healing effects on you by 50%. Lasts 15 sec.
    blood_fury = {
        id = 33702,
        cast = 0,
        duration = 15,
        cooldown = 120,
        school = "physical",
        texture = 135726,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 33702 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 4, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33702 #2 -- effect: APPLY_AURA, aura: MOD_HEALING_DONE, points: 4, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "blood_fury" )
        end,

        proc_chance = 100,
    },

-- Conflagrate - Ignites a target that is already afflicted by your Immolate, dealing 240-579 Fire damage and consuming the Immolate spell.
    conflagrate = {
        id = 17962,
        cast = 0,
        category_cooldown = 10,
        gcd = "spell",
        school = "fire",
        texture = 135807,
        cooldown_category_id = 672,
        cooldown_category = "Conflagrate",
        range = 30,
        spend = 165,
        spendType = "Mana",
        max_stack = 1,
        copy = { 17962, 18930, 18931, 18932, 27266, 30912 },

        -- Effects:
        -- [x] Rank 17962 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 239, addl_points: 67, points_per_level: 1.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18930 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 315, addl_points: 81, points_per_level: 1.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18931 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 382, addl_points: 97, points_per_level: 2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18932 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 446, addl_points: 111, points_per_level: 2.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27266 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 511, addl_points: 127, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30912 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 578, addl_points: 143, points_per_level: 2.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "conflagrate" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: target_state=14

        -- Related talents:
        -- talent_0 [0]
    },

-- Corruption - Corrupts the target, causing 40-900 Shadow damage over 12/15/18 sec.
    corruption = {
        id = 172,
        cast = function () return max( 0, 2 + -0.4 * ( talent.improved_corruption.rank or 0 ) ) end,
        duration = 18,
        gcd = "spell",
        school = "shadow",
        texture = 136118,
        range = 30,
        spend = 35,
        -- Talent cast scaling: improved_corruption (-0.4s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 172, 6222, 6223, 7648, 11671, 11672, 25311, 27216 },

        -- Effects:
        -- [x] Rank 172 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0.0624, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6222 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0.121, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6223 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 36, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7648 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 53, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11671 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 80, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11672 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 110, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25311 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 136, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27216 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 0.156, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "corruption" )
            maybe_apply_shadow_trance()
        end,

        proc_chance = 100,
    },

-- Create Firestone - Creates a Lesser Firestone which can be equipped. When equipped, enchants the main hand weapon with fire, granting each attack a chance to deal 25 additional Fire damage. In addition, equipping the Lesser Firestone increases the damage done by fire spells by 10. Conjured items disappear if logged out for more than 15 minutes.
    create_firestone = {
        id = 6366,
        cast = 3,
        gcd = "spell",
        school = "fire",
        texture = 132386,
        spend = 500,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6366, 17951, 17952, 17953, 27250 },

        -- Effects:
        -- [x] Rank 6366 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 17951 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 17952 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 17953 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27250 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Create Healthstone - Creates a Healthstone that can be used to instantly restore 500 health. Conjured items disappear if logged out for more than 15 minutes.
    create_healthstone = {
        id = 5699,
        cast = 3,
        gcd = "spell",
        school = "shadow",
        texture = 135230,
        spend = 475,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5699, 6201, 6202, 11729, 11730, 27230 },

        -- Effects:
        -- [ ] Rank 5699 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 6201 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 6202 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11729 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11730 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27230 #0 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Create Soulstone - Creates a Minor Soulstone. The Soulstone can be used to store one target's soul. If the target dies while their soul is stored, they will be able to resurrect with 400 health and $3026q1 mana. Conjured items disappear if logged out for more than 15 minutes.
    create_soulstone = {
        id = 693,
        cast = 3,
        gcd = "spell",
        school = "shadow",
        texture = 136210,
        spend_pct = 68,
        spendType = "Mana",
        max_stack = 1,
        copy = { 693, 20752, 20755, 20756, 20757, 27238 },

        -- Effects:
        -- [x] Rank 693 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20752 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20755 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20756 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 20757 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27238 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
    },

-- Create Soulwell
    create_soulwell = {
        id = 29886,
        cast = 1.5,
        duration = 180,
        texture = 135741,
        range = 10,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 29886 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 8, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 5,

        proc_chance = 100,
    },

-- Create Spellstone - Creates a Spellstone for the caster. When equipped and used, the Spellstone dispels all harmful magic effects from the caster. In addition, equipping the Spellstone improves your spell critical strike rating by 8. Conjured items disappear if logged out for more than 15 minutes.
    create_spellstone = {
        id = 2362,
        cast = 5,
        gcd = "spell",
        school = "shadow",
        texture = 134131,
        spend = 500,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2362, 17727, 17728, 28172 },

        -- Effects:
        -- [x] Rank 2362 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 17727 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 17728 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28172 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Curse of Agony - Curses the target with agony, causing 84-1356 Shadow damage over 24 sec. This damage is dealt slowly at first, and builds up as the Curse reaches its full duration. Only one Curse per Warlock can be active on any one target.
    curse_of_agony = {
        id = 980,
        cast = 0,
        duration = 24,
        gcd = "spell",
        school = "shadow",
        texture = 136139,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 980, 6217, 11711, 11712, 11713, 27218 },

        -- Effects:
        -- [x] Rank 980 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0.0548, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6217 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 26, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11711 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11712 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11713 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 86, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27218 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 112, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_agony" )
        end,

        proc_chance = 100,
    },

-- Curse of Doom - Curses the target with impending doom, causing 3200/4200 Shadow damage after 60 sec. If the target dies from this damage, there is a chance that a Doomguard will be summoned. Cannot be cast on players.
    curse_of_doom = {
        id = 603,
        cast = 0,
        duration = 60,
        category_cooldown = 60,
        gcd = "spell",
        school = "shadow",
        texture = 136122,
        cooldown_category_id = 1179,
        cooldown_category = "Curse of Doom",
        range = 30,
        spend = 300,
        spendType = "Mana",
        max_stack = 1,
        copy = { 603, 30910 },

        -- Effects:
        -- [x] Rank 603 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 3199, addl_points: 1, points_per_level: 0, sp_bonus: 2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30910 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 4199, addl_points: 1, points_per_level: 0, sp_bonus: 2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_doom" )
        end,

        proc_chance = 100,
    },

-- Curse of Doom Effect - Summons a Doomguard.
    curse_of_doom_effect = {
        id = 18662,
        cast = 0,
        duration = 15,
        school = "shadow",
        texture = 136122,
        range = 50000,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18662 #0 -- effect: SUMMON, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_TARGET_ANY, target2: NONE, mechanic: 0

        radius = 10,
    },

-- Curse of Exhaustion - Reduces the target's movement speed by 30% for 12 sec. Only one Curse per Warlock can be active on any one target.
    curse_of_exhaustion = {
        id = 18223,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "shadow",
        texture = 136162,
        range = 30,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18223 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_exhaustion" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Curse of Idiocy - Curse the target with idiocy, reducing Intellect and Spirit by 6 every $t3 seconds until each is reduced by a total of $*15;s1. Only one Curse per Warlock can be active on any one target.
    curse_of_idiocy = {
        id = 1010,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "shadow",
        texture = 136174,
        range = 30,
        spend = 110,
        spendType = "Mana",
        max_stack = 15,

        -- Effects:
        -- [x] Rank 1010 #0 -- effect: APPLY_AURA, aura: MOD_STAT, points: -7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1010 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: -7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1010 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 1010
        startsCombat = true,

        handler = function ()
            if debuff.curse_of_idiocy.up then
                applyDebuff( "target", "curse_of_idiocy", nil, min( debuff.curse_of_idiocy.max_stack, debuff.curse_of_idiocy.stack + 1 ) )
            else
                applyDebuff( "target", "curse_of_idiocy", nil, 1 )
            end
        end,

        proc_chance = 100,
    },

-- Curse of Recklessness - Curses the target with recklessness, increasing melee attack power by 20/45/65/90/135 but reducing armor by 140/290/465/640/800 for 120 sec. Cursed enemies will not flee and will ignore Fear and Horror effects. Only one Curse per Warlock can be active on any one target.
    curse_of_recklessness = {
        id = 704,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "shadow",
        texture = 136225,
        range = 30,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 704, 7658, 7659, 11717, 27226 },

        -- Effects:
        -- [x] Rank 704 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 704 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -141, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 704 #2 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7658 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7658 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -291, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7658 #2 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7659 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7659 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -466, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7659 #2 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11717 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11717 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -641, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11717 #2 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27226 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: 134, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27226 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -801, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27226 #2 -- effect: APPLY_AURA, aura: PREVENTS_FLEEING, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_recklessness" )
        end,

        proc_chance = 100,
    },

-- Curse of the Elements - Curses the target for 300 sec, reducing Arcane, Fire, Frost, and Shadow resistances by 45/60/75/88 and increasing Arcane, Fire, Frost, and Shadow damage taken by 6/8/10%. Only one Curse per Warlock can be active on any one target.
    curse_of_the_elements = {
        id = 1490,
        cast = 0,
        duration = 300,
        gcd = "spell",
        school = "shadow",
        texture = 136130,
        range = 30,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1490, 11721, 11722, 27228 },

        -- Effects:
        -- [x] Rank 1490 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -46, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1490 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11721 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11721 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11722 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -76, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11722 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27228 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27228 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_the_elements" )
        end,

        proc_chance = 100,
    },

-- Curse of Tongues - Forces the target to speak in Demonic, increasing the casting time of all spells by 50/60%. Only one Curse per Warlock can be active on any one target. Lasts 30 sec.
    curse_of_tongues = {
        id = 1714,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "shadow",
        texture = 136140,
        range = 30,
        spend = 80,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1714, 11719 },

        -- Effects:
        -- [x] Rank 1714 #0 -- effect: APPLY_AURA, aura: HASTE_SPELLS, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1714 #1 -- effect: APPLY_AURA, aura: MOD_LANGUAGE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11719 #0 -- effect: APPLY_AURA, aura: HASTE_SPELLS, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11719 #1 -- effect: APPLY_AURA, aura: MOD_LANGUAGE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_tongues" )
        end,

        proc_chance = 100,
    },

-- Curse of Weakness - Target's melee attack power is reduced by 21-350 for 120 sec. Only one Curse per Warlock can be active on any one target.
    curse_of_weakness = {
        id = 702,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "shadow",
        texture = 136138,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 702, 1108, 6205, 7646, 11707, 11708, 27224, 30909 },

        -- Effects:
        -- [x] Rank 702 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -22, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1108 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -42, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6205 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -65, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7646 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -83, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11707 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -124, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11708 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -164, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27224 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -258, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30909 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -351, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "curse_of_weakness" )
        end,

        proc_chance = 100,
    },

-- Dark Pact - Drains 305/440/545/700 of your pet's Mana, returning 100% to you.
    dark_pact = {
        id = 18220,
        cast = 0,
        gcd = "spell",
        school = "shadow",
        texture = 136141,
        range = 30,
        max_stack = 1,
        copy = { 18220, 18937, 18938, 27265 },

        -- Effects:
        -- [ ] Rank 18220 #0 -- effect: POWER_DRAIN, aura: NONE, points: 304, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 18937 #0 -- effect: POWER_DRAIN, aura: NONE, points: 439, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 18938 #0 -- effect: POWER_DRAIN, aura: NONE, points: 544, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 27265 #0 -- effect: POWER_DRAIN, aura: NONE, points: 699, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Death Coil - Causes the enemy target to run in horror for 3 sec and causes 244/319/400/519 Shadow damage. The caster gains ${100*$e1}% of the damage caused in health.
    death_coil = {
        id = 6789,
        cast = 0,
        duration = 3,
        category_cooldown = 120,
        gcd = "spell",
        school = "shadow",
        texture = 136145,
        cooldown_category_id = 633,
        cooldown_category = "Death Coil",
        range = 30,
        spend = 365,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6789, 17925, 17926, 27223 },

        -- Effects:
        -- [ ] Rank 6789 #0 -- effect: HEALTH_LEECH, aura: NONE, points: 243, addl_points: 1, points_per_level: 2.2, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6789 #1 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: horrified
        -- [ ] Rank 17925 #0 -- effect: HEALTH_LEECH, aura: NONE, points: 318, addl_points: 1, points_per_level: 2.6, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17925 #1 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: horrified
        -- [ ] Rank 17926 #0 -- effect: HEALTH_LEECH, aura: NONE, points: 399, addl_points: 1, points_per_level: 3, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17926 #1 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: horrified
        -- [ ] Rank 27223 #0 -- effect: HEALTH_LEECH, aura: NONE, points: 518, addl_points: 1, points_per_level: 3.4, sp_bonus: 0.214, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27223 #1 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: horrified
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "death_coil" )
        end,

        proc_chance = 100,
    },

-- Demon Armor - Protects the caster, increasing armor by 210-660, Shadow resistance by 3-18 and restores 7-18 health every 5 sec. Only one type of Armor spell can be active on the Warlock at any time. Lasts 1800 sec.
    demon_armor = {
        id = 706,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "shadow",
        texture = 136185,
        spend = 110,
        spendType = "Mana",
        max_stack = 1,
        copy = { 706, 1086, 11733, 11734, 11735, 27260 },

        -- Effects:
        -- [x] Rank 706 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 209, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 706 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 706 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1086 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 299, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1086 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1086 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11733 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 389, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11733 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11733 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11734 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 479, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11734 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11734 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11735 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 569, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11735 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11735 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27260 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 659, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27260 #1 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27260 #2 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_warlock_armor()
            applyBuff( "demon_armor" )
        end,
    },

-- Demon Skin - Protects the caster, increasing armor by $m1 and restores 3/5 Health per 5 sec. for 1800 sec.
    demon_skin = {
        id = 687,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "shadow",
        texture = 136185,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 687, 696 },

        -- Effects:
        -- [x] Rank 687 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 687 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 696 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 696 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_IN_COMBAT, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_warlock_armor()
            applyBuff( "demon_skin" )
        end,
    },

-- Demonic Sacrifice - When activated, sacrifices your summoned demon to grant you an effect that lasts $18789d. The effect is canceled if any Demon is summoned. Imp: Increases your Fire damage by 15%. Voidwalker: Restores 2% of total health every $18790t1 sec. Succubus/Incubus: Increases your Shadow damage by 15%. Felhunter: Restores 3% of total mana every $18792t1 sec. Felguard: Increases your Shadow damage by 10% and restores 2% of total mana every $35701t3 sec.
    demonic_sacrifice = {
        id = 18788,
        cast = 0,
        school = "shadow",
        texture = 136184,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 18788 #0 -- effect: INSTAKILL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
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

-- Detect Invisibility - Allows the friendly target to detect lesser invisibility for 600 sec.
    detect_invisibility = {
        id = 132,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "shadow",
        texture = 136153,
        range = 30,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 132 #0 -- effect: APPLY_AURA, aura: MOD_INVISIBILITY_DETECT, points: 999, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "detect_invisibility" )
        end,
    },

-- Drain Life - Transfers 10-108 health every $t1 sec from the target to the caster. Lasts 5 sec.
    drain_life = {
        id = 689,
        cast = 0,
        duration = 5,
        gcd = "spell",
        school = "shadow",
        texture = 136169,
        range = 30,
        spend = 55,
        spendType = "Mana",
        max_stack = 1,
        copy = { 689, 699, 709, 7651, 11699, 11700, 27219, 27220 },

        -- Effects:
        -- [x] Rank 689 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0.111, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 699 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 709 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 28, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7651 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 40, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11699 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11700 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 70, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27219 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 86, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27220 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 107, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "drain_life" )
            maybe_apply_shadow_trance()
        end,

        proc_chance = 100,
    },

-- Drain Mana - Transfers 42-200 Mana every $t1 sec from the target to the caster. Lasts 5 sec.
    drain_mana = {
        id = 5138,
        cast = 0,
        duration = 5,
        gcd = "spell",
        school = "shadow",
        texture = 136208,
        range = 30,
        spend = 95,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5138, 6226, 11703, 11704, 27221, 30908 },

        -- Effects:
        -- [x] Rank 5138 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5138 #1 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6226 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 67, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6226 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11703 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 98, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11703 #1 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11704 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 135, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11704 #1 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27221 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 168, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27221 #1 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30908 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30908 #1 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "drain_mana" )
        end,

        proc_chance = 100,
    },

-- Drain Soul - Drains the soul of the target, causing 55/155/295/455/620 Shadow damage over 15 sec. If the target dies while being drained, and yields experience or honor, the caster gains a Soul Shard. Soul Shards are required for other spells.
    drain_soul = {
        id = 1120,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "shadow",
        texture = 136163,
        range = 30,
        spend = 55,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1120, 8288, 8289, 11675, 27217 },

        -- Effects:
        -- [x] Rank 1120 #0 -- effect: APPLY_AURA, aura: CHANNEL_DEATH_ITEM, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1120 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 0.268, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1120 #2 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8288 #0 -- effect: APPLY_AURA, aura: CHANNEL_DEATH_ITEM, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8288 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8288 #2 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 8289 #0 -- effect: APPLY_AURA, aura: CHANNEL_DEATH_ITEM, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8289 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 58, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8289 #2 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11675 #0 -- effect: APPLY_AURA, aura: CHANNEL_DEATH_ITEM, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11675 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 90, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11675 #2 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27217 #0 -- effect: APPLY_AURA, aura: CHANNEL_DEATH_ITEM, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27217 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 123, addl_points: 1, points_per_level: 0, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27217 #2 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "drain_soul" )
            applyBuff( "drain_soul" )
        end,

        proc_charges = 1,
        proc_type_mask = { 2, 0 },
        -- Proc type flags: mask0: Kill
    },

-- Eye of Kilrogg - Summons an Eye of Kilrogg and binds your vision to it. The eye moves quickly but is very fragile.
    eye_of_kilrogg = {
        id = 126,
        cast = 5,
        duration = 45,
        gcd = "spell",
        school = "shadow",
        texture = 136155,
        range = 50000,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 126 #0 -- effect: SUMMON, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0
        -- [x] Rank 126 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "eye_of_kilrogg" )
            if type( summonPet ) == "function" then summonPet( "eye_of_kilrogg", 45 ) end
        end,
    },

-- Fear - Strikes fear in the enemy, causing it to run in fear for up to 10/15/20 sec. Damage caused may interrupt the effect. Only 1 target can be feared at a time.
    fear = {
        id = 5782,
        cast = 1.5,
        duration = 20,
        gcd = "spell",
        school = "shadow",
        texture = 136183,
        range = 20,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5782, 6213, 6215 },

        -- Effects:
        -- [x] Rank 5782 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5782 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6213 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6213 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6215 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6215 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "fear" )
        end,

        proc_chance = 100,
    },

-- Fel Armor - Surrounds the caster with fel energy, increasing the amount of health generated through spells and effects by 20% and increasing spell damage by up to 50/100. Only one type of Armor spell can be active on the Warlock at any time. Lasts 1800 sec.
    fel_armor = {
        id = 28176,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "shadow",
        texture = 136156,
        spend = 637,
        spendType = "Mana",
        max_stack = 1,
        copy = { 28176, 28189 },

        -- Effects:
        -- [x] Rank 28176 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28176 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28189 #0 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28189 #2 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_warlock_armor()
            applyBuff( "fel_armor" )
        end,

        proc_chance = 100,
    },

-- Fel Domination - Your next Imp, Voidwalker, Succubus, Incubus, Felhunter or Felguard Summon spell has its casting time reduced by $/1000;S1 sec and its Mana cost reduced by 50%.
    fel_domination = {
        id = 18708,
        cast = 0,
        duration = 15,
        cooldown = 900,
        school = "shadow",
        texture = 136082,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18708 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: -5501, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 18708 #1 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "fel_domination" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Health Funnel - Gives 12-188 health to the caster's pet every second for 10 sec as long as the caster channels.
    health_funnel = {
        id = 755,
        cast = 0,
        duration = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136168,
        range = 20,
        spend = 11,
        spendType = "-2",
        max_stack = 1,
        copy = { 755, 3698, 3699, 3700, 11693, 11694, 11695, 27259 },

        -- Effects:
        -- [ ] Rank 755 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 755 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 3698 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 3698 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 3699 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 3699 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 3700 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 63, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 3700 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11693 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 88, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 11693 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11694 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 118, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 11694 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11695 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 152, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 11695 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27259 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 187, addl_points: 1, points_per_level: 0, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 27259 #1 -- effect: APPLY_AURA, aura: MOD_HEALTH_REGEN_PERCENT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "health_funnel" )
        end,

        proc_chance = 100,
    },

-- Hellfire - Ignites the area surrounding the caster, causing 83/139/208/306 Fire damage to $ghimself:herself; and 83 Fire damage to all nearby enemies every $t2 sec. Lasts 15 sec.
    hellfire = {
        id = 1949,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "fire",
        texture = 135818,
        spend = 645,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1949, 11683, 11684, 27213 },

        -- Effects:
        -- [x] Rank 1949 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 5857
        -- [x] Rank 1949 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 82, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.095, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1949 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11683 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 11681
        -- [x] Rank 11683 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 138, addl_points: 1, points_per_level: 0.5, sp_bonus: 0.095, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11683 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11684 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 11682
        -- [x] Rank 11684 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 207, addl_points: 1, points_per_level: 0.7, sp_bonus: 0.095, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11684 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27213 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 27214
        -- [x] Rank 27213 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 305, addl_points: 1, points_per_level: 0.8, sp_bonus: 0.095, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27213 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        channeled = true,

        handler = function ()
            applyBuff( "hellfire" )
        end,

        proc_chance = 100,
    },

-- Hellfire Effect
    hellfire_effect = {
        id = 5857,
        cast = 0,
        school = "fire",
        texture = 135818,
        max_stack = 1,
        copy = { 5857, 11681, 11682, 27214 },

        -- Effects:
        -- [x] Rank 5857 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 82, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.143, radius_idx: 13, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 11681 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 1, points_per_level: 0.5, sp_bonus: 0.143, radius_idx: 13, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 11682 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 207, addl_points: 1, points_per_level: 0.7, sp_bonus: 0.143, radius_idx: 13, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 27214 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 305, addl_points: 1, points_per_level: 0.8, sp_bonus: 0.143, radius_idx: 13, target: TARGET_DEST_CASTER, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "hellfire_effect" ) end
        end,

        proc_chance = 100,
    },

-- Howl of Terror - Howl, causing $i enemies within $a1 yds to flee in terror for 6/8 sec. Damage caused may interrupt the effect.
    howl_of_terror = {
        id = 5484,
        cast = function () return max( 0, 1.5 + -0.7 * ( talent.improved_howl_of_terror.rank or 0 ) ) end,
        duration = 8,
        category_cooldown = 40,
        gcd = "spell",
        school = "shadow",
        texture = 136147,
        cooldown_category_id = 634,
        cooldown_category = "Howl of Terror",
        spend = 150,
        -- Talent cast scaling: improved_howl_of_terror (-0.7s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 5484, 17928 },

        -- Effects:
        -- [ ] Rank 5484 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 5484 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 17928 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 17928 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Immolate - Burns the enemy for 8-327 Fire damage and then an additional 20-615 Fire damage over 15 sec.
    immolate = {
        id = 348,
        cast = 2,
        duration = 15,
        gcd = "spell",
        school = "fire",
        texture = 135817,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 348, 707, 1094, 2941, 11665, 11667, 11668, 25309, 27215 },

        -- Effects:
        -- [x] Rank 348 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0.037, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 348 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 7, addl_points: 1, points_per_level: 0.6, sp_bonus: 0.058, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 707 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.081, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 707 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 18, addl_points: 1, points_per_level: 0.9, sp_bonus: 0.125, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1094 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1094 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 1.5, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2941 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 2941 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 89, addl_points: 1, points_per_level: 2.1, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11665 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 50, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11665 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 133, addl_points: 1, points_per_level: 2.7, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11667 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 72, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11667 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 191, addl_points: 1, points_per_level: 3.2, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11668 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 96, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11668 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 257, addl_points: 1, points_per_level: 3.8, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25309 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 101, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25309 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 278, addl_points: 1, points_per_level: 3.9, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27215 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 122, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27215 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 326, addl_points: 1, points_per_level: 4.3, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "immolate" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "immolate" ) end
        end,

        proc_chance = 100,
    },

-- Incinerate - Deals 403/444 Fire damage to your target and an additional $/4;s1 Fire damage if the target is affected by an Immolate spell.
    incinerate = {
        id = 29722,
        cast = 2.5,
        gcd = "spell",
        school = "fire",
        texture = 135789,
        range = 30,
        spend = 325,
        spendType = "Mana",
        max_stack = 5,
        copy = { 29722, 32231 },

        -- Effects:
        -- [x] Rank 29722 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 402, addl_points: 65, points_per_level: 2.6, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32231 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 443, addl_points: 71, points_per_level: 2.8, sp_bonus: 0.714, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "incinerate" ) end
        end,

        proc_chance = 100,
        proc_charges = 1,
    },

-- Inferno - Summons a meteor from the Twisting Nether, causing 200 Fire damage and stunning all enemy targets in the area for $20310d. An Infernal rises from the crater, under the command of the caster for $20882d. Once control is lost, the Infernal must be Subjugated to maintain control. Can only be used outdoors.
    inferno = {
        id = 1122,
        cast = 2,
        category_cooldown = 3600,
        gcd = "spell",
        school = "shadow",
        texture = 136219,
        cooldown_category_id = 731,
        cooldown_category = "Summon Infernal",
        range = 30,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1122 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DEST, target2: NONE, mechanic: 0
        -- [ ] Rank 1122 #1 -- effect: TRIGGER_MISSILE_SPELL_WITH_VALUE, aura: NONE, points: 1, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_DEST, target2: NONE, mechanic: 0, trigger_spell_id: 358663

        radius = 10,
    },

-- Life Tap - Converts 20-580 health into 20-580 mana.
    life_tap = {
        id = 1454,
        cast = 0,
        gcd = "spell",
        school = "shadow",
        texture = 136126,
        spendType = "-2",
        max_stack = 1,
        copy = { 1454, 1455, 1456, 11687, 11688, 11689, 27222 },

        -- Effects:
        -- [ ] Rank 1454 #0 -- effect: DUMMY, aura: NONE, points: 19, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 1455 #0 -- effect: DUMMY, aura: NONE, points: 64, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 1456 #0 -- effect: DUMMY, aura: NONE, points: 129, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11687 #0 -- effect: DUMMY, aura: NONE, points: 209, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11688 #0 -- effect: DUMMY, aura: NONE, points: 299, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 11689 #0 -- effect: DUMMY, aura: NONE, points: 419, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27222 #0 -- effect: DUMMY, aura: NONE, points: 579, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 28, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 50000,

        handler = function ()
            local amount = max( 0, math.floor( get_life_tap_base_amount() * ( 1 + ( 0.1 * ( talent.improved_life_tap.rank or 0 ) ) ) + 0.5 ) )

            if amount <= 0 then return end

            if type( state.spend ) == "function" then
                state.spend( amount, "health", true )
            elseif type( spend ) == "function" then
                spend( amount, "health" )
            elseif health then
                health.current = max( 0, health.current - amount )
            end

            if type( state.gain ) == "function" then
                state.gain( amount, "mana" )
            elseif type( gain ) == "function" then
                gain( amount, "mana" )
            elseif mana then
                mana.current = min( mana.max or mana.current, mana.current + amount )
            end
        end,

        proc_chance = 100,
    },

-- Master Demonologist - Reduces threat caused by -20-10%.
    master_demonologist = {
        id = 23759,
        cast = 0,
        school = "shadow",
        texture = 136203,
        range = 50000,
        max_stack = 1,
        copy = { 23759, 23760, 23761, 23762, 23785, 23822, 23823, 23824, 23825, 23826, 23827, 23828, 23829, 23833, 23834, 23835, 23836, 23837, 23838, 23839, 23840, 23841, 23842, 23843, 23844, 35702, 35703, 35704, 35705, 35706 },

        -- Effects:
        -- [ ] Rank 23759 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_THREAT, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23760 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23761 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23762 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.2, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23785 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23822 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23823 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23824 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23825 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23826 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_THREAT, points: -9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23827 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_THREAT, points: -13, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23828 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_THREAT, points: -17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23829 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_THREAT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23833 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23834 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23835 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23836 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23837 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.4, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23838 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.6, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23839 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.8, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23840 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23841 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23842 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23843 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23844 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35702 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35702 #1 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.1, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35703 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35703 #1 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.2, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35704 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35704 #1 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.3, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35705 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35705 #1 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.4, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35706 #0 -- effect: APPLY_AREA_AURA_PET, aura: MOD_DAMAGE_PERCENT_DONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 35706 #1 -- effect: APPLY_AREA_AURA_PET, aura: MOD_RESISTANCE, points: -1, addl_points: 1, points_per_level: 0.5, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "master_demonologist" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Nether Protection - After being hit with a Shadow or Fire spell, you have a $h% chance to become immune to Shadow and Fire spells for $30300d.
    nether_protection = {
        id = 30299,
        cast = 0,
        duration = 4,
        texture = 136178,
        max_stack = 1,
        copy = { 30299, 30300, 30301, 30302 },

        -- Effects:
        -- [x] Rank 30299 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30300
        -- [x] Rank 30300 #0 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 30301 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30300
        -- [x] Rank 30302 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 30300

        handler = function ()
            applyBuff( "nether_protection" )
        end,

        proc_chance = 10,
        proc_type_mask = { 131072, 0 },
        -- Proc type flags: mask0: Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Rain of Fire - Calls down a fiery rain to burn enemies in the area of effect for ${$42223m1*4} Fire damage over 8 sec.
    rain_of_fire = {
        id = 5740,
        cast = 0,
        duration = 8,
        gcd = "spell",
        school = "fire",
        texture = 136186,
        range = 100,
        spend = 295,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5740, 6219, 11677, 11678, 27212, 42218, 42223, 42224, 42225, 42226 },

        -- Effects:
        -- [ ] Rank 5740 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 41, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.237, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5740 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42223
        -- [ ] Rank 6219 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 95, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.237, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6219 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42224
        -- [ ] Rank 11677 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 154, addl_points: 1, points_per_level: 0.5, sp_bonus: 0.237, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11677 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42225
        -- [ ] Rank 11678 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 225, addl_points: 1, points_per_level: 0.6, sp_bonus: 0.237, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11678 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42226
        -- [ ] Rank 27212 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 302, addl_points: 1, points_per_level: 0.8, sp_bonus: 0.237, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27212 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42218
        -- [x] Rank 42218 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 302, addl_points: 1, points_per_level: 0.8, sp_bonus: 0.286, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42223 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 41, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.286, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42224 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 95, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.286, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42225 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 154, addl_points: 1, points_per_level: 0.5, sp_bonus: 0.286, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42226 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 225, addl_points: 1, points_per_level: 0.6, sp_bonus: 0.286, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0

        radius = 8,

        channeled = true,

        handler = function ()
            applyBuff( "rain_of_fire" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "rain_of_fire" ) end
        end,

        proc_chance = 100,
    },

-- Ritual of Doom - Begins a ritual that sacrifices a random participant to summon a doomguard. The doomguard must be immediately subjugated or it will attack the ritual participants. Requires the caster and 4 additional party members to complete the ritual. In order to participate, all players must right-click the portal and not move until the ritual is complete.
    ritual_of_doom = {
        id = 18540,
        cast = 10,
        duration = 60,
        cooldown = 3600,
        gcd = "spell",
        school = "shadow",
        texture = 136120,
        range = 30,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 18540 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 8, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 5,
    },

-- Ritual of Doom Effect - Summons a Doomguard.
    ritual_of_doom_effect = {
        id = 18541,
        cast = 10,
        duration = 15,
        texture = 135741,
        range = 10,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 18541 #0 -- effect: SUMMON, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 13, target: TARGET_DEST_CASTER, target2: NONE, mechanic: 0

        radius = 10,
    },

-- Ritual of Souls - Begins a ritual that creates a Soulwell. Raid members can click the Soulwell to acquire a Master Healthstone. The Soulwell lasts for $29886d or 10 charges. Requires the caster and 2 additional party members to complete the ritual. In order to participate, all players must right-click the soul portal and not move until the ritual is complete.
    ritual_of_souls = {
        id = 29893,
        cast = 0,
        duration = 60,
        category_cooldown = 300,
        gcd = "spell",
        school = "shadow",
        texture = 136194,
        cooldown_category_id = 1177,
        cooldown_category = "Ritual of Souls/Refreshment",
        range = 30,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 29893 #0 -- effect: TRANS_DOOR, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 8, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 5,

        proc_chance = 100,
    },

-- Ritual of Summoning - Begins a ritual that summons the targeted group member. Requires the caster and 2 additional party members to complete the ritual. In order to participate, all players must be out of combat and right-click the portal and not move until the ritual is complete.
    ritual_of_summoning = {
        id = 698,
        cast = 5,
        gcd = "spell",
        school = "shadow",
        texture = 136223,
        range = 30,
        spend = 300,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 698 #0 -- effect: TRIGGER_SPELL_2, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0, trigger_spell_id: 46546
    },

-- Searing Pain - Inflict searing pain on the enemy target, causing 34-270 Fire damage. Causes a high amount of threat.
    searing_pain = {
        id = 5676,
        cast = 1.5,
        gcd = "spell",
        school = "fire",
        texture = 135827,
        range = 30,
        spend = 45,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5676, 17919, 17920, 17921, 17922, 17923, 27210, 30459 },

        -- Effects:
        -- [x] Rank 5676 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 33, addl_points: 9, points_per_level: 0.7, sp_bonus: 0.396, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17919 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 58, addl_points: 13, points_per_level: 1, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17920 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 85, addl_points: 19, points_per_level: 1.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17921 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 121, addl_points: 25, points_per_level: 1.5, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17922 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 157, addl_points: 31, points_per_level: 1.7, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17923 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 203, addl_points: 37, points_per_level: 2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27210 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 242, addl_points: 45, points_per_level: 2.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30459 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 269, addl_points: 51, points_per_level: 2.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "searing_pain" ) end
        end,

        proc_chance = 100,
    },

-- Seed of Corruption - Imbeds a demon seed in the enemy target, causing 1044 Shadow damage over 18 sec. When the target takes 1044 total damage or dies, the seed will inflict 1110 Shadow damage to all other enemies within $27285a1 yards of the target. Only one Corruption spell per Warlock can be active on any one target.
    seed_of_corruption = {
        id = 27243,
        cast = 2,
        duration = 18,
        gcd = "spell",
        school = "shadow",
        texture = 136193,
        range = 30,
        spend = 882,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 27243 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 173, addl_points: 1, points_per_level: 0, sp_bonus: 0.25, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27243 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 1043, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "seed_of_corruption" )
        end,

        proc_chance = 100,
    },

-- Sense Demons - Shows the location of all nearby demons on the minimap until cancelled. Only one form of tracking can be active at a time.
    sense_demons = {
        id = 5500,
        cast = 0,
        gcd = "spell",
        school = "shadow",
        texture = 136172,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5500 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "sense_demons" )
        end,
    },

-- Shadow Bolt - Sends a shadowy bolt at the enemy, causing 12-541 Shadow damage.
    shadow_bolt = {
        id = 686,
        cast = 1.7,
        gcd = "spell",
        school = "shadow",
        texture = 136197,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 686, 695, 705, 1088, 1106, 7641, 11659, 11660, 11661, 25307, 27209 },

        -- Effects:
        -- [x] Rank 686 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 11, addl_points: 5, points_per_level: 0.4, sp_bonus: 0.14, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 695 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 22, addl_points: 7, points_per_level: 0.6, sp_bonus: 0.299, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 705 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 47, addl_points: 9, points_per_level: 0.9, sp_bonus: 0.56, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1088 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 85, addl_points: 13, points_per_level: 1.2, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1106 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 141, addl_points: 21, points_per_level: 1.6, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 7641 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 203, addl_points: 27, points_per_level: 1.9, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11659 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 280, addl_points: 35, points_per_level: 2.3, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11660 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 359, addl_points: 43, points_per_level: 2.6, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11661 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 454, addl_points: 53, points_per_level: 3, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25307 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 481, addl_points: 57, points_per_level: 3.1, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27209 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 540, addl_points: 63, points_per_level: 3.4, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shadow_bolt" ) end
        end,

        proc_chance = 100,
    },

-- Shadow Embrace - Your Corruption, Curse of Agony, Siphon Life and Seed of Corruption spells also cause the Shadow Embrace effect, which reduces physical damage caused by 1%.
    shadow_embrace = {
        id = 32385,
        cast = 0,
        texture = 136198,
        range = 100,
        max_stack = 1,
        copy = { 32385, 32386, 32387, 32388, 32389, 32390, 32391, 32392, 32393, 32394 },

        -- Effects:
        -- [x] Rank 32385 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 32386
        -- [x] Rank 32385 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32386 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: -2, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32387 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 32388
        -- [x] Rank 32387 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32388 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32389 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: -4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32390 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: -5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32391 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: -6, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 32392 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 32389
        -- [x] Rank 32392 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32393 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 32390
        -- [x] Rank 32393 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 32394 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 32391
        -- [x] Rank 32394 #1 -- effect: APPLY_AURA, aura: OVERRIDE_CLASS_SCRIPTS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "shadow_embrace" )
            applyBuff( "shadow_embrace" )
        end,

        proc_chance = 100,
        proc_type_mask = { 65536, 0 },
        -- Proc type flags: mask0: Deal Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Shadow Ward - Absorbs 290/470/675/875 shadow damage. Lasts 30 sec.
    shadow_ward = {
        id = 6229,
        cast = 0,
        duration = 30,
        category_cooldown = 30,
        gcd = "spell",
        school = "shadow",
        texture = 136121,
        cooldown_category_id = 56,
        cooldown_category = "Instant Heal - Spell",
        spend = 135,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6229, 11739, 11740, 28610 },

        -- Effects:
        -- [x] Rank 6229 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 289, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11739 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 469, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 11740 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 674, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 28610 #0 -- effect: APPLY_AURA, aura: SCHOOL_ABSORB, points: 874, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "shadow_ward" )
        end,
    },

-- Shadowburn - Instantly blasts the target for 87-597 Shadow damage. If the target dies within $29341d of Shadowburn, and yields experience or honor, the caster gains a Soul Shard.
    shadowburn = {
        id = 17877,
        cast = 0,
        category_cooldown = 15,
        gcd = "spell",
        school = "shadow",
        texture = 136191,
        cooldown_category_id = 651,
        cooldown_category = "Shadowburn",
        range = 20,
        spend = 105,
        spendType = "Mana",
        max_stack = 1,
        copy = { 17877, 18867, 18868, 18869, 18870, 18871, 27263, 30546 },

        -- Effects:
        -- [ ] Rank 17877 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 17877 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 86, addl_points: 13, points_per_level: 1.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 18867 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 18867 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 114, addl_points: 17, points_per_level: 1.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 18868 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 18868 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 185, addl_points: 25, points_per_level: 1.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 18869 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 18869 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 260, addl_points: 33, points_per_level: 2.2, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 18870 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 18870 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 349, addl_points: 43, points_per_level: 2.6, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 18871 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 18871 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 449, addl_points: 53, points_per_level: 3, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27263 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 27263 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 517, addl_points: 61, points_per_level: 3.4, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30546 #0 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 29341
        -- [x] Rank 30546 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 596, addl_points: 69, points_per_level: 3.8, sp_bonus: 0.429, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shadowburn" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Shadowfury - Shadowfury is unleashed, causing 343/459/612 Shadow damage and stunning all enemies within $a1 yds for 2 sec.
    shadowfury = {
        id = 30283,
        cast = 0.5,
        duration = 2,
        category_cooldown = 20,
        gcd = "spell",
        school = "shadow",
        texture = 136201,
        cooldown_category_id = 250,
        cooldown_category = "Blast Wave",
        range = 30,
        spend = 440,
        spendType = "Mana",
        max_stack = 1,
        copy = { 30283, 30413, 30414 },

        -- Effects:
        -- [x] Rank 30283 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 342, addl_points: 65, points_per_level: 1.6, sp_bonus: 0.193, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30283 #1 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: stunned
        -- [x] Rank 30413 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 458, addl_points: 89, points_per_level: 1.9, sp_bonus: 0.193, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30413 #1 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: stunned
        -- [x] Rank 30414 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 611, addl_points: 117, points_per_level: 2.2, sp_bonus: 0.193, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 30414 #1 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: stunned
        startsCombat = true,

        radius = 8,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "shadowfury" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
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

-- Siphon Life - Transfers 15-63 health from the target to the caster every $t1 sec. Lasts 30 sec.
    siphon_life = {
        id = 18265,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "shadow",
        texture = 136188,
        range = 30,
        spend = 140,
        spendType = "Mana",
        max_stack = 1,
        copy = { 18265, 18879, 18880, 18881, 27264, 30911 },

        -- Effects:
        -- [x] Rank 18265 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18879 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 21, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18880 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18881 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27264 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 51, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30911 #0 -- effect: APPLY_AURA, aura: PERIODIC_LEECH, points: 62, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "siphon_life" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Soul Fire - Burn the enemy's soul, causing 623/703/839/1003 Fire damage.
    soul_fire = {
        id = 6353,
        cast = 6,
        category_cooldown = 60,
        gcd = "spell",
        school = "fire",
        texture = 135808,
        cooldown_category_id = 631,
        cooldown_category = "Soul Fire",
        range = 30,
        spend = 170,
        spendType = "Mana",
        max_stack = 1,
        copy = { 6353, 17924, 27211, 30545 },

        -- Effects:
        -- [x] Rank 6353 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 622, addl_points: 161, points_per_level: 2.9, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17924 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 702, addl_points: 179, points_per_level: 3.1, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27211 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 838, addl_points: 213, points_per_level: 3.5, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30545 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 1002, addl_points: 255, points_per_level: 3.8, sp_bonus: 1.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "soul_fire" ) end
        end,

        proc_chance = 100,
    },

-- Soul Link - When active, 20% of all damage taken by the caster is taken by your Imp, Voidwalker, Succubus, Incubus, Felhunter, Felguard, or subjugated demon instead. That damage cannot be prevented. In addition, both the demon and master will inflict 5% more damage. Lasts as long as the demon is active and controlled.
    soul_link = {
        id = 19028,
        cast = 0,
        gcd = "spell",
        school = "shadow",
        texture = 136160,
        range = 100,
        spend_pct = 16,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19028 #0 -- effect: DUMMY, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
    },

-- Soulshatter - Reduces threat by 50% for all enemies within $a1 yards.
    soulshatter = {
        id = 29858,
        cast = 0,
        cooldown = 300,
        gcd = "spell",
        school = "shadow",
        texture = 135728,
        spend_pct = 8,
        spendType = "-2",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 29858 #0 -- effect: DUMMY, aura: NONE, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 27, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0

        radius = 50,

        proc_chance = 100,
    },

-- Subjugate Demon - Subjugates the target demon, up to level $m1, forcing it to do your bidding. While subjugated, the time between the demon's attacks is increased by 40% and its casting speed is slowed by 30%. Lasts up to 300 sec. If you repeatedly subjugate the same demon, it will become more difficult to control with each attempt.
    subjugate_demon = {
        id = 1098,
        cast = 3,
        duration = 300,
        gcd = "spell",
        school = "shadow",
        texture = 136154,
        range = 30,
        spend = 300,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1098, 11725, 11726 },

        -- Effects:
        -- [x] Rank 1098 #0 -- effect: APPLY_AURA, aura: MOD_CHARM, points: 31, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1098 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1098 #2 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11725 #0 -- effect: APPLY_AURA, aura: MOD_CHARM, points: 46, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11725 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11725 #2 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11726 #0 -- effect: APPLY_AURA, aura: MOD_CHARM, points: 61, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11726 #1 -- effect: APPLY_AURA, aura: MOD_MELEE_HASTE, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 11726 #2 -- effect: APPLY_AURA, aura: MOD_CASTING_SPEED_NOT_STACK, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "subjugate_demon" )
        end,

        proc_chance = 100,
    },

-- Summon Dreadsteed - Summons a Dreadsteed, which serves as a mount for the caster. Speed is increased by 100%.
    summon_dreadsteed = {
        id = 23161,
        cast = 3,
        gcd = "spell",
        school = "shadow",
        texture = 132238,
        spend = 150,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 23161 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 23161 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 23161 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "summon_dreadsteed" )
        end,
    },

-- Summon Felguard - Summons a Felguard under the command of the Warlock.
    summon_felguard = {
        id = 30146,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136216,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 30146 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "felguard" ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Summon Felhunter - Summons a Felhunter under the command of the Warlock.
    summon_felhunter = {
        id = 691,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136217,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 691 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "felhunter" ) end
        end,
    },

-- Summon Felsteed - Summons a Felsteed, which serves as a mount for the caster. Speed is increased by 60%.
    summon_felsteed = {
        id = 5784,
        cast = 3,
        gcd = "spell",
        school = "shadow",
        texture = 136103,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5784 #0 -- effect: APPLY_AURA, aura: MOUNTED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5784 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_MOUNTED_SPEED, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 5784 #2 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "summon_felsteed" )
        end,
    },

-- Summon Imp - Summons an Imp under the command of the Warlock.
    summon_imp = {
        id = 688,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136218,
        spend_pct = 64,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 688 #0 -- effect: SUMMON_PET, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "imp" ) end
        end,
    },

-- Summon Incubus - Summons an Incubus under the command of the Warlock.
    summon_incubus = {
        id = 713,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 4352492,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 713 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "incubus" ) end
        end,
    },

-- Summon Succubus - Summons a Succubus under the command of the Warlock.
    summon_succubus = {
        id = 712,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136220,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 712 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "succubus" ) end
        end,
    },

-- Summon Voidwalker - Summons a Voidwalker under the command of the Warlock.
    summon_voidwalker = {
        id = 697,
        cast = 10,
        gcd = "spell",
        school = "shadow",
        texture = 136221,
        spend_pct = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 697 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "voidwalker" ) end
        end,
    },

-- Unending Breath - Allows the target to breathe underwater for 600 sec.
    unending_breath = {
        id = 5697,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "shadow",
        texture = 136148,
        range = 30,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5697 #0 -- effect: APPLY_AURA, aura: WATER_BREATHING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "unending_breath" )
        end,
    },

-- Unstable Affliction - Shadow energy slowly destroys the target, causing 660/840/1050 damage over 5/18 sec. In addition, if the Unstable Affliction is dispelled it will cause $*9;s1 damage to the dispeller and silence them for $31117d.
    unstable_affliction = {
        id = 30108,
        cast = 1.5,
        duration = 5,
        gcd = "spell",
        school = "shadow",
        texture = 136228,
        range = 50000,
        spend = 270,
        spendType = "Mana",
        max_stack = 1,
        copy = { 30108, 30404, 30405, 31117 },

        -- Effects:
        -- [x] Rank 30108 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30404 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 139, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 30405 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 174, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31117 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 31117 #1 -- effect: APPLY_AURA, aura: MOD_SILENCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: silenced

        handler = function ()
            applyDebuff( "target", "unstable_affliction" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "unstable_affliction" ) end
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

spec:RegisterRanges( "shadowburn", "conflagrate", "corruption", "curse_of_agony", "curse_of_doom", "drain_life" )

spec:RegisterStateExpr( "wowsim_warlock_dot_doom_window", function()
    return target.time_to_die >= 60 and debuff.curse_of_doom.down and 1 or 0
end )
spec:RegisterStateExpr( "wowsim_warlock_dot_agony_window", function()
    return target.time_to_die < 60 and target.time_to_die > 30 and debuff.curse_of_agony.down and debuff.curse_of_doom.down and 1 or 0
end )
spec:RegisterStateExpr( "wowsim_warlock_dot_immolate_upkeep", function()
    return debuff.immolate.down and 1 or 0
end )
spec:RegisterStateExpr( "wowsim_warlock_shadowburn_finish_threshold", function()
    return 20
end )
spec:RegisterStateExpr( "wowsim_warlock_life_tap_urgent_mana", function()
    return mana.pct < 20 and target.time_to_die > 20 and cooldown.inferno.remains < 15 and 1 or 0
end )
spec:RegisterStateExpr( "wowsim_warlock_life_tap_fill_mana", function()
    return mana.pct < 60 and target.time_to_die > 20 and cooldown.inferno.remains >= 2 and cooldown.inferno.remains < 15 and 1 or 0
end )

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

    package = "Affliction",
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
spec:RegisterPet( "eye_of_kilrogg", 126, "eye_of_kilrogg", 45 )
spec:RegisterPet( "felguard", 30146, "summon_felguard", 3600 )
spec:RegisterPet( "felhunter", 691, "summon_felhunter", 3600 )
spec:RegisterPet( "imp", 688, "summon_imp", 3600 )
spec:RegisterPet( "incubus", 713, "summon_incubus", 3600 )
spec:RegisterPet( "succubus", 712, "summon_succubus", 3600 )
spec:RegisterPet( "voidwalker", 697, "summon_voidwalker", 3600 )

spec:RegisterPack( "Affliction", 20230226, [[Hekili:DRvwVrkoq4FlJgj0UkjmaD6CSIULM9HvAYoA0kX8mGdTjTv4sG7otl1IF7BzmnymMJC0AL2xMjbB)vhUQVQCP4A6(txNnik29hwgwlmSSUv3000WWY1HEid76KHcEg9e8djOy4F)AyyejGsstylDikfTHbrr6U8ayzxNh3rIOFlX9r14A66G2r3MM7683KO0axNTKnBW89JlGFNT)RmSUY62)O0)Vi)Q0)7KqCP)przL(rPprck9PPL(jP0s)CCyoUyBP)lFb(0trhYGFgb63ESURtePGwWuViab4))rL5IQv)nyeDRxqkjY1bNGEmcVX9pDPGg3zx5isIxfaD2fLbqiAxeTb42LDcYjuCobXXzp2dNGJj4Is)vL(ML(AGnGYFct13Irr0T6zbG1SU036MwrNVlXJ)ZEmlHBpE87HcAJMolXAx6FDLyLxy9hJ(GsXmfAXSvia7fFaYTadcce81dkyf4BpF8X)chSJwzBlhueYyVCEyxfuvfjLLJdsJFePmw6euH4ipuEml1HLPKtY4F)R)Z3l93Vq)ADZRm1VrFzP)Nf1Uh3fgQxDq9nPVKu6F8yPVWhZXXqiopgX8oJXJR(uPFg4n53Mv3FCfVkW2Ovzl2fhd2mOZB3LaND8GJxjQ7tjBEbf9mh2HV6FLWsIZg)EUIFrNDT5rrz617Pc4k)zZkm)Cl8N(md8Be5wYs5)Fh2NBhjsocNq1b1mpDpEJxXweiiVhtJOD0LcmLssEQqVEdXOcaHdvRTbxPPDxrsFfWLhEEkjqMbvP(3H9Cxb2du)4cPnnCOWMuQ(UKckBjput1MorPbGA7rjX87u2j2IGOS29SUZEUaizYr7H0NMFpcknLeWDjSp6rt92qG1wZ4NfYFvOktgZrjbpd(FEIMcTZE1mvVw1OcHXdoLfCgoVa4AGigVyOkfjlIGZRCnmvkinpFxfbIEw7YTcSD9MOw1xx84P4dEb7YlW1mmQ8QwxlGoBVEPHEONstomEuFmkb1qTAAWnUzNjkg2SuDk5DdNWjAdmPlycBpWCWzq5hGFpahHZrN8w3ZaKWy9yUqpsidPGNlwVYu736fpyVQjw4cH4GlQJboECImc7vCvs5EAHUgoT6YHcMgOwlbPO4Iu5MTU(3L7oc6(lQx3rSocgTZOZ(fRCvmfX2obhcIyhGzNfmTfuRF519RoMQZZurKngVX8e2IHfMmRZaPtVB5itY0LfAEWpIptMnrvW0K9VTuHEmkpIeRxt8tDfKrR5uVNU(5EllrZROzBqXxmsD2IjElHif)G1YpBfbgUPWUC9L(3BmlEYXBc49usFYluBz06vX9Su4FM2WBUUF7ZPKVsmxEMDmJ0IGYuJj1eypc0gVPwhu5lynFDJrf8TfGyp4K)nssiopj17eEnYTEHXByqvr0Xu97)VR4OPbt29ixDDSfFASYo8nhMHQgVnaNdkjOURjdzkVWi27FzincNYz7XodhRBne38pmxi(QgXfLB7PAGeJYI)k9rd1fdtqSGPoDZ0ie5kpnJBrmNsvb0HjLp3HKvUV9ScwWc1Jn04oxNxq5jSByxNVfNLMtzWFlV2Ak8wJQH8Px(a4rYWbSCkhiKjKeHDD(CPVQPJu(a)Wf6ndE5IvFPz(kxscxjn0KJh7pWeBZ7muJK8Wpya(P2jrOX34QXpD7qoEthhsCEDN70nb7uQVv16pKd1qXzngq9AZDysAgP5AdKIRn8SmkFOr4GiLMb3LSPVTQOs8DttG3N1JqCT1ntIf8uN(GzFTw3pS(nIolrVp8Rx82qREwoCFV05TNX5zx)SdlEQLc(B9c2TClPuvqynJZa3y1RE8OYUvxpCNQscDGwnRmvHxWEVH05u0gc7m96Bz9OpuxBQ3P37T4YQptwIUl(t)7oSGrvH5zxn3gkEDV5Y3Tz0TlhLoYPKH2jvuc66EWeIDf0D7v3yODQg1AldnPw5MwnvnkRUhsKJ8KOSnnoECweMN8GlLqLtxEzV0XvI5J8Tk0BGGx4uReGQOC)Nr22(rfwdRcI0e18qkQw0UsZ0JvU4WzTZk8v71MFlnYmv60SsHhFEFQGvnB67HVua7zLhOjncqvi9HNCi4xNfZUTPs9QDSsxkou2v))AMSDkbdoQxjzr9j69MIl78gHvMkBerbDnhVpSqIwKHET(ibUlSJy39gXj3x0305iPIDAAixmgKszQVt04uvtdYOwPqQLItPO)YEECPcuQhs7K9lm8Wz7ZYl1vU9cXOlwicZUA(tdP)sT)9GWEWQ7)c]] )

spec:RegisterPack( "Demonology (wowtbc.gg)", 20230625, [[Hekili:TI12UTnoq0VLIcySlAI8LCTfj5HfDxGMTBEXfOVjjAkkjctjkqsfddeOV9DiPUqjl54K2xILiN5mdN5Wzgf)L()WFDesr8FA1IvxS46vx5T8QfxV8w)1Q9fe)1fi8wuc8qokd(7xjz8CoJNSVk8p2X3P2G9ss(tTC7zCuKgpjVuGbztvQc5xMpVvm4jfB7CmdjLNNusJiY5rTaE(oKGXXBN7VEtjLP(wU)MHohaEbb7)0Nb0PrreRiej2F9psPYQWcbLlOkW72HGx3bpRi5vHBqssuvihEuLsGnA8PQWFkqQuyR46T(ofdV(V0CypJt6v9y1JAp48fRoF1nFPkSk8VZLLcqyfsKquaEugRkKrFgwJXZticnAOgZHrsqifntB6uTdjiyEwgjpYyN18sq9)HkCn21NV6kJX(p0wIRmaEPe82QWyoyMVsW0mKIQpBBkJHJH(a54aigjx55VMrLkPobH4e4NNmjFsoAdJe5)x(RXqWIiOiqaScojbKCsgLaHXhQcVWUkp3FDgrHY4IIuUKk9vq2zsG(qvyzrNM0SmoZ4QbOsbsR7fVtNqMII47IzAwjaZLVxyiKOaECaMleLfM1a0UAaAns7iv)dPII3AsKZQchAW7QcVeeFpMrcS0fPo2dM56jmtDyI87Wik99Jyujt1MYBmJ5QhfhqYk47icGmQCDNMeBJ4fC7V9Ky603ah26uE6RabkEqeLysfrCLxZX1lc4ewBCqK4OP4iIM37LTpaxkKao8D5gJAEnirWllaDAr1SGv2XY2hhyhUdu2QdLHjZ3tKOJFnsSOpf9MjnxmnjvfiiziAULVVA5IQWxEbkpWLsJpmqgn7zXrUGFRlpOecPGTYKdOcFEspYgeDb1RSWnwebvMq5yBG42bm0aCQwkTjwU4xOsZY3u9ULq(vjOyTIo5aeJfyFjqxo1wunW2Buxwvl(0LdRlftZke8NHcp2IybB4mLxTcMWsnVRE7mO5brS3ZnDPBOey7N8jibpSUObsJZm9f0e2(IupgnwxXOON9nwVDN(S(MLnOFPlXOpTPp5y50xYmglQTj2aQXWRjThC37HLSGyOVOXqtFp0sdHadjxxVN41JWKJP5erDTML34EWCJP9owWRfMg5BqQJ3r1yBKacpdcNXeGqPx)vBKwardlr1XZkZ03qaqskrIOxTI8rW4zonAhITLioEX2JJcqTpEj1FdSURF1UstxC8eUbooXYKSFMiK6DCMhfgAnhQSd89VbTrfk9z5cB)z9azMzUGz60efEmLbrSp(r9mBDJr)t7yVvpQ3y1vvHpwMdCDTj0ZcArs61s0(09ZBjnNrJVFa1ACngqu069HU04r1PJy8w0cIWNK4njwTWJZnMDiVyCOSuHj8QMuP2oNajWjYdApYKsUBpWWWknZTycb1n)NDyfThgD8hxGCgvrJ1ydKmR3uoUk3nGYu66kD38fNIxpYOkUG1RxGgVEtC8amrYlVONgzwV1V7YfUG0oPXb5I6zcAP)dhUy2GblE42rYo06HdmhxORJBSyqF(Z0D4VhAWFMDOG7xQvYYRBgB4HL9I9DCQtKYn7OD9VRTX3Nw5ANFT7pdZu9zpoxzoSj9yeJUPsCJ2TDw7sx9AcpryZT4he5hJunibCXqfELeDTuoFk5Pa6HFY4POLJ09(knltQ92wFyU7YjorK3eiqhTsvkmIX62)ThM(z())d]] )

spec:RegisterPack( "Destruction", 20230204, [[Hekili:1EvBloUnq4FlhhKV09CTDYMBlKeOh9d92wwkK(zBRylNiwzlJS8EeWOF7DKKF3YjPuklSjXAMNzMN5n5aVG)o4ycsGdEZ31FTRV7ghp3nF175GJIRf4GJfO43rNHVKJYG))B4sbVkwqy5QZUszOefgLSkEmCEWXtveQ475bNSd8Aq2cCCWB)sWXlKKeSrsCz8iWLr)aXPS43LrfCcJtexLrPmUm63XVtOKGJusPOuzAkjfdF(MowqnUwcgjUegZi0GJ4C0jkoj4BbcWBgjfhrYd1amskHcGuufv0bC)XhJbVbZjidoFGdX54mcUugTtg53JoVkp089qLZAC5qdpwk6CMhc5dYiVhdzedRGE9IqFbJOIlofXcJd)8JHRML0utbhhZYoHSsoTqLIPHiEgJBsUCsH55)6F9NYOpw7SXX9lEW)9LrFEO3DQkn1rROtc7hqDqDTmAWd54miNz4AVxCVnl(jO6blCmKzVVvwLLbHijR42m1z61IloQapuGkCAKrgTQXJ6or5P9W3(yf4BgwUvWmFoPutLXUbtwEbb4Ns1zHBwHSw7Ace)me0jqQdLhJnmLlO61yQYVuNwQmNfQRZMyCsilfAG48QMm3dyAGVfK43j5NTBUPuDR5iq(GQgwmo3DtS2SawdDzkjhhgNeCCRfmgyRm2hk7OZgL3PNpbRZ9zxdJR4L4MQui41)m8mNvva607p6hdCP4cqzuCgohS)9kBBcDt5Fct40srJBaSqHT0CpFKd1oN5A6D0OWPm4TJrlre6ml)QcPN))SfA7OO5cIvgEIbtMhhmF9FfB2xKmIp9TwgbO)Y9AJH1zdKOc4hW8zLtecAdxYlB6AfKmiWzHjevJ7Ez0wxnzLHYrMr2qZMV5zK8umpNf2rQQORbNjd53yvJbvpMd0(4sZHSplOP1zyRMcKLlUnkmjOax8fxtam6HQ5w2Qj8gvItYJbRBPc3B5sCB89Ho6(bBasySmTDwUbWAETZol4fRDVr3MEk1hyEP6yZTR88HjbWfMYbMfQ5(EwbJluveplJm4iJ03xYr(QA)nlLqbU6ZYiBRJLVA0P0PBt)pT)N7wO)ejD)KT011Z3qVd2oBhP(1VkO(u)gA7I3M3vcBFCYQ5JsSdLPZv(QmQ5VwPGZMC3NNu36zp8jy1X7725Fx1Gn6Z17G3D1tfckf77E35)CVZA7BTHzPk(0lFmLSkySvfVA0AQj63UerNxAgAwxBB9ZoVjQoynZKtkzu2T9Pjk8FmHBCNU9eZ8Z2PyZdY5BfgKRnQ3wbn6HDJ7NsNMPQkdnVrF3(TURAh2DW3D1KHZ11ZgLVBZmPwo6AgiVFRY8ndDxMNnc05p7EXTUU7hEUluV1p4DQFmCcP94)ae(pqXW4XFlqLauwmWAy(tpAqpPQyS)Y0pn6gH79S0XUE1KltROIPio7QYpeWTvEtHRRf0cilPJ1SUf9BRc61xvcaa0)2YZpAWRiJQexuVq3FqG3m)lFdcMeIwA9oPG)5d]] )


spec:RegisterPackSelector( "affliction", "Affliction", "|T136145:0|t Affliction",
    "If you have spent more points in |T136145:0|t Affliction than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "demonology", "Demonology (wowtbc.gg)", "|T136172:0|t Demonology",
    "If you have spent more points in |T136172:0|t Demonology than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "destruction", "Destruction", "|T136186:0|t Destruction",
    "If you have spent more points in |T136186:0|t Destruction than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

