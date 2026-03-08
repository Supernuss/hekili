-- Hunter.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Hunter (#3)

if UnitClassBase( "player" ) ~= "HUNTER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 3 )

spec:RegisterGear( "tier4", 29081, 29082, 29083, 29084, 29085 )
spec:RegisterGear( "tier5", 30139, 30140, 30141, 30142, 30143 )
spec:RegisterGear( "tier6", 31001, 31003, 31004, 31005, 31006 )
spec:RegisterGear( "sunwell", 34443, 34549, 34570 )

local function clear_hunter_aspects()
    removeBuff( "aspect_of_the_beast" )
    removeBuff( "aspect_of_the_cheetah" )
    removeBuff( "aspect_of_the_hawk" )
    removeBuff( "aspect_of_the_monkey" )
    removeBuff( "aspect_of_the_pack" )
    removeBuff( "aspect_of_the_viper" )
    removeBuff( "aspect_of_the_wild" )
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
    aimed_shot = { 1345, 1, 19434 },
    animal_handler = { 1799, 2, 34453, 34454 },
    barrage = { 1347, 3, 19461, 19462, 24691 },
    bestial_discipline = { 1390, 2, 19590, 19592 },
    bestial_swiftness = { 1391, 1, 19596 },
    bestial_wrath = { 1386, 1, 19574 },
    careful_aim = { 1806, 3, 34482, 34483, 34484 },
    catlike_reflexes = { 1801, 3, 34462, 34464, 34465 },
    clever_traps = { 1306, 2, 19239, 19245 },
    combat_experience = { 1804, 2, 34475, 34476 },
    concussive_barrage = { 1351, 3, 35100, 35102, 35103 },
    counterattack = { 1312, 1, 19306 },
    deflection = { 1311, 5, 19295, 19297, 19298, 19301, 19300 },
    deterrence = { 1308, 1, 19263 },
    efficiency = { 1342, 5, 19416, 19417, 19418, 19419, 19420 },
    endurance_training = { 1389, 5, 19583, 19584, 19585, 19586, 19587 },
    entrapment = { 1304, 3, 19184, 19387, 19388 },
    expose_weakness = { 1812, 3, 34500, 34502, 34503 },
    ferocious_inspiration = { 1800, 3, 34455, 34459, 34460 },
    ferocity = { 1393, 5, 19598, 19599, 19600, 19601, 19602 },
    focused_fire = { 1624, 2, 35029, 35030 },
    frenzy = { 1397, 5, 19621, 19622, 19623, 19624, 19625 },
    go_for_the_throat = { 1818, 2, 34950, 34954 },
    hawk_eye = { 1820, 3, 19498, 19499, 19500 },
    humanoid_slaying = { 1301, 3, 19151, 19152, 19153 },
    improved_arcane_shot = { 1346, 5, 19454, 19455, 19456, 19457, 19458 },
    improved_aspect_of_the_hawk = { 1382, 5, 19552, 19553, 19554, 19555, 19556 },
    improved_aspect_of_the_monkey = { 1381, 3, 19549, 19550, 19551 },
    improved_barrage = { 1821, 3, 35104, 35110, 35111 },
    improved_concussive_shot = { 1341, 5, 19407, 19412, 19413, 19414, 19415 },
    improved_feign_death = { 1309, 2, 19286, 19287 },
    improved_hunters_mark = { 1343, 5, 19421, 19422, 19423, 19424, 19425 },
    improved_mend_pet = { 1385, 2, 19572, 19573 },
    improved_revive_pet = { 1625, 2, 24443, 19575 },
    improved_stings = { 1348, 5, 19464, 19465, 19466, 19467, 19468 },
    improved_wing_clip = { 1305, 3, 19228, 19232, 19233 },
    intimidation = { 1387, 1, 19577 },
    killer_instinct = { 1321, 3, 19370, 19371, 19373 },
    lethal_shots = { 1344, 5, 19426, 19427, 19429, 19430, 19431 },
    lightning_reflexes = { 1303, 5, 19168, 19180, 19181, 24296, 24297 },
    master_marksman = { 1807, 5, 34485, 34486, 34487, 34488, 34489 },
    master_tactician = { 1813, 5, 34506, 34507, 34508, 34838, 34839 },
    monster_slaying = { 1623, 3, 24293, 24294, 24295 },
    mortal_shots = { 1349, 5, 19485, 19487, 19488, 19489, 19490 },
    pathfinding = { 1384, 2, 19559, 19560 },
    ranged_weapon_specialization = { 1362, 5, 19507, 19508, 19509, 19510, 19511 },
    rapid_killing = { 1819, 2, 34948, 34949 },
    readiness = { 1814, 1, 23989 },
    resourcefulness = { 1809, 3, 34491, 34492, 34493 },
    savage_strikes = { 1621, 2, 19159, 19160 },
    scatter_shot = { 1353, 1, 19503 },
    serpents_swiftness = { 1802, 5, 34466, 34467, 34468, 34469, 34470 },
    silencing_shot = { 1808, 1, 34490 },
    spirit_bond = { 1388, 2, 19578, 20895 },
    surefooted = { 1310, 3, 19290, 19294, 24283 },
    survival_instincts = { 1810, 2, 34494, 34496 },
    survivalist = { 1622, 5, 19255, 19256, 19257, 19258, 19259 },
    the_beast_within = { 1803, 1, 34692 },
    thick_hide = { 1395, 3, 19609, 19610, 19612 },
    thrill_of_the_hunt = { 1811, 3, 34497, 34498, 34499 },
    trap_mastery = { 1322, 2, 19376, 19377 },
    trueshot_aura = { 1361, 1, 19506 },
    unleashed_fury = { 1396, 5, 19616, 19617, 19618, 19619, 19620 },
    wyvern_sting = { 1325, 1, 19386 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    aimed_shot = {
        id = 19434,
        duration = 10,
        max_stack = 1,
        copy = { 19434, 27065 },
        -- Aura effects: MOD_HEALING_PCT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    arcane_torrent = {
        id = 28730,
        duration = 2,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    aspect_of_the_beast = {
        id = 13161,
        max_stack = 1,
        -- Aura effects: UNTRACKABLE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    aspect_of_the_cheetah = {
        id = 5118,
        max_stack = 1,
        -- Aura effects: MOD_INCREASE_SPEED, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    aspect_of_the_hawk = {
        id = 13165,
        max_stack = 1,
        copy = { 13165, 14318, 14319, 14320, 14321, 14322, 25296, 27044 },
        -- Aura effects: MOD_RANGED_ATTACK_POWER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    aspect_of_the_monkey = {
        id = 13163,
        max_stack = 1,
        -- Aura effects: MOD_DODGE_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    aspect_of_the_viper = {
        id = 34074,
        tick_time = 5,
        max_stack = 1,
        -- Aura effects: PERIODIC_DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    beast_lore = {
        id = 1462,
        duration = 30,
        max_stack = 1,
        -- Aura effects: EMPATHY
        -- Aura targets: TARGET_UNIT_TARGET_ANY
    },

    bestial_wrath = {
        id = 19574,
        duration = 18,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_DAMAGE_PERCENT_DONE, MOD_SCALE
        -- Aura targets: TARGET_UNIT_PET
    },

    black_arrow = {
        id = 3674,
        duration = 30,
        tick_time = 2,
        max_stack = 1,
        copy = { 3674, 14296 },
        -- Aura effects: MOD_DECREASE_SPEED, PERIODIC_DAMAGE, PERIODIC_MANA_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    blood_fury = {
        id = 20572,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_ATTACK_POWER, MOD_RANGED_ATTACK_POWER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    concussive_barrage = {
        id = 35100,
        duration = 4,
        max_stack = 1,
        copy = { 35100, 35101, 35102, 35103 },
        -- Aura effects: MOD_DECREASE_SPEED, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    concussive_shot = {
        id = 5116,
        duration = 4,
        max_stack = 1,
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    counterattack = {
        id = 19306,
        duration = 5,
        max_stack = 1,
        copy = { 19306, 20909, 20910, 27067 },
        -- Aura effects: MOD_ROOT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    deterrence = {
        id = 19263,
        duration = 10,
        max_stack = 1,
        -- Aura effects: MOD_DODGE_PERCENT, MOD_PARRY_PERCENT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    eagle_eye = {
        id = 6197,
        duration = 60,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    expose_weakness = {
        id = 34500,
        duration = 7,
        max_stack = 1,
        copy = { 34500, 34501, 34502, 34503 },
        -- Aura effects: MELEE_ATTACK_POWER_ATTACKER_BONUS, PROC_TRIGGER_SPELL, RANGED_ATTACK_POWER_ATTACKER_BONUS
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    eyes_of_the_beast = {
        id = 1002,
        duration = 60,
        max_stack = 1,
        -- Aura effects: DUMMY, MOD_POSSESS_PET
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_PET
    },

    feign_death = {
        id = 5384,
        duration = 360,
        max_stack = 1,
        -- Aura effects: FEIGN_DEATH
        -- Aura targets: TARGET_UNIT_CASTER
    },

    hunters_mark = {
        id = 1130,
        duration = 120,
        max_stack = 1,
        copy = { 1130, 14323, 14324, 14325 },
        -- Aura effects: MELEE_ATTACK_POWER_ATTACKER_BONUS, MOD_STALKED, RANGED_ATTACK_POWER_ATTACKER_BONUS
        -- Aura targets: TARGET_UNIT_TARGET_ANY, TARGET_UNIT_TARGET_ENEMY
    },

    immolation_trap_effect = {
        id = 13797,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 13797, 14298, 14299, 14300, 14301, 27024 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    intimidation = {
        id = 19577,
        duration = 15,
        max_stack = 1,
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_PET
    },

    master_tactician = {
        id = 34506,
        duration = 8,
        max_stack = 1,
        copy = { 34506, 34507, 34508, 34833, 34834, 34835, 34836, 34837, 34838, 34839 },
        -- Aura effects: MOD_WEAPON_CRIT_PERCENT, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    mend_pet = {
        id = 136,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 136, 3111, 3661, 3662, 13542, 13543, 13544, 27046 },
        -- Aura effects: PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_PET
    },

    misdirection = {
        id = 34477,
        duration = 30,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    natural_armor = {
        id = 24545,
        max_stack = 1,
        copy = { 24545, 24547, 24549, 24550, 24551, 24552, 24553, 24554, 24555, 24556, 24557, 24558, 24559, 24560, 24561, 24562, 24631, 24632, 27362 },
        -- Aura effects: MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    rapid_fire = {
        id = 3045,
        duration = 15,
        max_stack = 1,
        -- Aura effects: MOD_RANGED_HASTE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    rapid_killing = {
        id = 34948,
        duration = 20,
        max_stack = 1,
        copy = { 34948, 34949, 35098, 35099 },
        -- Aura effects: ADD_FLAT_MODIFIER, ADD_PCT_MODIFIER, PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    revive_pet = {
        id = 982,
        duration = 3,
        max_stack = 1,
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_CASTER
    },

    scare_beast = {
        id = 1513,
        duration = 20,
        max_stack = 1,
        copy = { 1513, 14326, 14327 },
        -- Aura effects: MOD_FEAR, MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    scatter_shot = {
        id = 19503,
        duration = 4,
        max_stack = 1,
        -- Aura effects: MOD_CONFUSE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    scorpid_sting = {
        id = 3043,
        duration = 20,
        max_stack = 1,
        -- Aura effects: MOD_HIT_CHANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    serpent_sting = {
        id = 1978,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        copy = { 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    silencing_shot = {
        id = 34490,
        duration = 3,
        max_stack = 1,
        -- Aura effects: MOD_SILENCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    tame_beast = {
        id = 1515,
        duration = 20,
        tick_time = 20,
        max_stack = 1,
        copy = { 1515, 13481 },
        -- Aura effects: DUMMY, MOD_RESISTANCE_PCT, PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER, TARGET_UNIT_TARGET_ENEMY
    },

    the_beast_within = {
        id = 34471,
        duration = 18,
        max_stack = 1,
        copy = { 34471, 34692 },
        -- Aura effects: DUMMY, MECHANIC_IMMUNITY, MOD_DAMAGE_PERCENT_DONE, MOD_POWER_COST_SCHOOL_PCT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_beasts = {
        id = 1494,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_demons = {
        id = 19878,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_dragonkin = {
        id = 19879,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_elementals = {
        id = 19880,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_giants = {
        id = 19882,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_hidden = {
        id = 19885,
        max_stack = 1,
        -- Aura effects: MOD_STEALTH_DETECT, TRACK_STEALTHED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_humanoids = {
        id = 19883,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_undead = {
        id = 19884,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    viper_sting = {
        id = 3034,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 3034, 14279, 14280, 27018 },
        -- Aura effects: PERIODIC_MANA_LEECH
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    volley = {
        id = 1510,
        duration = 6,
        tick_time = 1,
        max_stack = 1,
        copy = { 1510, 14294, 14295, 27022, 42234, 42243, 42244, 42245 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    wing_clip = {
        id = 2974,
        duration = 10,
        max_stack = 1,
        copy = { 2974, 14267, 14268 },
        -- Aura effects: MOD_DECREASE_SPEED
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    wyvern_sting = {
        id = 19386,
        duration = 12,
        tick_time = 2,
        max_stack = 1,
        copy = { 19386, 24131, 24132, 24133, 24134, 24135, 27068, 27069 },
        -- Aura effects: MOD_STUN, PERIODIC_DAMAGE
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

-- Aimed Shot - An aimed shot that increases ranged damage by 70/870 and reduces healing done to that target by 50%. Lasts 10 sec.
    aimed_shot = {
        id = 19434,
        cast = 2.5,
        duration = 10,
        category_cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 135130,
        cooldown_category_id = 2,
        cooldown_category = "Direct Damage - Spell",
        range = 35,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19434, 27065 },

        -- Effects:
        -- [ ] Rank 19434 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19434 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27065 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 869, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27065 #1 -- effect: APPLY_AURA, aura: MOD_HEALING_PCT, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "aimed_shot" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Arcane Resistance - Increases Arcane resistance by 30.
    arcane_resistance = {
        id = 24495,
        cast = 0,
        texture = 136096,
        range = 100,
        max_stack = 1,
        copy = { 24495, 24508, 24509, 24510, 27350 },

        -- Effects:
        -- [ ] Rank 24495 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24493
        -- [ ] Rank 24508 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24497
        -- [ ] Rank 24509 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24500
        -- [ ] Rank 24510 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24501
        -- [ ] Rank 27350 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27052

        proc_chance = 100,
    },

-- Arcane Shot - An instant shot that causes ${$rap*0.15+$m1} Arcane damage.
    arcane_shot = {
        id = 3044,
        cooldown = function () return max( 0, 6 + -0.2 * ( talent.improved_arcane_shot.rank or 0 ) ) end,
        category_cooldown = 6,
        gcd = "spell",
        school = "arcane",
        texture = 132218,
        cooldown_category_id = 1173,
        cooldown_category = "Arcane Shot",
        range = 35,
        spend = 25,
        -- Talent cooldown scaling (category source): improved_arcane_shot (-0.2s per rank)
        spendType = "Mana",
        max_stack = 1,
        copy = { 3044, 14281, 14282, 14283, 14284, 14285, 14286, 14287, 27019 },

        -- Effects:
        -- [x] Rank 3044 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14281 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 22, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14282 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 35, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14283 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14284 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 90, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14285 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14285 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 124, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14286 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14286 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 157, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14287 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14287 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27019 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27019 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 272, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "arcane_shot" ) end
        end,
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

-- Aspect of the Beast - The hunter takes on the aspects of a beast, becoming untrackable. Only one Aspect can be active at a time.
    aspect_of_the_beast = {
        id = 13161,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132252,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13161 #0 -- effect: APPLY_AURA, aura: UNTRACKABLE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_beast" )
        end,
    },

-- Aspect of the Cheetah - The hunter takes on the aspects of a cheetah, increasing movement speed by 30%. If the hunter is struck, $ghe:she; will be dazed for $15571d. Only one Aspect can be active at a time.
    aspect_of_the_cheetah = {
        id = 5118,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132242,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5118 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5118 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 15571

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_cheetah" )
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Aspect of the Hawk - The hunter takes on the aspects of a hawk, increasing ranged attack power by 20-155. Only one Aspect can be active at a time.
    aspect_of_the_hawk = {
        id = 13165,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136076,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 13165, 14318, 14319, 14320, 14321, 14322, 25296, 27044 },

        -- Effects:
        -- [x] Rank 13165 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 13165 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 14318 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14318 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 14319 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14319 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 14320 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14320 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 14321 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14321 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 14322 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 14322 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 25296 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 25296 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150
        -- [x] Rank 27044 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_ATTACK_POWER, points: 154, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 27044 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 6150

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_hawk" )
        end,

        proc_type_mask = { 87376, 0 },
        -- Proc type flags: mask0: Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Helpful Ability; Deal Harmful Ability; Deal Helpful Spell; Deal Harmful Spell
    },

-- Aspect of the Monkey - The hunter takes on the aspects of a monkey, increasing chance to dodge by 8%. Only one Aspect can be active at a time.
    aspect_of_the_monkey = {
        id = 13163,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132159,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 13163 #0 -- effect: APPLY_AURA, aura: MOD_DODGE_PERCENT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_monkey" )
        end,
    },

-- Aspect of the Pack - The hunter and group members within $a1 yards take on the aspects of a pack of cheetahs, increasing movement speed by 30%. If a pack member is struck, they will be dazed for $15571d. Only one Aspect can be active at a time.
    aspect_of_the_pack = {
        id = 13159,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132267,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 13159 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_INCREASE_SPEED, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 13159 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 15571

        radius = 30,

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_pack" )
        end,

        proc_chance = 100,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell
    },

-- Aspect of the Viper - The hunter takes on the aspects of a viper, regenerating mana equal to up to 55% of $ghis:her; Intellect plus 35% of $ghis:her; level every 5 sec. The lower the hunter's current mana, the more mana will be regenerated. Only one Aspect can be active at a time.
    aspect_of_the_viper = {
        id = 34074,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 132160,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 34074 #0 -- effect: APPLY_AURA, aura: PERIODIC_DUMMY, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34074 #1 -- effect: DUMMY, aura: NONE, points: 34, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_viper" )
        end,

        proc_chance = 100,
    },

-- Aspect of the Wild - The hunter and group members within $a1 yards take on the aspect of the wild, increasing Nature resistance by 45/60/70. Only one Aspect can be active at a time.
    aspect_of_the_wild = {
        id = 20043,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136074,
        spend = 90,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20043, 20190, 27045 },

        -- Effects:
        -- [ ] Rank 20043 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 20190 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 27045 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RESISTANCE_EXCLUSIVE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 30,

        handler = function ()
            clear_hunter_aspects()
            applyBuff( "aspect_of_the_wild" )
        end,

        proc_chance = 100,
    },

-- Auto Shot - Automatically shoots the target until cancelled.
    auto_shot = {
        id = 75,
        cast = 0,
        texture = 132369,
        range = 35,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 75 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Avoidance - Reduces the damage your pet takes from area of effect attacks by an additional 25%.
    avoidance = {
        id = 35699,
        cast = 0,
        texture = 135994,
        range = 100,
        max_stack = 1,
        copy = { 35699, 35700 },

        -- Effects:
        -- [ ] Rank 35699 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35694
        -- [ ] Rank 35700 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35698

        proc_chance = 100,
    },

-- Beast Lore - Gather information about the target beast. The tooltip will display damage, health, armor, any special resistances, and diet. In addition, Beast Lore will reveal whether or not the creature is tameable and what abilities the tamed creature has.
    beast_lore = {
        id = 1462,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "nature",
        texture = 132270,
        range = 40,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1462 #0 -- effect: APPLY_AURA, aura: EMPATHY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0

        handler = function ()
        end,
    },

-- Beast Training - Lets the Hunter train his pet with various abilities that he has learned.
    beast_training = {
        id = 5149,
        cast = 0,
        texture = 132162,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 5149 #0 -- effect: TRADE_SKILL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
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

-- Bestial Wrath - Send your pet into a rage causing 50% additional damage for 18 sec. While enraged, the beast does not feel pity or remorse or fear and it cannot be stopped unless killed.
    bestial_wrath = {
        id = 19574,
        cast = 0,
        duration = 18,
        cooldown = 120,
        school = "physical",
        texture = 132127,
        range = 100,
        spend_pct = 10,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19574 #0 -- effect: APPLY_AURA, aura: MOD_SCALE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 19574 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 19574 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0

        handler = function ()
            if not buff.bestial_wrath or not buff.bestial_wrath.up then
                applyBuff( "bestial_wrath" )
            end
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Bite
    bite = {
        id = 17254,
        cast = 0,
        texture = 132278,
        range = 100,
        max_stack = 1,
        copy = { 17254, 17262, 17263, 17264, 17265, 17266, 17267, 17268, 27348 },

        -- Effects:
        -- [ ] Rank 17254 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17253
        -- [ ] Rank 17262 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17255
        -- [ ] Rank 17263 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17256
        -- [ ] Rank 17264 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17257
        -- [ ] Rank 17265 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17258
        -- [ ] Rank 17266 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17259
        -- [ ] Rank 17267 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17260
        -- [ ] Rank 17268 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 17261
        -- [ ] Rank 27348 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27050

        proc_chance = 100,
    },

-- Black Arrow - Fires a Black Arrow into the target, slowing the target's movement speed by 70%, causing 150 Shadow damage and draining 150 mana over 30 sec.
    black_arrow = {
        id = 3674,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "shadow",
        texture = 132323,
        range = 35,
        max_stack = 1,
        copy = { 3674, 14296 },

        -- Effects:
        -- [x] Rank 3674 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -71, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 3674 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 3674 #2 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14296 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -71, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14296 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14296 #2 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "black_arrow" )
        end,
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

-- Call Pet - Summons your pet to you.
    call_pet = {
        id = 883,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132161,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 883 #0 -- effect: SUMMON_PET, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_DEST_CASTER_SUMMON, target2: NONE, mechanic: 0

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "made_up_pet" ) end
        end,
    },

-- Charge
    charge = {
        id = 7370,
        cast = 0,
        texture = 132184,
        range = 100,
        max_stack = 1,
        copy = { 7370, 26184, 26185, 26186, 26202, 28343 },

        -- Effects:
        -- [ ] Rank 7370 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 7371
        -- [ ] Rank 26184 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26177
        -- [ ] Rank 26185 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26178
        -- [ ] Rank 26186 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26179
        -- [ ] Rank 26202 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26201
        -- [ ] Rank 28343 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27685
    },

-- Claw
    claw = {
        id = 2975,
        cast = 0,
        texture = 132140,
        range = 100,
        max_stack = 1,
        copy = { 2975, 2976, 2977, 2980, 2981, 2982, 3666, 3667, 27347 },

        -- Effects:
        -- [ ] Rank 2975 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16831
        -- [ ] Rank 2976 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16832
        -- [ ] Rank 2977 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 3010
        -- [ ] Rank 2980 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16827
        -- [ ] Rank 2981 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16828
        -- [ ] Rank 2982 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16829
        -- [ ] Rank 3666 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 3009
        -- [ ] Rank 3667 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16830
        -- [ ] Rank 27347 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27049

        proc_chance = 100,
    },

-- Cobra Reflexes - Attack speed increased by 30%, but damage done is reduced.
    cobra_reflexes = {
        id = 25077,
        cast = 0,
        texture = 136040,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 25077 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25076
    },

-- Concussive Barrage - Your successful Auto Shot attacks have a $h% chance to Daze the target for $35101d.
    concussive_barrage = {
        id = 35100,
        cast = 0,
        duration = 4,
        texture = 135753,
        max_stack = 1,
        copy = { 35100, 35101, 35102, 35103 },

        -- Effects:
        -- [x] Rank 35100 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35101
        -- [x] Rank 35101 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 35102 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35101
        -- [x] Rank 35103 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35101
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "concussive_barrage" )
            applyBuff( "concussive_barrage" )
        end,

        proc_chance = 2,
        proc_type_mask = { 320, 0 },
        -- Proc type flags: mask0: Deal Ranged Attack; Deal Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Concussive Shot - Dazes the target, slowing movement speed by 50% for 4 sec.
    concussive_shot = {
        id = 5116,
        duration = 4,
        cooldown = 12,
        gcd = "spell",
        school = "arcane",
        texture = 135860,
        range = 35,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5116 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "concussive_shot" )
        end,
    },

-- Counterattack - A strike that becomes active after parrying an opponent's attack. This attack deals 40/70/110/165 damage and immobilizes the target for 5 sec. Counterattack cannot be blocked, dodged, or parried.
    counterattack = {
        id = 19306,
        cast = 0,
        duration = 5,
        category_cooldown = 5,
        gcd = "spell",
        school = "physical",
        texture = 132336,
        cooldown_category_id = 1135,
        cooldown_category = "Counterattack",
        range = 5,
        spend = 45,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19306, 20909, 20910, 27067 },

        -- Effects:
        -- [x] Rank 19306 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19306 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 20909 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20909 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 20910 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 20910 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        -- [x] Rank 27067 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 164, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27067 #1 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: rooted
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "counterattack" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "counterattack" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=7

        -- Related talents:
        -- talent_0 [0]
    },

-- Cower
    cower = {
        id = 1747,
        cast = 0,
        texture = 132118,
        range = 100,
        max_stack = 1,
        copy = { 1747, 1748, 1749, 1750, 1751, 16698, 27346 },

        -- Effects:
        -- [ ] Rank 1747 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 1742
        -- [ ] Rank 1748 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 1753
        -- [ ] Rank 1749 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 1754
        -- [ ] Rank 1750 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 1755
        -- [ ] Rank 1751 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 1756
        -- [ ] Rank 16698 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 16697
        -- [ ] Rank 27346 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27048

        proc_chance = 100,
    },

-- Dash
    dash = {
        id = 23100,
        cast = 0,
        texture = 132120,
        range = 100,
        max_stack = 1,
        copy = { 23100, 23111, 23112 },

        -- Effects:
        -- [ ] Rank 23100 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23099
        -- [ ] Rank 23111 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23109
        -- [ ] Rank 23112 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23110
    },

-- Deterrence - When activated, increases your Dodge and Parry chance by 25% for 10 sec.
    deterrence = {
        id = 19263,
        cast = 0,
        duration = 10,
        cooldown = 300,
        school = "physical",
        texture = 132369,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19263 #0 -- effect: APPLY_AURA, aura: MOD_PARRY_PERCENT, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 19263 #1 -- effect: APPLY_AURA, aura: MOD_DODGE_PERCENT, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "deterrence" )
        end,

        -- Related talents:
        -- talent_0 [0]
    },

-- Disengage - Attempts to disengage from the target, reducing threat. Character exits combat mode.
    disengage = {
        id = 781,
        cast = 0,
        category_cooldown = 5,
        gcd = "spell",
        school = "physical",
        texture = 132294,
        cooldown_category_id = 82,
        cooldown_category = "Taunt/Detaunt",
        range = 5,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 781, 14272, 14273, 27015 },

        -- Effects:
        -- [ ] Rank 781 #0 -- effect: THREAT, aura: NONE, points: -141, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14272 #0 -- effect: THREAT, aura: NONE, points: -281, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14273 #0 -- effect: THREAT, aura: NONE, points: -406, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27015 #0 -- effect: THREAT, aura: NONE, points: -546, addl_points: 1, points_per_level: -3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Dismiss Pet - Dismiss your pet. Dismissing your pet will reduce its happiness by $/1000;s1.
    dismiss_pet = {
        id = 2641,
        cast = 5,
        gcd = "spell",
        school = "physical",
        texture = 136095,
        range = 10,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2641 #0 -- effect: POWER_DRAIN, aura: NONE, points: 49999, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 2641 #1 -- effect: DISMISS_PET, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 2641 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0, trigger_spell_id: 47531
    },

-- Distracting Shot - Distract the target, causing threat. More effective than Distracting Shot (Rank 1).
    distracting_shot = {
        id = 14274,
        category_cooldown = 8,
        gcd = "spell",
        school = "arcane",
        texture = 135736,
        cooldown_category_id = 911,
        cooldown_category = "Distracting Shot",
        range = 35,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 14274, 15629, 15630, 15631, 15632, 20736, 27020 },

        -- Effects:
        -- [ ] Rank 14274 #0 -- effect: THREAT, aura: NONE, points: 159, addl_points: 1, points_per_level: 2, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 15629 #0 -- effect: THREAT, aura: NONE, points: 249, addl_points: 1, points_per_level: 2.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 15630 #0 -- effect: THREAT, aura: NONE, points: 349, addl_points: 1, points_per_level: 3, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 15631 #0 -- effect: THREAT, aura: NONE, points: 464, addl_points: 1, points_per_level: 3.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 15632 #0 -- effect: THREAT, aura: NONE, points: 599, addl_points: 1, points_per_level: 4, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 20736 #0 -- effect: THREAT, aura: NONE, points: 109, addl_points: 1, points_per_level: 1.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27020 #0 -- effect: THREAT, aura: NONE, points: 899, addl_points: 1, points_per_level: 4.5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Dive
    dive = {
        id = 23146,
        cast = 0,
        texture = 136126,
        range = 100,
        max_stack = 1,
        copy = { 23146, 23149, 23150 },

        -- Effects:
        -- [ ] Rank 23146 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23145
        -- [ ] Rank 23149 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23147
        -- [ ] Rank 23150 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23148
    },

-- Eagle Eye - Zooms in the hunter's vision. Only usable outdoors. Lasts 60 sec.
    eagle_eye = {
        id = 6197,
        cast = 0,
        duration = 60,
        gcd = "spell",
        school = "arcane",
        texture = 132172,
        range = 50000,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 6197 #0 -- effect: ADD_FARSIGHT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 6197 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "eagle_eye" )
        end,
    },

-- Explosive Trap - Place a fire trap that explodes when an enemy approaches, causing ${$RAP*0.1+$13812m1} to ${$RAP*0.1+$13812M1} Fire damage and burning all enemies for $13812o2 additional Fire damage over $13812d to all within $13812a1 yards. Trap will exist for 60 sec. Only one trap can be active at a time.
    explosive_trap = {
        id = 13813,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "fire",
        texture = 135826,
        cooldown_category_id = 411,
        cooldown_category = "Trap",
        spend = 275,
        spendType = "Mana",
        max_stack = 1,
        copy = { 13813, 14316, 14317, 27025 },

        -- Effects:
        -- [ ] Rank 13813 #0 -- effect: 320, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14316 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14317 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 27025 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,

        proc_chance = 100,
    },

-- Explosive Trap Effect - 15/24/33 Fire damage every $t2 seconds.
    explosive_trap_effect = {
        id = 13812,
        cast = 0,
        duration = 20,
        school = "fire",
        texture = 135826,
        max_stack = 1,
        copy = { 13812, 14314, 14315 },

        -- Effects:
        -- [x] Rank 13812 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 99, addl_points: 31, points_per_level: 0.8, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 13812 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14314 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 49, points_per_level: 1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 14314 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14315 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 200, addl_points: 57, points_per_level: 1.2, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 14315 #1 -- effect: PERSISTENT_AREA_AURA, aura: PERIODIC_DAMAGE, points: 32, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "explosive_trap_effect" ) end
        end,
    },

-- Expose Weakness - Your ranged criticals have a $h% chance to apply an Expose Weakness effect to the target. Expose Weakness increases the attack power of all attackers against that target by 25% of your Agility for $34501d.
    expose_weakness = {
        id = 34500,
        cast = 0,
        duration = 7,
        school = "arcane",
        texture = 132295,
        range = 50000,
        max_stack = 1,
        copy = { 34500, 34501, 34502, 34503 },

        -- Effects:
        -- [x] Rank 34500 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34501
        -- [x] Rank 34501 #0 -- effect: APPLY_AURA, aura: RANGED_ATTACK_POWER_ATTACKER_BONUS, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34501 #1 -- effect: APPLY_AURA, aura: MELEE_ATTACK_POWER_ATTACKER_BONUS, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34502 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34501
        -- [x] Rank 34503 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34501
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "expose_weakness" )
            applyBuff( "expose_weakness" )
        end,

        proc_chance = 33,
        proc_type_mask = { 320, 0 },
        -- Proc type flags: mask0: Deal Ranged Attack; Deal Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Eyes of the Beast - Take direct control of your pet and see through its eyes for 60 sec.
    eyes_of_the_beast = {
        id = 1002,
        cast = 2,
        duration = 60,
        gcd = "spell",
        school = "nature",
        texture = 132150,
        range = 50000,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1002 #0 -- effect: APPLY_AURA, aura: MOD_POSSESS_PET, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 12, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [x] Rank 1002 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 100,

        handler = function ()
            applyBuff( "eyes_of_the_beast" )
        end,
    },

-- Feed Pet - Feed your pet the selected item. Feeding your pet increases happiness. Using food close to the pet's level will have a better result.
    feed_pet = {
        id = 6991,
        cast = 0,
        texture = 132165,
        range = 10,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 6991 #0 -- effect: FEED_PET, aura: NONE, points: 34999, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0, trigger_spell_id: 1539
    },

-- Feign Death - Feign death which may trick enemies into ignoring you. Lasts up to 360 sec.
    feign_death = {
        id = 5384,
        cast = 0,
        duration = 360,
        cooldown = 30,
        school = "physical",
        texture = 132293,
        spend = 80,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5384 #0 -- effect: APPLY_AURA, aura: FEIGN_DEATH, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "feign_death" )
        end,
    },

-- Fire Breath
    fire_breath = {
        id = 34890,
        cast = 0,
        texture = 135789,
        range = 100,
        max_stack = 1,
        copy = { 34890, 35324 },

        -- Effects:
        -- [ ] Rank 34890 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 34889
        -- [ ] Rank 35324 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35323

        proc_chance = 100,
    },

-- Fire Resistance - Increases Fire resistance by 30.
    fire_resistance = {
        id = 24440,
        cast = 0,
        texture = 135806,
        range = 100,
        max_stack = 1,
        copy = { 24440, 24441, 24463, 24464, 27351 },

        -- Effects:
        -- [ ] Rank 24440 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 23992
        -- [ ] Rank 24441 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24439
        -- [ ] Rank 24463 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24444
        -- [ ] Rank 24464 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24445
        -- [ ] Rank 27351 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27053

        proc_chance = 100,
    },

-- Flare - Exposes all hidden and invisible enemies within $a1 yards of the targeted area for 20 sec.
    flare = {
        id = 1543,
        cast = 0,
        duration = 20,
        cooldown = 20,
        gcd = "spell",
        school = "arcane",
        texture = 135815,
        range = 30,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 1543 #0 -- effect: PERSISTENT_AREA_AURA, aura: DISPEL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1543 #1 -- effect: PERSISTENT_AREA_AURA, aura: DISPEL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 10,
    },

-- Freezing Trap - Place a frost trap that freezes the first enemy that approaches, preventing all action for up to $3355d. Any damage caused will break the ice. Trap will exist for 60 sec. Only one trap can be active at a time.
    freezing_trap = {
        id = 1499,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "frost",
        texture = 135834,
        cooldown_category_id = 411,
        cooldown_category = "Trap",
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1499, 14310, 14311 },

        -- Effects:
        -- [ ] Rank 1499 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14310 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14311 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,
    },

-- Frost Resistance - Increases Frost resistance by 30.
    frost_resistance = {
        id = 24475,
        cast = 0,
        texture = 135850,
        range = 100,
        max_stack = 1,
        copy = { 24475, 24476, 24477, 24478, 27352 },

        -- Effects:
        -- [ ] Rank 24475 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24446
        -- [ ] Rank 24476 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24447
        -- [ ] Rank 24477 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24448
        -- [ ] Rank 24478 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24449
        -- [ ] Rank 27352 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27054

        proc_chance = 100,
    },

-- Frost Trap - Place a frost trap that creates an ice slick around itself for $13810d when the first enemy approaches it. All enemies within $13810a1 yards will be slowed by 60% while in the area of effect. Trap will exist for 60 sec. Only one trap can be active at a time.
    frost_trap = {
        id = 13809,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "frost",
        texture = 135840,
        cooldown_category_id = 411,
        cooldown_category = "Trap",
        spend = 60,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 13809 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,
    },

-- Furious Howl - Party members within $24597a1 yards receive an extra 45 damage to their next Physical attack. Lasts $24597d.
    furious_howl = {
        id = 24599,
        cast = 0,
        texture = 132203,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 24599 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24597
    },

-- Gore
    gore = {
        id = 35299,
        cast = 0,
        texture = 135664,
        range = 100,
        max_stack = 1,
        copy = { 35299, 35300, 35302, 35303, 35304, 35305, 35306, 35307, 35308 },

        -- Effects:
        -- [ ] Rank 35299 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35290
        -- [ ] Rank 35300 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35291
        -- [ ] Rank 35302 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35292
        -- [ ] Rank 35303 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35293
        -- [ ] Rank 35304 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35294
        -- [ ] Rank 35305 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35295
        -- [ ] Rank 35306 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35296
        -- [ ] Rank 35307 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35297
        -- [ ] Rank 35308 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35298

        proc_chance = 100,
    },

-- Great Stamina - Stamina increased by 3.
    great_stamina = {
        id = 4195,
        cast = 0,
        texture = 136112,
        range = 100,
        max_stack = 1,
        copy = { 4195, 4196, 4197, 4198, 4199, 4200, 4201, 4202, 5048, 5049, 27364 },

        -- Effects:
        -- [ ] Rank 4195 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4187
        -- [ ] Rank 4196 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4188
        -- [ ] Rank 4197 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4189
        -- [ ] Rank 4198 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4190
        -- [ ] Rank 4199 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4191
        -- [ ] Rank 4200 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4192
        -- [ ] Rank 4201 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4193
        -- [ ] Rank 4202 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 4194
        -- [ ] Rank 5048 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 5041
        -- [ ] Rank 5049 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 5042
        -- [ ] Rank 27364 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27062

        proc_chance = 100,
    },

-- Growl - Taunt the target, increasing the likelihood the creature will focus attacks on you.
    growl = {
        id = 1853,
        cast = 0,
        texture = 132270,
        range = 100,
        max_stack = 1,
        copy = { 1853, 14922, 14923, 14924, 14925, 14926, 14927, 27344 },

        -- Effects:
        -- [ ] Rank 1853 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 2649
        -- [ ] Rank 14922 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14916
        -- [ ] Rank 14923 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14917
        -- [ ] Rank 14924 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14918
        -- [ ] Rank 14925 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14919
        -- [ ] Rank 14926 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14920
        -- [ ] Rank 14927 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 14921
        -- [ ] Rank 27344 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27047
    },

-- Hunter's Mark - Places the Hunter's Mark on the target, increasing the ranged attack power of all attackers against that target by 20/45/75/110 and by an additional ${$m2/10} each time they are struck by a ranged attack, up to a maximum of ${$m2*4}. In addition, the target of this ability can always be seen by the hunter whether it stealths or turns invisible. The target also appears on the mini-map. Lasts for 120 sec.
    hunters_mark = {
        id = 1130,
        cast = 0,
        duration = 120,
        gcd = "spell",
        school = "arcane",
        texture = 132212,
        range = 100,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1130, 14323, 14324, 14325 },

        -- Effects:
        -- [ ] Rank 1130 #0 -- effect: APPLY_AURA, aura: MOD_STALKED, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 1130 #1 -- effect: APPLY_AURA, aura: RANGED_ATTACK_POWER_ATTACKER_BONUS, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1130 #2 -- effect: APPLY_AURA, aura: MELEE_ATTACK_POWER_ATTACKER_BONUS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14323 #0 -- effect: APPLY_AURA, aura: MOD_STALKED, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 14323 #1 -- effect: APPLY_AURA, aura: RANGED_ATTACK_POWER_ATTACKER_BONUS, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14323 #2 -- effect: APPLY_AURA, aura: MELEE_ATTACK_POWER_ATTACKER_BONUS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14324 #0 -- effect: APPLY_AURA, aura: MOD_STALKED, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 14324 #1 -- effect: APPLY_AURA, aura: RANGED_ATTACK_POWER_ATTACKER_BONUS, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14324 #2 -- effect: APPLY_AURA, aura: MELEE_ATTACK_POWER_ATTACKER_BONUS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14325 #0 -- effect: APPLY_AURA, aura: MOD_STALKED, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 14325 #1 -- effect: APPLY_AURA, aura: RANGED_ATTACK_POWER_ATTACKER_BONUS, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14325 #2 -- effect: APPLY_AURA, aura: MELEE_ATTACK_POWER_ATTACKER_BONUS, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "hunters_mark" )
        end,

        proc_chance = 100,
        proc_type_mask = { 640, 0 },
        -- Proc type flags: mask0: Take Ranged Attack; Take Ranged Ability
    },

-- Immolation Trap - Place a fire trap that will burn the first enemy to approach for ${$RAP*0.1+$13797m1*5} Fire damage over $13797d. Trap will exist for 60 sec. Only one trap can be active at a time.
    immolation_trap = {
        id = 13795,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "fire",
        texture = 135813,
        cooldown_category_id = 411,
        cooldown_category = "Trap",
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 13795, 14302, 14303, 14304, 14305, 27023 },

        -- Effects:
        -- [ ] Rank 13795 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14302 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14303 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14304 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 14305 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [ ] Rank 27023 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,

        proc_chance = 100,
    },

-- Immolation Trap Effect - 21-197 Fire damage every $t1 seconds.
    immolation_trap_effect = {
        id = 13797,
        cast = 0,
        duration = 15,
        school = "fire",
        texture = 135813,
        range = 10,
        max_stack = 1,
        copy = { 13797, 14298, 14299, 14300, 14301, 27024 },

        -- Effects:
        -- [x] Rank 13797 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14298 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 42, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14299 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 67, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14300 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14301 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 137, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27024 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 196, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "immolation_trap_effect" )
        end,

        proc_chance = 100,
    },

-- Intimidation - Command your pet to intimidate the target on the next successful melee attack, causing a high amount of threat and stunning the target for $24394d.
    intimidation = {
        id = 19577,
        cast = 0,
        duration = 15,
        cooldown = 60,
        gcd = "spell",
        school = "nature",
        texture = 132111,
        cooldown_category_id = 1132,
        cooldown_category = "Intimidation",
        range = 100,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19577 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24394

        handler = function ()
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Kill Command - Give the command to kill, causing your pet to instantly attack for an additional 127 damage. Can only be used after the Hunter lands a critical strike on the target.
    kill_command = {
        id = 34026,
        cast = 0,
        category_cooldown = 5,
        school = "physical",
        texture = 132176,
        cooldown_category_id = 1171,
        cooldown_category = "Kill Command",
        range = 45,
        spend = 75,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 34026 #0 -- effect: DUMMY, aura: NONE, points: 34026, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 34026 #1 -- effect: SCRIPT_EFFECT, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        startsCombat = true,

        usable = function ()
            if class.auras.kill_command and buff.kill_command then
                return buff.kill_command.up
            end

            return true
        end,

        handler = function ()
            if class.auras.kill_command and buff.kill_command and buff.kill_command.up then
                removeBuff( "kill_command" )
            end
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=10
    },

-- Lightning Breath - Breathes lightning, instantly dealing 11 Nature damage to a single target.
    lightning_breath = {
        id = 24845,
        cast = 0,
        texture = 136048,
        range = 100,
        max_stack = 1,
        copy = { 24845, 25013, 25014, 25015, 25016, 25017 },

        -- Effects:
        -- [ ] Rank 24845 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24844
        -- [ ] Rank 25013 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25008
        -- [ ] Rank 25014 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25009
        -- [ ] Rank 25015 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25010
        -- [ ] Rank 25016 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25011
        -- [ ] Rank 25017 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 25012
    },

-- Master Tactician - Your successful ranged attacks have a $h% chance to increase your critical strike chance with all attacks by 2% for $34833d.
    master_tactician = {
        id = 34506,
        cast = 0,
        duration = 8,
        school = "arcane",
        texture = 132178,
        max_stack = 1,
        copy = { 34506, 34507, 34508, 34833, 34834, 34835, 34836, 34837, 34838, 34839 },

        -- Effects:
        -- [x] Rank 34506 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34833
        -- [x] Rank 34507 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34834
        -- [x] Rank 34508 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34835
        -- [x] Rank 34833 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34834 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34835 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34836 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34837 #0 -- effect: APPLY_AURA, aura: MOD_WEAPON_CRIT_PERCENT, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34838 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34836
        -- [x] Rank 34839 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 34837

        handler = function ()
            applyBuff( "master_tactician" )
        end,

        proc_chance = 6,
        proc_type_mask = { 320, 0 },
        -- Proc type flags: mask0: Deal Ranged Attack; Deal Ranged Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Mend Pet - Heals your pet for 125-2375 health over 15 sec.
    mend_pet = {
        id = 136,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "nature",
        texture = 132179,
        range = 45,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 136, 3111, 3661, 3662, 13542, 13543, 13544, 27046 },

        -- Effects:
        -- [ ] Rank 136 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 3111 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 3661 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 89, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 3662 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 139, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 13542 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 13543 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 279, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 13544 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 364, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0
        -- [ ] Rank 27046 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 474, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Misdirection - Threat caused by your next $n attacks is redirected to the target raid member. Caster and target can only be affected by one Misdirection spell at a time. Effect lasts 30 sec.
    misdirection = {
        id = 34477,
        cast = 0,
        duration = 30,
        cooldown = 120,
        gcd = "spell",
        school = "physical",
        texture = 132180,
        range = 100,
        spend_pct = 9,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 34477 #0 -- effect: REDIRECT_THREAT, aura: NONE, points: 100, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0
        -- [ ] Rank 34477 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_RAID, target2: NONE, mechanic: 0, trigger_spell_id: 35079
        -- [x] Rank 34477 #2 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "misdirection" )
        end,

        proc_chance = 100,
        proc_charges = 3,
        proc_type_mask = { 2167124, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability; Deal Ranged Attack; Deal Ranged Ability; Deal Harmful Ability; Deal Harmful Spell; Deal Helpful Periodic
    },

-- Mongoose Bite - Counterattack the enemy for ${$AP*0.2+$m1} damage. Can only be performed after you dodge.
    mongoose_bite = {
        id = 1495,
        cast = 0,
        category_cooldown = 5,
        gcd = "spell",
        school = "physical",
        texture = 132215,
        cooldown_category_id = 65,
        cooldown_category = "Melee (Special)",
        range = 5,
        spend = 30,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1495, 14269, 14270, 14271, 36916 },

        -- Effects:
        -- [x] Rank 1495 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14269 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14270 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14271 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 36916 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "mongoose_bite" ) end
        end,

        proc_chance = 100,

        -- Aura restrictions: caster_state=1
    },

-- Multi-Shot - Fires several missiles, hitting $x1 targets.
    multi_shot = {
        id = 2643,
        cast = 0,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132330,
        cooldown_category_id = 85,
        cooldown_category = "Direct Damage (AE-Chain) - Ability",
        range = 35,
        spend = 100,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2643, 14288, 14289, 14290, 25294, 27021 },

        -- Effects:
        -- [ ] Rank 2643 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14288 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14289 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14290 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 119, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 25294 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27021 #0 -- effect: NORMALIZED_WEAPON_DMG, aura: NONE, points: 204, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Natural Armor - Armor increased by 1-675.
    natural_armor = {
        id = 24545,
        cast = 0,
        texture = 136094,
        range = 100,
        max_stack = 1,
        copy = { 24545, 24547, 24549, 24550, 24551, 24552, 24553, 24554, 24555, 24556, 24557, 24558, 24559, 24560, 24561, 24562, 24631, 24632, 27362 },

        -- Effects:
        -- [x] Rank 24545 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 24547 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24545
        -- [x] Rank 24549 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24550 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24551 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 239, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24552 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 329, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24553 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 429, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24554 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 549, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24555 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 674, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 24556 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24549
        -- [ ] Rank 24557 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24550
        -- [ ] Rank 24558 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24551
        -- [ ] Rank 24559 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24552
        -- [ ] Rank 24560 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24553
        -- [ ] Rank 24561 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24554
        -- [ ] Rank 24562 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24555
        -- [ ] Rank 24631 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24629
        -- [ ] Rank 24632 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24630
        -- [ ] Rank 27362 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27061

        handler = function ()
            applyBuff( "natural_armor" )
        end,

        proc_chance = 100,
    },

-- Nature Resistance - Increases Nature resistance by 30.
    nature_resistance = {
        id = 24494,
        cast = 0,
        texture = 136085,
        range = 100,
        max_stack = 1,
        copy = { 24494, 24511, 24512, 24513, 27354 },

        -- Effects:
        -- [ ] Rank 24494 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24492
        -- [ ] Rank 24511 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24502
        -- [ ] Rank 24512 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24503
        -- [ ] Rank 24513 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24504
        -- [ ] Rank 27354 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27055

        proc_chance = 100,
    },

-- Poison Spit
    poison_spit = {
        id = 35388,
        cast = 0,
        texture = 136016,
        range = 100,
        max_stack = 1,
        copy = { 35388, 35390, 35391 },

        -- Effects:
        -- [ ] Rank 35388 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35387
        -- [ ] Rank 35390 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35389
        -- [ ] Rank 35391 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35392

        proc_chance = 100,
    },

-- Prowl - Puts your pet in stealth mode, but slows its movement to 50% of normal. The first attack from stealth receives a 20% bonus to damage. Lasts until cancelled.
    prowl = {
        id = 24451,
        cast = 0,
        texture = 132142,
        range = 100,
        max_stack = 1,
        copy = { 24451, 24454, 24455 },

        -- Effects:
        -- [ ] Rank 24451 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24450
        -- [ ] Rank 24454 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24452
        -- [ ] Rank 24455 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24453
    },

-- Rapid Fire - Increases ranged attack speed by 40% for 15 sec.
    rapid_fire = {
        id = 3045,
        cast = 0,
        duration = 15,
        category_cooldown = 300,
        school = "arcane",
        texture = 132208,
        cooldown_category_id = 55,
        cooldown_category = "Quick Buff (DPS) - Spell",
        spend = 100,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3045 #0 -- effect: APPLY_AURA, aura: MOD_RANGED_HASTE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            if not buff.rapid_fire or not buff.rapid_fire.up then
                applyBuff( "rapid_fire" )
            end
        end,
    },

-- Rapid Killing - Reduces the cooldown of your Rapid Fire ability by $/60000;s2 min. In addition, after killing an opponent that yields experience or honor, your next Aimed Shot, Arcane Shot or Auto Shot causes 10% additional damage. Lasts $35098d.
    rapid_killing = {
        id = 34948,
        cast = 0,
        duration = 20,
        texture = 132205,
        max_stack = 1,
        copy = { 34948, 34949, 35098, 35099 },

        -- Effects:
        -- [x] Rank 34948 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35098
        -- [x] Rank 34948 #1 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: -60001, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34949 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 35099
        -- [x] Rank 34949 #1 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: -120001, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 35098 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 35099 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "rapid_killing" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 2, 0 },
        -- Proc type flags: mask0: Kill

        -- Related talents:
        -- talent_0 [0]
    },

-- Raptor Strike - A strong attack that increases melee damage by 5-170.
    raptor_strike = {
        id = 2973,
        cast = 0,
        category_cooldown = 6,
        school = "physical",
        texture = 132223,
        cooldown_category_id = 40,
        cooldown_category = "Melee (Generic)",
        range = 5,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2973, 14260, 14261, 14262, 14263, 14264, 14265, 14266, 27014 },

        -- Effects:
        -- [ ] Rank 2973 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14260 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 10, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14261 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14262 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 33, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14263 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14264 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14265 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 109, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 14266 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 139, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27014 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 169, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        proc_chance = 100,
    },

-- Readiness - When activated, this ability immediately finishes the cooldown on your other Hunter abilities.
    readiness = {
        id = 23989,
        cast = 0,
        cooldown = 300,
        gcd = "spell",
        school = "physical",
        texture = 132206,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 23989 #0 -- effect: DUMMY, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        -- Related talents:
        -- talent_0 [0]
    },

-- Revive Pet - Revive your pet, returning it to life with 15% of its base health.
    revive_pet = {
        id = 982,
        cast = function () return max( 0, 10 + -3 * ( talent.improved_revive_pet.rank or 0 ) ) end,
        duration = 3,
        gcd = "spell",
        school = "nature",
        texture = 132163,
        spend_pct = 80,
        -- Talent cast scaling: improved_revive_pet (-3s per rank)
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 982 #0 -- effect: RESURRECT_PET, aura: NONE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 15, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0
        -- [x] Rank 982 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 3,

        handler = function ()
            applyBuff( "revive_pet" )
        end,
    },

-- Scare Beast - Scares a beast, causing it to run in fear for up to 10/15/20 sec. Damage caused may interrupt the effect. Only one beast can be feared at a time.
    scare_beast = {
        id = 1513,
        cast = 1.5,
        duration = 20,
        category_cooldown = 30,
        gcd = "spell",
        school = "nature",
        texture = 132118,
        cooldown_category_id = 33,
        cooldown_category = "Mez",
        range = 30,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1513, 14326, 14327 },

        -- Effects:
        -- [x] Rank 1513 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1513 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14326 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14326 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14327 #0 -- effect: APPLY_AURA, aura: MOD_FEAR, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14327 #1 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "scare_beast" )
        end,

        proc_chance = 100,
    },

-- Scatter Shot - A short-range shot that deals 50% weapon damage and disorients the target for 4 sec. Any damage caused will remove the effect. Turns off your attack when used.
    scatter_shot = {
        id = 19503,
        duration = 4,
        cooldown = 30,
        gcd = "spell",
        school = "physical",
        texture = 132153,
        range = 15,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19503 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 19503 #1 -- effect: APPLY_AURA, aura: MOD_CONFUSE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: disoriented
        -- [ ] Rank 19503 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 37506
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "scatter_shot" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Scorpid Poison - Inflicts $24583o2 Nature damage over $24583d. Effect can stack up to 5 times on a single target.
    scorpid_poison = {
        id = 24584,
        cast = 0,
        texture = 132274,
        range = 100,
        max_stack = 1,
        copy = { 24584, 24588, 24589, 24641, 27361 },

        -- Effects:
        -- [ ] Rank 24584 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24583
        -- [ ] Rank 24588 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24586
        -- [ ] Rank 24589 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24587
        -- [ ] Rank 24641 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24640
        -- [ ] Rank 27361 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27060

        proc_chance = 100,
    },

-- Scorpid Sting - Stings the target, reducing chance to hit with melee and ranged attacks by 5% for 20 sec. Only one Sting per Hunter can be active on any one target.
    scorpid_sting = {
        id = 3043,
        duration = 20,
        gcd = "spell",
        school = "nature",
        texture = 132169,
        range = 35,
        spend_pct = 9,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 3043 #0 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -6, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "scorpid_sting" )
        end,

        proc_chance = 100,
    },

-- Screech - Blasts a single enemy for 7 damage and lowers the attack power of all enemies in melee range by 25. Effect lasts $24423d.
    screech = {
        id = 24424,
        cast = 0,
        texture = 132182,
        range = 100,
        max_stack = 1,
        copy = { 24424, 24580, 24581, 24582, 27349 },

        -- Effects:
        -- [ ] Rank 24424 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24423
        -- [ ] Rank 24580 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24577
        -- [ ] Rank 24581 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24578
        -- [ ] Rank 24582 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24579
        -- [ ] Rank 27349 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27051

        proc_chance = 100,
    },

-- Serpent Sting - Stings the target, causing ${$RAP*0.1+$m1*5} Nature damage over 15 sec. Only one Sting per Hunter can be active on any one target.
    serpent_sting = {
        id = 1978,
        duration = 15,
        gcd = "spell",
        school = "nature",
        texture = 132204,
        range = 35,
        spend = 15,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016 },

        -- Effects:
        -- [x] Rank 1978 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13549 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13550 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 15, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13551 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 27, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13552 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13553 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 57, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13554 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 76, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 13555 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 97, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25295 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 110, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27016 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 131, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "serpent_sting" )
        end,

        proc_chance = 100,
    },

-- Shadow Resistance - Increases Shadow resistance by 30.
    shadow_resistance = {
        id = 24490,
        cast = 0,
        texture = 136121,
        range = 100,
        max_stack = 1,
        copy = { 24490, 24514, 24515, 24516, 27353 },

        -- Effects:
        -- [ ] Rank 24490 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24488
        -- [ ] Rank 24514 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24505
        -- [ ] Rank 24515 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24506
        -- [ ] Rank 24516 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 24507
        -- [ ] Rank 27353 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27056

        proc_chance = 100,
    },

-- Shell Shield
    shell_shield = {
        id = 26065,
        cast = 0,
        texture = 132199,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 26065 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26064
    },

-- Silencing Shot - A shot that deals 50% weapon damage and Silences the target for 3 sec.
    silencing_shot = {
        id = 34490,
        duration = 3,
        cooldown = 20,
        gcd = "spell",
        school = "physical",
        texture = 132323,
        range = 35,
        spend_pct = 6,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 34490 #0 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 34490 #1 -- effect: APPLY_AURA, aura: MOD_SILENCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: silenced
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "silencing_shot" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Snake Trap - Place a trap that will release several venomous snakes to attack the first enemy to approach. The snakes will die after $45145d. Trap will exist for 60 sec. Only one trap can be active at a time.
    snake_trap = {
        id = 34600,
        cast = 0,
        duration = 60,
        category_cooldown = 30,
        gcd = "spell",
        school = "fire",
        texture = 132211,
        cooldown_category_id = 411,
        cooldown_category = "Trap",
        spend = 305,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 34600 #0 -- effect: 320, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 7, target: TARGET_DEST_CASTER_FRONT, target2: NONE, mechanic: 0

        radius = 2,

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

-- Tame Beast - Begins taming a beast to be your companion. Your armor is reduced by 100% while you focus on taming the beast for 20 sec. If you lose the beast's attention for any reason, the taming process will fail. Once tamed, the beast will be very unhappy and disloyal. Try feeding the pet immediately to make it happy.
    tame_beast = {
        id = 1515,
        cast = 0,
        duration = 20,
        gcd = "spell",
        school = "nature",
        texture = 132164,
        range = 30,
        spend_pct = 48,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1515, 13481 },

        -- Effects:
        -- [x] Rank 1515 #0 -- effect: APPLY_AURA, aura: DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1515 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 13481
        -- [x] Rank 1515 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_PCT, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 13481 #0 -- effect: TAMECREATURE, aura: NONE, points: 9, addl_points: 1, points_per_level: 1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CHANNEL_TARGET, target2: NONE, mechanic: 0
        startsCombat = true,

        channeled = true,

        handler = function ()
            applyDebuff( "target", "tame_beast" )
            applyBuff( "tame_beast" )
        end,
    },

-- The Beast Within - When your pet is under the effects of Bestial Wrath, you also go into a rage causing 10% additional damage and reducing mana costs of all spells by 20% for $34471d. While enraged, you do not feel pity or remorse or fear and you cannot be stopped unless killed.
    the_beast_within = {
        id = 34471,
        cast = 0,
        duration = 18,
        texture = 132166,
        max_stack = 1,
        copy = { 34471, 34692 },

        -- Effects:
        -- [x] Rank 34471 #0 -- effect: APPLY_AURA, aura: MOD_POWER_COST_SCHOOL_PCT, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34471 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_DONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34471 #2 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34692 #0 -- effect: APPLY_AURA, aura: DUMMY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "the_beast_within" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
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

-- Thunderstomp
    thunderstomp = {
        id = 26094,
        cast = 0,
        texture = 132189,
        range = 100,
        max_stack = 1,
        copy = { 26094, 26189, 26190, 27366 },

        -- Effects:
        -- [ ] Rank 26094 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26090
        -- [ ] Rank 26189 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26187
        -- [ ] Rank 26190 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 26188
        -- [ ] Rank 27366 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 27063

        proc_chance = 100,
    },

-- Track Beasts - Shows the location of all nearby beasts on the minimap. Only one form of tracking can be active at a time.
    track_beasts = {
        id = 1494,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132328,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1494 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_beasts" )
        end,
    },

-- Track Demons - Shows the location of all nearby demons on the minimap. Only one form of tracking can be active at a time.
    track_demons = {
        id = 19878,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 136217,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19878 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_demons" )
        end,
    },

-- Track Dragonkin - Shows the location of all nearby dragonkin on the minimap. Only one form of tracking can be active at a time.
    track_dragonkin = {
        id = 19879,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 134153,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19879 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_dragonkin" )
        end,
    },

-- Track Elementals - Shows the location of all nearby elementals on the minimap. Only one form of tracking can be active at a time.
    track_elementals = {
        id = 19880,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 135861,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19880 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_elementals" )
        end,
    },

-- Track Giants - Shows the location of all nearby giants on the minimap. Only one form of tracking can be active at a time.
    track_giants = {
        id = 19882,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132275,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19882 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_giants" )
        end,
    },

-- Track Hidden - Greatly increases stealth detection and shows hidden units within detection range on the minimap. Only one form of tracking can be active at a time.
    track_hidden = {
        id = 19885,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132320,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19885 #0 -- effect: APPLY_AURA, aura: TRACK_STEALTHED, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 19885 #1 -- effect: APPLY_AURA, aura: MOD_STEALTH_DETECT, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_hidden" )
        end,
    },

-- Track Humanoids - Shows the location of all nearby humanoids on the minimap. Only one form of tracking can be active at a time.
    track_humanoids = {
        id = 19883,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 135942,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19883 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_humanoids" )
        end,
    },

-- Track Undead - Shows the location of all nearby undead on the minimap. Only one form of tracking can be active at a time.
    track_undead = {
        id = 19884,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 136142,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 19884 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_undead" )
        end,
    },

-- Tranquilizing Shot - Attempts to remove 1 Frenzy effect from an enemy creature.
    tranquilizing_shot = {
        id = 19801,
        cooldown = 20,
        gcd = "spell",
        school = "nature",
        texture = 136020,
        range = 35,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19801 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,
    },

-- Trueshot Aura - Increases the attack power of party members within $a1 yards by 50. Lasts $d.
    trueshot_aura = {
        id = 19506,
        cast = 0,
        gcd = "spell",
        school = "arcane",
        texture = 132329,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 19506 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RANGED_ATTACK_POWER, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 11, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 19506 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_ATTACK_POWER, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 11, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 45,

        -- Related talents:
        -- talent_0 [0]
    },

-- Viper Sting - Stings the target, draining 616/848/1108/1368 mana over 8 sec. Only one Sting per Hunter can be active on any one target.
    viper_sting = {
        id = 3034,
        duration = 8,
        category_cooldown = 15,
        gcd = "spell",
        school = "nature",
        texture = 132157,
        cooldown_category_id = 1175,
        cooldown_category = "Viper Sting",
        range = 35,
        spend = 135,
        spendType = "Mana",
        max_stack = 1,
        copy = { 3034, 14279, 14280, 27018 },

        -- Effects:
        -- [x] Rank 3034 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 153, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14279 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 211, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14280 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 276, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27018 #0 -- effect: APPLY_AURA, aura: PERIODIC_MANA_LEECH, points: 341, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "viper_sting" )
        end,

        proc_chance = 100,
    },

-- Volley - Continuously fires a volley of ammo at the target area, causing 50 Arcane damage to enemy targets within $a1 yards every second for 6 sec.
    volley = {
        id = 1510,
        cast = 0,
        duration = 6,
        category_cooldown = 60,
        gcd = "spell",
        school = "arcane",
        texture = 132222,
        cooldown_category_id = 49,
        cooldown_category = "Direct Damage (AE) - Ability",
        range = 100,
        spend = 350,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1510, 14294, 14295, 27022, 42234, 42243, 42244, 42245 },

        -- Effects:
        -- [ ] Rank 1510 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1510 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42243
        -- [ ] Rank 14294 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14294 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42244
        -- [ ] Rank 14295 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14295 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42245
        -- [ ] Rank 27022 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27022 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42234
        -- [x] Rank 42234 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42243 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42244 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42245 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.143, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        channeled = true,

        handler = function ()
            applyBuff( "volley" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "volley" ) end
        end,

        proc_chance = 100,
    },

-- Warp
    warp = {
        id = 35348,
        cast = 0,
        texture = 135731,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 35348 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_PET, target2: NONE, mechanic: 0, trigger_spell_id: 35346

        proc_chance = 100,
    },

-- Wing Clip - Inflicts 5/25/50 damage and reduces the enemy target's movement speed by 50/55/60% for 10 sec.
    wing_clip = {
        id = 2974,
        cast = 0,
        duration = 10,
        gcd = "spell",
        school = "physical",
        texture = 132309,
        range = 5,
        spend = 40,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2974, 14267, 14268 },

        -- Effects:
        -- [x] Rank 2974 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -51, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 2974 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14267 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -56, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 14267 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 14268 #0 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -61, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: ensnared
        -- [x] Rank 14268 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "wing_clip" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "wing_clip" ) end
        end,
    },

-- Wyvern Sting - A stinging shot that puts the target to sleep for 12 sec. Any damage will cancel the effect. When the target wakes up, the Sting causes $24131o1 Nature damage over $24131d. Only one Sting per Hunter can be active on the target at a time.
    wyvern_sting = {
        id = 19386,
        cast = 0,
        duration = 12,
        category_cooldown = 120,
        gcd = "spell",
        school = "nature",
        texture = 135125,
        cooldown_category_id = 1111,
        cooldown_category = "Wyvern Sting",
        range = 50000,
        spend = 115,
        spendType = "Mana",
        max_stack = 1,
        copy = { 19386, 24131, 24132, 24133, 24134, 24135, 27068, 27069 },

        -- Effects:
        -- [x] Rank 19386 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 24131 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 24132 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24133 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 24134 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [ ] Rank 24135 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ANY, target2: NONE, mechanic: 0
        -- [x] Rank 27068 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27069 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 156, addl_points: 1, points_per_level: 0, sp_bonus: 0.167, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "wyvern_sting" )
        end,

        proc_chance = 100,
        proc_type_mask = { 1048576, 0 },
        -- Proc type flags: mask0: Take Any Damage - DO NOT USE

        -- Related talents:
        -- talent_0 [0]
    },

} )

-- Resources
if spec.RegisterResource then
    spec:RegisterResource( "mana" )
end

spec:RegisterRanges( "counterattack", "mongoose_bite", "wing_clip", "immolation_trap_effect", "arcane_shot", "black_arrow" )

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

    package = "Beast\ Mastery\ \(wowtbc\.gg\)",
} )

spec:RegisterStateExpr( "wowsim_hunter_bm_swap_to_viper", function()
    if mana.pct <= 20 and buff.aspect_of_the_viper.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_bm_swap_to_hawk", function()
    if mana.pct >= 30 and buff.aspect_of_the_hawk.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_bm_auto_window", function()
    if cooldown.auto_shot.remains <= gcd.remains or mana.pct <= 20 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_bm_multishot_window", function()
    if cooldown.auto_shot.remains > gcd.remains then return 1 end
    return 0
end )

spec:RegisterStateExpr( "wowsim_hunter_sv_swap_to_viper", function()
    if mana.pct <= 30 and buff.aspect_of_the_viper.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_swap_to_hawk", function()
    if mana.pct >= 50 and buff.aspect_of_the_hawk.down then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_followup_window", function()
    if cooldown.auto_shot.remains > gcd.remains then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_weave_proxy_raptor", function()
    if active_enemies <= 1 and wowsim_hunter_sv_followup_window > 0 and target.time_to_die > 15 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_auto_window", function()
    if cooldown.auto_shot.remains <= gcd.remains or mana.pct <= 30 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_multishot_window", function()
    if wowsim_hunter_sv_followup_window > 0 then return 1 end
    return 0
end )
spec:RegisterStateExpr( "wowsim_hunter_sv_arcane_window", function()
    if wowsim_hunter_sv_followup_window > 0 then return 1 end
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

spec:RegisterPack( "Beast Mastery (wowtbc.gg)", 20230211, [[Hekili:fs1YUTnmqWpMCPfTr2YjTnPajhYHced0CrbO3O0kPvseMIuGKYQ(c)27sjeBkzB0l6b5SdN9Xqwm7Dwsjyr2BBwV5U1BIJJw)W3Em(owI9qhYs6GIDqn9HeAPNVGGX6Y(n9e1hCzFAqnyZlIQR)Sh7bHck9CAu96ccFJ12z(5QvhHrFzf7wviaJ526EEjAwL7j922joVTPxsVxXsY75c7Rsw(LLiDiDyb7nsQn8YsCciAkyjV3WnUSonxP5wsL()Ybdw6YusxMTbDzhvKl7pAW24YgvtelrWnwZyHbRGEHL(8TXcfuy5kjDUCbkl4Y6utJYYsqjKlWs2lmljspYtRKuqsa1CWtxEFvvubLNuSr9DNyKlT8woLL()S(C6QKOgKNIBQwzsBb9oFC3hktn0XltR4ACHe)wiQcqisvvPurjDGlkxG97HyZrs6GiDWxWwa8hHa3XjsluTTGCjHpeIRtn9EgIhdr0BWuk3BnlafV(SZ7cnJ44)x3ySxyIMxwnOUdL20Xnh556DvlORrB0a32WLKQosc(3oHYW3JPwQtmYYDHAULgT4xsZ3F1ZYhkXhkXwosZ0p7Y2CIW9kHapmsXSomOlajEXYZSUlz)GYdxah9BNgP2zoCUza8Uq7htqLAOwjBGHDlPGizpnQ6JXBK3eVEnP9bql9nawYRTDkT1Br34YMi3LnAfJCB9cqvr2owYn34YwCl0w)AXXUSFH56EWFVK)Qc3w32jImrh1)xEA11uCaEc1CtE4oHM1VYRE6mFDi4qh6iyAqlC)tM0WvxAkd3BMjmCJqtx46tMSWvoAQol8L56mNqqYgyBcHpFM3JFH9ie8rdq4ItdX(iNpS)8MqubJ0ZuB4em0BBuAAe7Jl6hhcz)l]] )

spec:RegisterPack( "Marksmanship", 20230226, [[Hekili:TA12UnUnq0)gJDrxO6ljoDbI9dfOaDdW6x0(mLOLgBrejsbsQ4AGa(T3HuXwu0sYPa9flBZzoCUCMZiYcYViX5unq2TC(YvZxUCD0INw89vprI1NRbsCnn7v6r8lCAf(5pPYxvvuUQGvBp8CPGMBbrjAKzObK49nSs9p4K9dJ8JOT1qgz3ksCblphATeuz9r3Kw0W1G0KwlzcjtF2KEqG)8VHxzLmsCjtPv2RMka8XoxUaC6(siN8NK4m0hqYOyMqLhbD0jMUGXX7NMPzcoA8)uxkuS3GeTKwt0yO6W7JJRAk1mvHq7dR2g4JDrwpr0aouXaLjD7gt6QoaFtuwcNTq8WOqKd7BoCisPz8JQOCXjEN)kqwdCDI7qlmp6hUzfSkqstUnI1wypqX0z660qH)YUlq2WtA)EIT232bsA5f2EWL6Nh2Fgxv62qu9jIobpIAzp6eXHeDbK8gRgKrAmZtumEgysF2KU2KoZK6QJdzDtT78mHO0wFJ8lCrsOIY42K3Ko3R0RbA(52A7a5Px)dr0bpsJPr41LHDmhAl9yE9dRCj9OGxqp9600R(SH2Xdvsfo0mnNYvjqgolp5atcbSQUdUsPghLmAz5LW(eRmpaRWJTiU2NKwl(y0ZFG6jFlAuqcELvQaJ(dFJkqTjjwdHCKwLbLy7BaC)UVlOOr5aZg7wm))NzXfl(CdJ7w0tKHI2LpOzJZd(Ih51RT2rDX52fpo3K((73Zst6hIJUriTijNHZqF9ZoG03UUCzSXijofX4Gs5YWh6viKzuomyLyCoPc0TnhvZXJakP0jPBvzgxOFX67JPDc(iKyF0QCmWC9ZBMAW25L766rX9ftcfQRLqMOApTtm8UAg9RwtlnnQ8H7YFd)d7HxxztIprLCB1Ge)JQAHud5M0hmPTOysDlHJmVydCXbwjC5curxZKFBZVpwSBEziR9dTVXoSXPPEXs88GTjFZUhzdUbYAB)DyB3S8UoQ0Mx6IdLna8AqxW8UBEEE9Sj24mBYHPTZdcGXQxxQgZ8zHBx(yG7twaBnPtnWAWqBicCiuA)QBdUsiW5wz)G)8QsFy0pS4EGvx1Zd7D(cZUK)gv8WmZRJe2hUQOfw(UiKzVHVmHg72nOs87VpLf3Qa)17rxMnHM7TKPoL1Gt6RlAtLjfuNKK6y69G4g9ZES2N3CdT1BSZFKeNShmw7)A9H2F9T3dpO9TWhsRyvOP)N4sTU0FXpTrxiKK4Fva)vLcVwk3P0s(3)]] )

spec:RegisterPack( "Survival (wowtbc.gg)", 20230211, [[Hekili:DwvqZTjpq0Fm5s70gSHy3M8ntYHEOtJp4lKz6nbcqy0ybIrAXuFr)27k4ZGGIRB7LaE3NES7B1(cXN8gjmJcmY(G1bpSoW33B9JBFAZwsiCUMrcRPPhPhWxQOL4FdBuN4NOct87ALTqsQ3HdV3I6SqsZSSPLnQuezba16)B1Qby4BG44QubvRV)qdpJPxP)F6UVOPcyQvKWKgUaETIKSCDTb)a1SuY(hWVaplJ1JKPtjHVvW1M4AfxQ4WztS9xjunlZelRmXqbZepunM4VROqHjURs8iHcUg0DYblN2ia819DYdRIMiyzKVqctrIzkofbjBRiH0uGlXN9vVoQKQosaSMTN7ssfTMNfLZvmxUaBl4GkLkerY8iSkJA5ISzy34I9ihXMkllPvZXT1fxTS)5eeFYfrJMfHTuPEgOpF9gNL0KN7X(rTqQ5Nyr6cj4nvoMM0Y3JxLpGQoWapzdOX5G)6rwse4vViQsjBTu80TOOLdf8kxggRdahcwsWSxJf7HqKSkwjNH3CEXehmsvjEJGFPB8V(9IFplNKcb7Chfb)YaTJ9PJb)jxrO8sw2IW2CRXLg4vh0ZgtAMQMvbrDj74z7FVgNRKAyuFNC7sdmA25fQy8N1kgEdoHoUNn0M2fC4YUqMIEqwvqBpoRPd(h3nF4MBiB(d7bmWjKzlmRlvG)614SULQQSInj81YAPcS2pbM4E(mXD2mEMDwfqMZfOPWD3zIh9v)wx9A2zJ67BI)klr1qvOFM1j0SZSRNkT3Ge(HNxDnrBz0UAYh55pBvSLr2lqlNZrACkRBrpMF0r0n6Chq3CUoE9sZyU8g0XVrhviBfUNzwPJrgC7Cdo1SQRCVQfN75CSNShAUp2YFc7EId6lRtUGhCAS4MAN8sGlWEZKBHAWAXn4OtIB0j(bocHJ5Hl8Xn)B0rtwHOnqHuHRjx(hXDlsKFo]] )


spec:RegisterPackSelector( "beast_mastery", "Beast Mastery (wowtbc.gg)", "|T132164:0|t Beast Mastery",
    "If you have spent more points in |T132164:0|t Beast Mastery than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "marksmanship", "Marksmanship", "|T132222:0|t Marksmanship",
    "If you have spent more points in |T132222:0|t Marksmanship than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "survival", "Survival (wowtbc.gg)", "|T132215:0|t Survival",
    "If you have spent more points in |T132215:0|t Survival than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )
	
-- Settings
spec:RegisterSetting( "suggest_explosive_st", false, {
    type = "toggle",
    name = "|T135826:0|t Suggest Explosive Trap on Single Target",
    desc = "When enabled, |T135826:0|t Explosive Trap will be suggested in single target scenarios as well as AoE.",
    width = "full",
} )

spec:RegisterSetting( "manage_mana_viper", false, {
    type = "toggle",
    name = "|T132160:0|t Swap to Aspect of the Viper for Mana",
    desc = "When enabled, the profile will suggest swapping to |T132160:0|t Aspect of the Viper at low mana.",
    width = "full",
} )

