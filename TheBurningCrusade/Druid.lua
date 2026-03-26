-- Druid.lua
-- Auto-generated class spell blocks
-- Build: 2.5.5.66150
-- Class: Druid (#11)

if UnitClassBase( "player" ) ~= "DRUID" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 11 )

spec:RegisterGear( "tier4",
    29086, 29087, 29088, 29089, 29090,
    29091, 29092, 29093, 29094, 29095,
    29096, 29097, 29098, 29099, 29100
)

spec:RegisterGear( "tier5",
    30216, 30217, 30219, 30220, 30221,
    30222, 30223, 30228, 30229, 30230,
    30231, 30232, 30233, 30234, 30235
)

spec:RegisterGear( "tier6",
    31032, 31034, 31035, 31037, 31039,
    31040, 31041, 31042, 31043, 31044,
    31045, 31046, 31047, 31048, 31049
)

spec:RegisterGear( "sunwell",
    34444, 34445, 34446,
    34554, 34555, 34556,
    34571, 34572, 34573
)

spec:RegisterGear( "wolfshead_helm", 8345 )

local function clear_druid_forms()
    state.removeBuff( "aquatic_form" )
    state.removeBuff( "bear_form" )
    state.removeBuff( "cat_form" )
    state.removeBuff( "dire_bear_form" )
    state.removeBuff( "flight_form" )
    state.removeBuff( "moonkin_form" )
    state.removeBuff( "swift_flight_form" )
    state.removeBuff( "travel_form" )
    state.removeBuff( "tree_of_life" )
end

local function spend_cat_combo_points()
    local points = state.combo_points and state.combo_points.current or 0

    if points <= 0 then return end

    if type( state.spend ) == "function" then
        state.spend( points, "combo_points" )
    elseif type( spend ) == "function" then
        spend( points, "combo_points" )
    elseif combo_points then
        combo_points.current = max( 0, combo_points.current - points )
    end
end

local function gain_bear_rage( amount )
    amount = amount or 1

    if amount <= 0 then return end

    if type( state.gain ) == "function" then
        state.gain( amount, "rage" )
    elseif type( gain ) == "function" then
        gain( amount, "rage" )
    elseif rage then
        rage.current = min( rage.max or rage.current, rage.current + amount )
    end
end

local function gain_cat_energy( amount )
    amount = amount or 0

    if amount <= 0 then return end

    if type( state.gain ) == "function" then
        state.gain( amount, "energy" )
    elseif type( gain ) == "function" then
        gain( amount, "energy" )
    elseif energy then
        energy.current = min( energy.max or energy.current, energy.current + amount )
    end
end

local TBC_RAGE_CONVERSION = 274.7
local TBC_RAGE_DEALT_FACTOR = 3.75 / TBC_RAGE_CONVERSION
local TBC_RAGE_TAKEN_FACTOR = 2.5 / TBC_RAGE_CONVERSION
local TBC_RAGE_MAINHAND_HIT_FACTOR = 3.5 / 2
local TBC_RAGE_OFFHAND_HIT_FACTOR = 1.75 / 2
local PASSIVE_RAGE_DAMAGE_WINDOW = 10

local MAUL_SPELL_IDS = {
    [6807] = true,
    [6808] = true,
    [6809] = true,
    [8972] = true,
    [9745] = true,
    [9880] = true,
    [9881] = true,
    [26996] = true,
}

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

local function is_bear_form_active()
    return UnitPowerType and UnitPowerType( "player" ) == 1
end

local function get_bear_swing_speed( is_offhand )
    local swings = state.swings
    local speed = swings and ( is_offhand and swings.offhand_speed or swings.mainhand_speed )

    if speed and speed > 0 then
        return speed
    end

    return is_offhand and 2.0 or 2.5
end

local function gain_bear_auto_attack_rage( damage, is_offhand, is_critical )
    if not damage or damage <= 0 then return end

    local hit_factor = is_offhand and TBC_RAGE_OFFHAND_HIT_FACTOR or TBC_RAGE_MAINHAND_HIT_FACTOR

    if is_critical then
        hit_factor = hit_factor * 2
    end

    local rage = ( damage * TBC_RAGE_DEALT_FACTOR ) + ( hit_factor * get_bear_swing_speed( is_offhand ) )
    gain_bear_rage( rage )
end

local function gain_bear_damage_taken_rage( damage )
    if not damage or damage <= 0 then return end
    gain_bear_rage( damage * TBC_RAGE_TAKEN_FACTOR )
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

local function get_bear_forecast_rage_per_swing( is_offhand )
    if not ( state.buff.bear_form.up or state.buff.dire_bear_form.up ) then return 0 end
    if not is_offhand and state.buff.maul_queue.up then return 0 end

    local speed = get_bear_swing_speed( is_offhand )
    local weapon_dps = is_offhand and state.weapon_offhand_dps or state.weapon_dps
    weapon_dps = weapon_dps or 0
    local estimated_damage = max( 0, weapon_dps * speed )
    local crit_chance = ( GetCritChance and GetCritChance() or 0 ) / 100

    local hit_factor = is_offhand and TBC_RAGE_OFFHAND_HIT_FACTOR or TBC_RAGE_MAINHAND_HIT_FACTOR
    local expected_hit_factor = hit_factor * ( 1 + crit_chance )

    return ( estimated_damage * TBC_RAGE_DEALT_FACTOR ) + ( expected_hit_factor * speed )
end

local function get_bear_passive_incoming_rage_per_second()
    if not ( state.buff.bear_form.up or state.buff.dire_bear_form.up ) then return 0 end
    return get_passive_incoming_damage_per_second() * TBC_RAGE_TAKEN_FACTOR
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
    balance_of_power = { 1783, 2, 33592, 33596 },
    brambles = { 782, 3, 16836, 16839, 16840 },
    brutal_impact = { 797, 2, 16940, 16941 },
    celestial_focus = { 784, 3, 16850, 16923, 16924 },
    control_of_nature = { 787, 3, 16918, 16919, 16920 },
    dreamstate = { 1784, 3, 33597, 33599, 33956 },
    empowered_rejuvenation = { 1789, 5, 33886, 33887, 33888, 33889, 33890 },
    empowered_touch = { 1788, 2, 33879, 33880 },
    faerie_fire_feral = { 1162, 1, 16857 },
    feral_aggression = { 795, 5, 16858, 16859, 16860, 16861, 16862 },
    feral_charge = { 804, 1, 16979 },
    feral_instinct = { 799, 3, 16947, 16948, 16949 },
    feral_swiftness = { 807, 2, 17002, 24866 },
    ferocity = { 796, 5, 16934, 16935, 16936, 16937, 16938 },
    focused_starlight = { 1822, 2, 35363, 35364 },
    force_of_nature = { 1787, 1, 33831 },
    furor = { 822, 5, 17056, 17058, 17059, 17060, 17061 },
    gift_of_nature = { 828, 5, 17104, 24943, 24944, 24945, 24946 },
    heart_of_the_wild = { 808, 5, 17003, 17004, 17005, 17006, 24894 },
    improved_faerie_fire = { 1785, 3, 33600, 33601, 33602 },
    improved_leader_of_the_pack = { 1798, 2, 34297, 34300 },
    improved_mark_of_the_wild = { 821, 5, 17050, 17051, 17053, 17054, 17055 },
    improved_moonfire = { 763, 2, 16821, 16822 },
    improved_natures_grasp = { 921, 4, 17245, 17247, 17248, 17249 },
    improved_regrowth = { 825, 5, 17074, 17075, 17076, 17077, 17078 },
    improved_rejuvenation = { 830, 3, 17111, 17112, 17113 },
    improved_tranquility = { 842, 2, 17123, 17124 },
    insect_swarm = { 788, 1, 5570 },
    intensity = { 829, 3, 17106, 17107, 17108 },
    leader_of_the_pack = { 809, 1, 17007 },
    living_spirit = { 1797, 3, 34151, 34152, 34153 },
    lunar_guidance = { 1782, 3, 33589, 33590, 33591 },
    mangle = { 1796, 1, 33917 },
    moonfury = { 790, 5, 16896, 16897, 16899, 16900, 16901 },
    moonglow = { 783, 3, 16845, 16846, 16847 },
    moonkin_form = { 793, 1, 24858 },
    natural_perfection = { 1790, 3, 33881, 33882, 33883 },
    natural_shapeshifter = { 826, 3, 16833, 16834, 16835 },
    naturalist = { 824, 5, 17069, 17070, 17071, 17072, 17073 },
    natures_focus = { 823, 5, 17063, 17065, 17066, 17067, 17068 },
    natures_grace = { 789, 1, 16880 },
    natures_grasp = { 761, 1, 16689 },
    natures_reach = { 764, 2, 16819, 16820 },
    natures_swiftness = { 831, 1, 17116 },
    nurturing_instinct = { 1792, 2, 33872, 33873 },
    omen_of_clarity = { 827, 1, 16864 },
    predatory_instincts = { 1795, 5, 33859, 33866, 33867, 33868, 33869 },
    predatory_strikes = { 803, 3, 16972, 16974, 16975 },
    primal_fury = { 801, 2, 37116, 37117 },
    primal_tenacity = { 1793, 3, 33851, 33852, 33957 },
    savage_fury = { 805, 2, 16998, 16999 },
    sharpened_claws = { 798, 3, 16942, 16943, 16944 },
    shredding_attacks = { 802, 2, 16966, 16968 },
    starlight_wrath = { 762, 5, 16814, 16815, 16816, 16817, 16818 },
    subtlety = { 841, 5, 17118, 17119, 17120, 17121, 17122 },
    survival_of_the_fittest = { 1794, 3, 33853, 33855, 33856 },
    swiftmend = { 844, 1, 18562 },
    thick_hide = { 794, 3, 16929, 16930, 16931 },
    tranquil_spirit = { 843, 5, 24968, 24969, 24970, 24971, 24972 },
    tree_of_life = { 1791, 1, 33891 },
    vengeance = { 792, 5, 16909, 16910, 16911, 16912, 16913 },
    wrath_of_cenarius = { 1786, 5, 33603, 33604, 33605, 33606, 33607 },
} )

-- Auras (Hekili-style scaffold)
spec:RegisterAuras( {

    abolish_poison = {
        id = 2893,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    aquatic_form = {
        id = 1066,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    barkskin = {
        id = 22812,
        duration = 12,
        max_stack = 1,
        -- Aura effects: MOD_DAMAGE_PERCENT_TAKEN, REDUCE_PUSHBACK
        -- Aura targets: TARGET_UNIT_CASTER
    },

    bash = {
        id = 5211,
        duration = 4,
        max_stack = 1,
        copy = { 5211, 6798, 8983 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    bear_form = {
        id = 5487,
        max_stack = 1,
        copy = { 5487, 9634 },
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    cat_form = {
        id = 768,
        tick_time = 5,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT, PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    wolfshead_helm = {
        id = 17768,
        max_stack = 1,
    },

    challenging_roar = {
        id = 5209,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_TAUNT
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    cyclone = {
        id = 33786,
        duration = 6,
        max_stack = 1,
        -- Aura effects: MOD_STUN, SCHOOL_IMMUNITY
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    dash = {
        id = 1850,
        duration = 15,
        max_stack = 1,
        copy = { 1850, 9821, 33357 },
        -- Aura effects: MOD_INCREASE_SPEED
        -- Aura targets: TARGET_UNIT_CASTER
    },

    demoralizing_roar = {
        id = 99,
        duration = 30,
        max_stack = 1,
        copy = { 99, 1735, 9490, 9747, 9898, 26998 },
        -- Aura effects: MOD_ATTACK_POWER
        -- Aura targets: TARGET_SRC_CASTER, TARGET_UNIT_SRC_AREA_ENEMY
    },

    dire_bear_form = {
        id = 9634,
        max_stack = 1,
        copy = { 5487, 9634 },
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    enrage = {
        id = 5229,
        duration = 10,
        tick_time = 1,
        max_stack = 1,
        -- Aura effects: INTERRUPT_REGEN, PERIODIC_ENERGIZE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    entangling_roots = {
        id = 339,
        duration = 27,
        tick_time = 3,
        max_stack = 1,
        copy = { 339, 1062, 5195, 5196, 9852, 9853, 26989 },
        -- Aura effects: MOD_ROOT, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    faerie_fire = {
        id = 770,
        duration = 40,
        max_stack = 1,
        copy = { 770, 778, 9749, 9907, 26993 },
        -- Aura effects: MOD_ATTACKER_MELEE_HIT_CHANCE, MOD_ATTACKER_RANGED_HIT_CHANCE, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    faerie_fire_feral = {
        id = 16857,
        duration = 40,
        max_stack = 1,
        copy = { 16857, 17390, 17391, 17392, 27011 },
        -- Aura effects: MOD_ATTACKER_MELEE_HIT_CHANCE, MOD_ATTACKER_RANGED_HIT_CHANCE, MOD_RESISTANCE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    flight_form = {
        id = 33943,
        max_stack = 1,
        copy = { 33943, 40120 },
        -- Aura effects: FLY, MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    force_of_nature = {
        id = 33831,
        duration = 30,
        tick_time = 0.2,
        max_stack = 1,
        -- Aura effects: PERIODIC_DUMMY
        -- Aura targets: TARGET_UNIT_DEST_AREA_ENEMY
    },

    frenzied_regeneration = {
        id = 22842,
        duration = 10,
        tick_time = 1,
        max_stack = 1,
        copy = { 22842, 22845, 22895, 22896, 26999 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    gift_of_the_wild = {
        id = 21849,
        duration = 3600,
        max_stack = 1,
        copy = { 21849, 21850, 26991 },
        -- Aura effects: MOD_RESISTANCE, MOD_RESISTANCE_EXCLUSIVE, MOD_STAT
        -- Aura targets: TARGET_UNIT_LASTTARGET_AREA_PARTY, TARGET_UNIT_TARGET_ALLY
    },

    growl = {
        id = 6795,
        duration = 3,
        max_stack = 1,
        -- Aura effects: MOD_TAUNT
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    hibernate = {
        id = 2637,
        duration = 40,
        max_stack = 1,
        copy = { 2637, 18657, 18658 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    hurricane = {
        id = 16914,
        duration = 10,
        tick_time = 1,
        max_stack = 1,
        copy = { 16914, 17401, 17402, 27012, 42230, 42231, 42232, 42233 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    improved_leader_of_the_pack = {
        id = 34297,
        max_stack = 1,
        copy = { 34297, 34299, 34300 },
        -- Aura effects: ADD_FLAT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    innervate = {
        id = 29166,
        duration = 20,
        max_stack = 1,
        -- Aura effects: MOD_MANA_REGEN_INTERRUPT, MOD_POWER_REGEN_PERCENT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    insect_swarm = {
        id = 5570,
        duration = 12,
        tick_time = 2,
        max_stack = 1,
        copy = { 5570, 24974, 24975, 24976, 24977, 27013 },
        -- Aura effects: MOD_HIT_CHANCE, PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    lacerate = {
        id = 33745,
        duration = 15,
        tick_time = 3,
        max_stack = 5,
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    lifebloom = {
        id = 33763,
        duration = 7,
        tick_time = 1,
        max_stack = 3,
        -- Aura effects: DUMMY, PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    maim = {
        id = 22570,
        duration = 1,
        max_stack = 1,
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    mangle_bear = {
        id = 33878,
        duration = 12,
        max_stack = 1,
        copy = { 33878, 33986, 33987 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    mangle_cat = {
        id = 33876,
        duration = 12,
        max_stack = 1,
        copy = { 33876, 33982, 33983 },
        -- Aura effects: DUMMY
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    mark_of_the_wild = {
        id = 1126,
        duration = 1800,
        max_stack = 1,
        copy = { 1126, 5232, 5234, 6756, 8907, 9884, 9885, 26990 },
        -- Aura effects: MOD_RESISTANCE, MOD_RESISTANCE_EXCLUSIVE, MOD_STAT
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    moonfire = {
        id = 8921,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 8921, 8924, 8925, 8926, 8927, 8928, 8929, 9833, 9834, 9835, 26987, 26988 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    moonkin_form = {
        id = 24858,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    natures_grasp = {
        id = 16689,
        duration = 45,
        max_stack = 1,
        copy = { 16689, 16810, 16811, 16812, 16813, 17329, 27009 },
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    natures_swiftness = {
        id = 17116,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    omen_of_clarity = {
        id = 16864,
        duration = 1800,
        max_stack = 1,
        -- Aura effects: PROC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    clearcasting = {
        id = 16870,
        duration = 15,
        max_stack = 1,
        -- Aura effects: ADD_PCT_MODIFIER
        -- Aura targets: TARGET_UNIT_CASTER
    },

    pounce = {
        id = 9005,
        duration = 3,
        max_stack = 1,
        copy = { 9005, 9823, 9827, 27006 },
        -- Aura effects: MOD_STUN
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    pounce_bleed = {
        id = 9007,
        duration = 18,
        tick_time = 3,
        max_stack = 1,
        copy = { 9007, 9824, 9826, 27007 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    prowl = {
        id = 5215,
        max_stack = 1,
        copy = { 5215, 6783, 9913 },
        -- Aura effects: MOD_DECREASE_SPEED, MOD_STEALTH
        -- Aura targets: TARGET_UNIT_CASTER
    },

    rake = {
        id = 1822,
        duration = 9,
        tick_time = 3,
        max_stack = 1,
        copy = { 1822, 1823, 1824, 9904, 27003 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    regrowth = {
        id = 8936,
        duration = 21,
        tick_time = 3,
        max_stack = 1,
        copy = { 8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980 },
        -- Aura effects: PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    rejuvenation = {
        id = 774,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982 },
        -- Aura effects: MOD_RATING, PERIODIC_HEAL
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    rip = {
        id = 1079,
        duration = 12,
        tick_time = 2,
        max_stack = 1,
        copy = { 1079, 9492, 9493, 9752, 9894, 9896, 27008 },
        -- Aura effects: PERIODIC_DAMAGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    soothe_animal = {
        id = 2908,
        duration = 15,
        max_stack = 1,
        copy = { 2908, 8955, 9901, 26995 },
        -- Aura effects: MOD_DETECT_RANGE
        -- Aura targets: TARGET_UNIT_TARGET_ENEMY
    },

    swift_flight_form = {
        id = 40120,
        max_stack = 1,
        copy = { 33943, 40120 },
        -- Aura effects: FLY, MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    thorns = {
        id = 467,
        duration = 600,
        max_stack = 1,
        copy = { 467, 782, 1075, 8914, 9756, 9910, 26992 },
        -- Aura effects: DAMAGE_SHIELD
        -- Aura targets: TARGET_UNIT_TARGET_ALLY
    },

    tigers_fury = {
        id = 5217,
        duration = 6,
        max_stack = 1,
        copy = { 5217, 6793, 9845, 9846 },
        -- Aura effects: MOD_DAMAGE_DONE
        -- Aura targets: TARGET_UNIT_CASTER
    },

    track_humanoids = {
        id = 5225,
        max_stack = 1,
        -- Aura effects: TRACK_CREATURES
        -- Aura targets: TARGET_UNIT_CASTER
    },

    tranquility = {
        id = 740,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 740, 8918, 9862, 9863, 26983 },
        -- Aura effects: PERIODIC_TRIGGER_SPELL
        -- Aura targets: TARGET_UNIT_CASTER
    },

    travel_form = {
        id = 783,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

    tree_of_life = {
        id = 33891,
        max_stack = 1,
        -- Aura effects: MECHANIC_IMMUNITY, MOD_SHAPESHIFT
        -- Aura targets: TARGET_UNIT_CASTER
    },

} )

-- Abilities (Hekili-style scaffold)
spec:RegisterAbilities( {

-- Abolish Poison - Attempts to cure 1 poison effect on the target, and 1 more poison effect every $t1 seconds for 8 sec.
    abolish_poison = {
        id = 2893,
        cast = 0,
        duration = 8,
        gcd = "spell",
        school = "nature",
        texture = 136068,
        range = 40,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 2893 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0, trigger_spell_id: 3137
        -- [ ] Rank 2893 #1 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "abolish_poison" )
        end,
    },

-- Abolish Poison Effect
    abolish_poison_effect = {
        id = 3137,
        cast = 0,
        school = "nature",
        texture = 136068,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 3137 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
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

-- Aquatic Form - Shapeshift into aquatic form, increasing swim speed by 50% and allowing the druid to breathe underwater. Also protects the caster from Polymorph effects. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    aquatic_form = {
        id = 1066,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132112,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 1066 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 1066 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "aquatic_form" )
        end,

        proc_chance = 100,
    },

-- Barkskin - The druid's skin becomes as tough as bark. All damage taken is reduced by 20%. While protected, damaging attacks will not cause spellcasting delays. This spell is usable while stunned, frozen, incapacitated, feared or asleep. Lasts 12 sec.
    barkskin = {
        id = 22812,
        cast = 0,
        duration = 12,
        cooldown = 60,
        gcd = "spell",
        school = "nature",
        texture = 136097,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 22812 #0 -- effect: APPLY_AURA, aura: REDUCE_PUSHBACK, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22812 #1 -- effect: APPLY_AURA, aura: MOD_DAMAGE_PERCENT_TAKEN, points: -21, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "barkskin" )
        end,
    },

-- Bash - Stuns the target for 2/3/4 sec.
    bash = {
        id = 5211,
        cast = 0,
        duration = 4,
        category_cooldown = 60,
        gcd = "spell",
        school = "physical",
        texture = 132114,
        cooldown_category_id = 32,
        cooldown_category = "Stun",
        range = 5,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 5211, 6798, 8983 },

        -- Effects:
        -- [x] Rank 5211 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6798 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8983 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "bash" )
        end,

        proc_chance = 100,
    },

-- Bear Form - Shapeshift into bear form, increasing melee attack power by 30, armor contribution from items by 180%, and Stamina by 25%. Also protects the caster from Polymorph effects and allows the use of various bear abilities. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    bear_form = {
        id = 5487,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132276,
        spend_pct = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5487, 9634 },

        -- Effects:
        -- [x] Rank 5487 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5487 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "bear_form" )

            if state.equipped and state.equipped.wolfshead_helm then
                gain_bear_rage( 5 )
            end
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

-- Cat Form - Shapeshift into cat form, increasing melee attack power by 40 plus Agility. Also protects the caster from Polymorph effects and allows the use of various cat abilities. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    cat_form = {
        id = 768,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132115,
        spend_pct = 35,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 768 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 768 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 768 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "cat_form" )

            if state.equipped and state.equipped.wolfshead_helm then
                gain_cat_energy( 20 )
            end
        end,

        proc_chance = 100,
    },

-- Challenging Roar - Forces all nearby enemies to focus attacks on you for 6 sec.
    challenging_roar = {
        id = 5209,
        cast = 0,
        duration = 6,
        cooldown = 600,
        gcd = "spell",
        school = "physical",
        texture = 132117,
        spend = 15,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 5209 #0 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Claw - Claw the enemy, causing 27-190 additional damage. Awards 1 combo $lpoint:points;.
    claw = {
        id = 1082,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132140,
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 45 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1082, 3029, 5201, 9849, 9850, 27000 },

        -- Effects:
        -- [ ] Rank 1082 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 26, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 1082 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 3029 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 38, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 3029 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 5201 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 56, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 5201 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9849 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 87, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9849 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9850 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9850 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27000 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 189, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27000 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
        end,

        proc_chance = 40,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability
    },

-- Cower - Cower, causing no damage but lowering your threat a small amount, making the enemy less likely to attack you.
    cower = {
        id = 8998,
        cast = 0,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132118,
        cooldown_category_id = 84,
        cooldown_category = "Taunt (AE)",
        range = 5,
        spend = 20,
        spendType = "Energy",
        max_stack = 1,
        copy = { 8998, 9000, 9892, 27004, 31709 },

        -- Effects:
        -- [ ] Rank 8998 #0 -- effect: THREAT, aura: NONE, points: -241, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9000 #0 -- effect: THREAT, aura: NONE, points: -391, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9892 #0 -- effect: THREAT, aura: NONE, points: -601, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27004 #0 -- effect: THREAT, aura: NONE, points: -1171, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 31709 #0 -- effect: THREAT, aura: NONE, points: -801, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Cure Poison - Cures 1 poison $leffect:effects; on the target.
    cure_poison = {
        id = 8946,
        cast = 0,
        gcd = "spell",
        school = "nature",
        texture = 136067,
        range = 40,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 8946 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Cyclone - Tosses the enemy target into the air, preventing all action but making them invulnerable for up to 6 sec. Only one target can be affected by your Cyclone at a time.
    cyclone = {
        id = 33786,
        cast = 1.5,
        duration = 6,
        gcd = "spell",
        school = "nature",
        texture = 136022,
        range = 20,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 33786 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33786 #1 -- effect: APPLY_AURA, aura: SCHOOL_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "cyclone" )
        end,

        proc_chance = 100,
    },

-- Dash - Increases movement speed by 50/60/70% for 15 sec. Does not break prowling.
    dash = {
        id = 1850,
        cast = 0,
        duration = 15,
        category_cooldown = 300,
        school = "physical",
        texture = 132120,
        cooldown_category_id = 44,
        cooldown_category = "Speed",
        spendType = "Energy",
        max_stack = 1,
        copy = { 1850, 9821, 33357 },

        -- Effects:
        -- [x] Rank 1850 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9821 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33357 #0 -- effect: APPLY_AURA, aura: MOD_INCREASE_SPEED, points: 69, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "dash" )
        end,

        proc_chance = 100,
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

-- Demoralizing Roar - The druid roars, decreasing nearby enemies' melee attack power by 30-240. Lasts 30 sec.
    demoralizing_roar = {
        id = 99,
        cast = 0,
        duration = 30,
        gcd = "spell",
        school = "physical",
        texture = 132121,
        spend = 10,
        spendType = "Rage",
        max_stack = 1,
        copy = { 99, 1735, 9490, 9747, 9898, 26998 },

        -- Effects:
        -- [ ] Rank 99 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -31, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 1735 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -51, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 9490 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -66, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 9747 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -101, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 9898 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -131, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        -- [ ] Rank 26998 #0 -- effect: APPLY_AURA, aura: MOD_ATTACK_POWER, points: -241, addl_points: 1, points_per_level: -1, sp_bonus: 0, radius_idx: 13, target: TARGET_SRC_CASTER, target2: TARGET_UNIT_SRC_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 10,

        handler = function ()
        end,

        proc_chance = 100,
    },

-- Dire Bear Form - Shapeshift into dire bear form, increasing melee attack power by 120, armor contribution from items by 400%, and Stamina by 25%. Also protects the caster from Polymorph effects and allows the use of various bear abilities. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    dire_bear_form = {
        id = 9634,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132276,
        spend_pct = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5487, 9634 },

        -- Effects:
        -- [x] Rank 9634 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9634 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "dire_bear_form" )

            if state.equipped and state.equipped.wolfshead_helm then
                gain_bear_rage( 5 )
            end
        end,

        proc_chance = 100,
    },

-- Enrage - Generates 20 rage over 10 sec, but reduces base armor by 27% in Bear Form and 16% in Dire Bear Form.
    enrage = {
        id = 5229,
        cast = 0,
        duration = 10,
        cooldown = 60,
        school = "physical",
        texture = 132126,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5229 #0 -- effect: APPLY_AURA, aura: PERIODIC_ENERGIZE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 5229 #1 -- effect: DUMMY, aura: NONE, points: -76, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [x] Rank 5229 #2 -- effect: APPLY_AURA, aura: INTERRUPT_REGEN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "enrage" )
        end,
    },

-- Enraged Defense - You gain $/10;11413s1 rage whenever a party member within $a1 yards takes damage. Lasts 30 sec.
    enraged_defense = {
        id = 6542,
        cast = 0,
        duration = 30,
        cooldown = 300,
        gcd = "spell",
        school = "physical",
        texture = 132136,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 6542 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 23, target: TARGET_UNIT_CASTER_AREA_PARTY, target2: NONE, mechanic: 0

        radius = 40,

        proc_chance = 100,
        proc_type_mask = { 1048576, 0 },
        -- Proc type flags: mask0: Take Any Damage - DO NOT USE
    },

-- Entangling Roots - Roots the target in place and causes 20-351 Nature damage over 12-27 sec. Damage caused may interrupt the effect. Only useable outdoors.
    entangling_roots = {
        id = 339,
        cast = 1.5,
        duration = 27,
        gcd = "spell",
        school = "nature",
        texture = 136100,
        range = 30,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 339, 1062, 5195, 5196, 9852, 9853, 26989 },

        -- Effects:
        -- [x] Rank 339 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 339 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0.055, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1062 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1062 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0.093, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5195 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5195 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5196 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5196 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9852 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9852 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9853 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9853 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26989 #0 -- effect: APPLY_AURA, aura: MOD_ROOT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26989 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 38, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "entangling_roots" )
        end,

        proc_chance = 100,
    },

-- Faerie Fire - Decrease the armor of the target by 175/285/395/505/610 for 40 sec. While affected, the target cannot stealth or turn invisible.
    faerie_fire = {
        id = 770,
        cast = 0,
        duration = 40,
        gcd = "spell",
        school = "nature",
        texture = 136033,
        range = 30,
        spend = 55,
        spendType = "Mana",
        max_stack = 1,
        copy = { 770, 778, 9749, 9907, 26993 },

        -- Effects:
        -- [x] Rank 770 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -176, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 770 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 770 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 778 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -286, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 778 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 778 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9749 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -396, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9749 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9749 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9907 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -506, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9907 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9907 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26993 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -611, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26993 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26993 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "faerie_fire" )
        end,

        proc_chance = 100,
    },

-- Faerie Fire (Feral) - Decrease the armor of the target by 175/285/395/505/610 for 40 sec. While affected, the target cannot stealth or turn invisible.
    faerie_fire_feral = {
        id = 16857,
        cast = 0,
        duration = 40,
        category_cooldown = 6,
        gcd = "spell",
        school = "nature",
        texture = 136033,
        cooldown_category_id = 1133,
        cooldown_category = "Faerie Fire (Feral)",
        range = 30,
        spendType = "Energy",
        max_stack = 1,
        copy = { 16857, 17390, 17391, 17392, 27011 },

        -- Effects:
        -- [x] Rank 16857 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -176, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 16857 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 16857 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17390 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -286, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17390 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17390 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17391 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -396, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17391 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17391 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17392 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -506, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17392 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17392 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27011 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: -611, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27011 #1 -- effect: APPLY_AURA, aura: MOD_ATTACKER_MELEE_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27011 #2 -- effect: APPLY_AURA, aura: MOD_ATTACKER_RANGED_HIT_CHANCE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "faerie_fire_feral" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Feral Charge - Causes you to charge an enemy, immobilizing and interrupting any spell being cast for $19675d.
    feral_charge = {
        id = 16979,
        cast = 0,
        cooldown = 15,
        school = "physical",
        texture = 132183,
        min_range = 8,
        range = 25,
        spend = 5,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 16979 #0 -- effect: CHARGE, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 16979 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 19675
        -- [ ] Rank 16979 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 45334

        -- Related talents:
        -- talent_0 [0]
    },

-- Ferocious Bite - Finishing move that causes damage per combo point and converts each extra point of energy into $f1 additional damage. Damage is increased by your attack power. 1 point : 50-66 damage 2 points: 86-102 damage 3 points: 122-138 damage 4 points: 158-174 damage 5 points: 194-210 damage
    ferocious_bite = {
        id = 22568,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132127,
        range = 5,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,
        copy = { 22568, 22827, 22828, 22829, 24248, 31018 },

        -- Effects:
        -- [x] Rank 22568 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 13, addl_points: 17, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 22827 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 19, addl_points: 25, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 22828 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 29, addl_points: 41, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 22829 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 44, addl_points: 51, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24248 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 56, addl_points: 67, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 31018 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 51, addl_points: 61, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "ferocious_bite" ) end
            spend_cat_combo_points()
        end,
    },

-- Flight Form - Shapeshift into flight form, increasing movement speed by 60% and allowing you to fly. Cannot use in combat. Can only use this form in Outland. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    flight_form = {
        id = 33943,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132128,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,
        copy = { 33943, 40120 },

        -- Effects:
        -- [x] Rank 33943 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33943 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33943 #2 -- effect: APPLY_AURA, aura: FLY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "flight_form" )
        end,

        proc_chance = 100,
    },

-- Force of Nature - Summons 3 treants to attack enemy targets for 30 sec.
    force_of_nature = {
        id = 33831,
        cast = 0,
        duration = 30,
        cooldown = 180,
        gcd = "spell",
        school = "nature",
        texture = 132129,
        range = 30,
        spend_pct = 12,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 33831 #0 -- effect: SUMMON, aura: NONE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_DEST_AREA_ENTRY, target2: NONE, mechanic: 0
        -- [ ] Rank 33831 #1 -- effect: APPLY_AURA, aura: PERIODIC_DUMMY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 7, target: TARGET_UNIT_DEST_AREA_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        radius = 2,

        handler = function ()
            if type( summonPet ) == "function" then summonPet( "treants", 30 ) end
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Frenzied Regeneration - Converts up to 10 rage per second into health for 10 sec. Each point of rage is converted into 1/10/15/20/25 health.
    frenzied_regeneration = {
        id = 22842,
        cast = 0,
        duration = 10,
        category_cooldown = 180,
        gcd = "spell",
        school = "physical",
        texture = 132091,
        cooldown_category_id = 1011,
        cooldown_category = "Frenzied Healing",
        spendType = "Rage",
        max_stack = 1,
        copy = { 22842, 22845, 22895, 22896, 26999 },

        -- Effects:
        -- [x] Rank 22842 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 22845 #0 -- effect: HEAL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22895 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 22896 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 26999 #0 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "frenzied_regeneration" )
        end,

        proc_chance = 100,
    },

-- Gift of the Wild - Gives the Gift of the Wild to the target's party, increasing armor by 240/285/340, all attributes by 10/12/14 and all resistances by 15/20/25 for 3600 sec.
    gift_of_the_wild = {
        id = 21849,
        cast = 0,
        duration = 3600,
        gcd = "spell",
        school = "nature",
        texture = 136038,
        range = 40,
        spend = 900,
        spendType = "Mana",
        max_stack = 1,
        copy = { 21849, 21850, 26991 },

        -- Effects:
        -- [x] Rank 21849 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 239, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21849 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21849 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21850 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 284, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21850 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 21850 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 26991 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 339, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 26991 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0
        -- [x] Rank 26991 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: TARGET_UNIT_LASTTARGET_AREA_PARTY, mechanic: 0

        handler = function ()
            applyBuff( "gift_of_the_wild" )
        end,
    },

-- Growl - Taunts the target to attack you, but has no effect if the target is already attacking you.
    growl = {
        id = 6795,
        cast = 0,
        duration = 3,
        category_cooldown = 10,
        school = "physical",
        texture = 132270,
        cooldown_category_id = 82,
        cooldown_category = "Taunt/Detaunt",
        range = 5,
        spendType = "Rage",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 6795 #0 -- effect: ATTACK_ME, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6795 #1 -- effect: APPLY_AURA, aura: MOD_TAUNT, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "growl" )
        end,

        proc_chance = 100,
    },

-- Healing Touch - Heals a friendly target for 37-2707.
    healing_touch = {
        id = 5185,
        cast = 1.5,
        gcd = "spell",
        school = "nature",
        texture = 136041,
        range = 40,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5185, 5186, 5187, 5188, 5189, 6778, 8903, 9758, 9888, 9889, 25297, 26978, 26979 },

        -- Effects:
        -- [ ] Rank 5185 #0 -- effect: HEAL, aura: NONE, points: 36, addl_points: 15, points_per_level: 0.8, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 5186 #0 -- effect: HEAL, aura: NONE, points: 87, addl_points: 25, points_per_level: 1.3, sp_bonus: 0.314, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 5187 #0 -- effect: HEAL, aura: NONE, points: 194, addl_points: 49, points_per_level: 1.9, sp_bonus: 0.554, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 5188 #0 -- effect: HEAL, aura: NONE, points: 362, addl_points: 83, points_per_level: 2.7, sp_bonus: 0.857, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 5189 #0 -- effect: HEAL, aura: NONE, points: 571, addl_points: 123, points_per_level: 3.5, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 6778 #0 -- effect: HEAL, aura: NONE, points: 741, addl_points: 153, points_per_level: 4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8903 #0 -- effect: HEAL, aura: NONE, points: 935, addl_points: 185, points_per_level: 4.5, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9758 #0 -- effect: HEAL, aura: NONE, points: 1198, addl_points: 229, points_per_level: 5.2, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9888 #0 -- effect: HEAL, aura: NONE, points: 1515, addl_points: 281, points_per_level: 5.9, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9889 #0 -- effect: HEAL, aura: NONE, points: 1889, addl_points: 341, points_per_level: 6.6, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 25297 #0 -- effect: HEAL, aura: NONE, points: 2266, addl_points: 411, points_per_level: 7.3, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 26978 #0 -- effect: HEAL, aura: NONE, points: 2363, addl_points: 427, points_per_level: 7.4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 26979 #0 -- effect: HEAL, aura: NONE, points: 2706, addl_points: 491, points_per_level: 8.2, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Hibernate - Forces the enemy target to sleep for up to 20/30/40 sec. Any damage will awaken the target. Only one target can be forced to hibernate at a time. Only works on Beasts and Dragonkin.
    hibernate = {
        id = 2637,
        cast = 1.5,
        duration = 40,
        gcd = "spell",
        school = "nature",
        texture = 136090,
        range = 30,
        spend = 90,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2637, 18657, 18658 },

        -- Effects:
        -- [x] Rank 2637 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18657 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 18658 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "hibernate" )
        end,

        proc_chance = 100,
    },

-- Hurricane - Creates a violent storm in the target area causing 70 Nature damage to enemies every $t3 sec, and increasing the time between attacks of enemies by 25%. Lasts 10 sec. Druid must channel to maintain the spell.
    hurricane = {
        id = 16914,
        cast = 0,
        duration = 10,
        category_cooldown = 60,
        gcd = "spell",
        school = "nature",
        texture = 136018,
        cooldown_category_id = 571,
        cooldown_category = "Hurricane",
        range = 100,
        spend = 880,
        spendType = "Mana",
        max_stack = 1,
        copy = { 16914, 17401, 17402, 27012, 42230, 42231, 42232, 42233 },

        -- Effects:
        -- [ ] Rank 16914 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 69, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.107, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 16914 #1 -- effect: PERSISTENT_AREA_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 16914 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42231
        -- [ ] Rank 17401 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 99, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.107, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17401 #1 -- effect: PERSISTENT_AREA_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17401 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42232
        -- [ ] Rank 17402 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 133, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.107, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 17402 #1 -- effect: PERSISTENT_AREA_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 17402 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42233
        -- [ ] Rank 27012 #0 -- effect: PERSISTENT_AREA_AURA, aura: DUMMY, points: 205, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.107, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27012 #1 -- effect: PERSISTENT_AREA_AURA, aura: MOD_MELEE_HASTE, points: -26, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 14, target: TARGET_DEST_DYNOBJ_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27012 #2 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 42230
        -- [x] Rank 42230 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 205, addl_points: 1, points_per_level: 0.4, sp_bonus: 0.129, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42231 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 69, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.129, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42232 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 99, addl_points: 1, points_per_level: 0.2, sp_bonus: 0.129, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        -- [x] Rank 42233 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 133, addl_points: 1, points_per_level: 0.3, sp_bonus: 0.129, radius_idx: 14, target: TARGET_DEST_CHANNEL_TARGET, target2: TARGET_UNIT_DEST_AREA_ENEMY, mechanic: 0
        startsCombat = true,

        radius = 8,

        channeled = true,

        handler = function ()
            applyBuff( "hurricane" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "hurricane" ) end
        end,

        proc_chance = 100,
    },

-- Hyper-Magnified Moon Specs
    hyper_magnified_moon_specs = {
        id = 46109,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46109 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Improved Leader of the Pack - Your Leader of the Pack ability also causes affected targets to have a 100% chance to heal themselves for 0/2/4% of their total health when they critically hit with a melee or ranged attack. The healing effect cannot occur more than once every 6 sec.
    improved_leader_of_the_pack = {
        id = 34297,
        cast = 0,
        texture = 136112,
        max_stack = 1,
        copy = { 34297, 34299, 34300 },

        -- Effects:
        -- [x] Rank 34297 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34297 #1 -- effect: DUMMY, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34299 #0 -- effect: HEAL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 34300 #0 -- effect: APPLY_AURA, aura: ADD_FLAT_MODIFIER, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 34300 #1 -- effect: DUMMY, aura: NONE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "improved_leader_of_the_pack" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Innervate - Increases the target's Spirit based mana regeneration by 400% and allows full mana regeneration while casting. Lasts 20 sec.
    innervate = {
        id = 29166,
        cast = 0,
        duration = 20,
        cooldown = 360,
        gcd = "spell",
        school = "nature",
        texture = 136048,
        range = 30,
        spend_pct = 4,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 29166 #0 -- effect: APPLY_AURA, aura: MOD_MANA_REGEN_INTERRUPT, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 29166 #1 -- effect: APPLY_AURA, aura: MOD_POWER_REGEN_PERCENT, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "innervate" )
        end,
    },

-- Insect Swarm - The enemy target is swarmed by insects, decreasing their chance to hit by 2% and causing 108-792 Nature damage over 12 sec.
    insect_swarm = {
        id = 5570,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "nature",
        texture = 136045,
        range = 30,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5570, 24974, 24975, 24976, 24977, 27013 },

        -- Effects:
        -- [x] Rank 5570 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5570 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24974 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24974 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24975 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 49, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24975 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24976 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 71, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24976 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24977 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 98, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 24977 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27013 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 131, addl_points: 1, points_per_level: 0, sp_bonus: 0.127, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27013 #1 -- effect: APPLY_AURA, aura: MOD_HIT_CHANCE, points: -3, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "insect_swarm" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Lacerate - Lacerates the enemy target, dealing 31 bleed damage and making them bleed for $o damage over 15 sec and causing a high amount of threat. Damage increased by attack power. This effect stacks up to $u times on the same target.
    lacerate = {
        id = 33745,
        cast = 0,
        duration = 15,
        gcd = "spell",
        school = "physical",
        texture = 132131,
        range = 5,
        spend = 15,
        spendType = "Rage",
        max_stack = 5,

        -- Effects:
        -- [x] Rank 33745 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [x] Rank 33745 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if debuff.lacerate.up then
                applyDebuff( "target", "lacerate", nil, min( debuff.lacerate.max_stack, debuff.lacerate.stack + 1 ) )
            else
                applyDebuff( "target", "lacerate", nil, 1 )
            end
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "lacerate" ) end
        end,

        proc_chance = 100,
    },

-- Lifebloom - Heals the target for 273 over 7 sec. When Lifebloom completes its duration or is dispelled, the target instantly heals themself for 600. This effect can stack up to $u times on the same target.
    lifebloom = {
        id = 33763,
        cast = 0,
        duration = 7,
        gcd = "spell",
        school = "nature",
        texture = 134206,
        range = 40,
        spend = 220,
        spendType = "Mana",
        max_stack = 3,

        -- Effects:
        -- [x] Rank 33763 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 38, addl_points: 1, points_per_level: 0, sp_bonus: 0.0742, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 33763 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 599, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            if buff.lifebloom.up then
                applyBuff( "lifebloom", nil, min( buff.lifebloom.max_stack, buff.lifebloom.stack + 1 ) )
            else
                applyBuff( "lifebloom" )
            end
        end,

        proc_chance = 100,
    },

-- Magnified Moon Specs
    magnified_moon_specs = {
        id = 41319,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41319 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Maim - Finishing move that causes damage and incapacitates the target. Any directly damaging attack will revive the target. Causes more damage and lasts longer per combo point: 1 point : ${$b1*1+$m1+$mw}-${$b1*1+$M1+$MW} damage, 2 sec 2 points: ${$b1*2+$m1+$mw}-${$b1*2+$M1+$MW} damage, 3 sec 3 points: ${$b1*3+$m1+$mw}-${$b1*3+$M1+$MW} damage, 4 sec 4 points: ${$b1*4+$m1+$mw}-${$b1*4+$M1+$MW} damage, 5 sec 5 points: ${$b1*5+$m1+$mw}-${$b1*5+$M1+$MW} damage, 6 sec
    maim = {
        id = 22570,
        cast = 0,
        duration = 1,
        category_cooldown = 10,
        gcd = "spell",
        school = "physical",
        texture = 132134,
        cooldown_category_id = 33,
        cooldown_category = "Mez",
        range = 5,
        spend = 35,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 22570 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 22570 #1 -- effect: APPLY_AURA, aura: MOD_STUN, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: incapacitated
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "maim" )
        end,
    },

-- Mangle - Mangle the target, inflicting damage and causing the target to take additional damage from bleed effects for $33878d. This ability can be used in Cat Form or Dire Bear Form.
    mangle = {
        id = 33917,
        cast = 0,
        texture = 132135,
        range = 100,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 33917 #0 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33878
        -- [ ] Rank 33917 #1 -- effect: LEARN_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 33876

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Mangle (Bear) - Mangle the target for 115% normal damage plus ${$m1*$m3/100} and causes the target to take 30% additional damage from Shred and bleed effects for 12 sec.
    mangle_bear = {
        id = 33878,
        cast = 0,
        duration = 12,
        category_cooldown = 6,
        gcd = "spell",
        school = "physical",
        texture = 132135,
        cooldown_category_id = 971,
        cooldown_category = "Mortal Strike",
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 20 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Rage",
        max_stack = 1,
        copy = { 33878, 33986, 33987 },

        -- Effects:
        -- [ ] Rank 33878 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33878 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33878 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33986 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33986 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33986 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33987 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 134, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33987 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33987 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 114, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            applyDebuff( "target", "mangle_bear" )
        end,

        proc_chance = 100,
    },

-- Mangle (Cat) - Mangle the target for 160% normal damage plus ${$m1*$m3/100} and causes the target to take 30% additional damage from Shred and bleed effects for 12 sec. Awards 1 combo $lpoint:points;.
    mangle_cat = {
        id = 33876,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "physical",
        texture = 132135,
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 45 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Energy",
        max_stack = 1,
        copy = { 33876, 33982, 33983 },

        -- Effects:
        -- [ ] Rank 33876 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 98, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33876 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33876 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33982 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 127, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33982 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33982 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33983 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 164, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 33983 #1 -- effect: APPLY_AURA, aura: DUMMY, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 33983 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 159, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
            applyDebuff( "target", "mangle_cat" )
        end,

        proc_chance = 100,
    },

-- Mark of the Wild - Increases the friendly target's armor by 25-340 for 1800 sec.
    mark_of_the_wild = {
        id = 1126,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "nature",
        texture = 136078,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 1126, 5232, 5234, 6756, 8907, 9884, 9885, 26990 },

        -- Effects:
        -- [x] Rank 1126 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 5232 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 64, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 5232 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 5234 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 5234 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 5234 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6756 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 6756 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8907 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 194, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8907 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8907 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9884 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 239, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9884 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9884 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9885 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 284, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9885 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9885 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26990 #0 -- effect: APPLY_AURA, aura: MOD_RESISTANCE, points: 339, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26990 #1 -- effect: APPLY_AURA, aura: MOD_STAT, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26990 #2 -- effect: APPLY_AURA, aura: MOD_RESISTANCE_EXCLUSIVE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "mark_of_the_wild" )
        end,
    },

    maul_queue = {
        duration = 5,
        max_stack = 1,
    },

-- Maul - Increases the druid's next attack by 18-176 damage.
    maul = {
        id = 6807,
        cast = 0,
        school = "physical",
        texture = 132136,
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 15 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Rage",
        max_stack = 1,
        copy = { 6807, 6808, 6809, 8972, 9745, 9880, 9881, 26996 },

        -- Effects:
        -- [ ] Rank 6807 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6808 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 26, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6809 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 36, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8972 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 48, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9745 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 70, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9880 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 100, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9881 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 127, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 26996 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 175, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            applyBuff( "maul_queue", swings and swings.time_to_next_mainhand or nil )
        end,

        proc_chance = 100,
    },

-- Moonfire - Burns the enemy for 7-305 Arcane damage and then an additional 12-600 Arcane damage over 9/12 sec.
    moonfire = {
        id = 8921,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "arcane",
        texture = 136096,
        range = 30,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8921, 8924, 8925, 8926, 8927, 8928, 8929, 9833, 9834, 9835, 26987, 26988 },

        -- Effects:
        -- [x] Rank 8921 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0.052, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8921 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 6, addl_points: 3, points_per_level: 0.5, sp_bonus: 0.06, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8924 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.081, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8924 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 12, addl_points: 5, points_per_level: 0.8, sp_bonus: 0.094, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8925 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 12, addl_points: 1, points_per_level: 0, sp_bonus: 0.111, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8925 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 7, points_per_level: 1.1, sp_bonus: 0.128, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8926 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8926 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 39, addl_points: 9, points_per_level: 1.4, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8927 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 30, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8927 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 60, addl_points: 13, points_per_level: 1.8, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8928 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 40, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8928 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 80, addl_points: 17, points_per_level: 2.1, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8929 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 52, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8929 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 104, addl_points: 21, points_per_level: 2.4, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9833 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 65, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9833 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 129, addl_points: 25, points_per_level: 2.7, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9834 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9834 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 156, addl_points: 29, points_per_level: 3, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9835 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 95, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9835 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 188, addl_points: 33, points_per_level: 3.3, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26987 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 110, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26987 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 219, addl_points: 39, points_per_level: 3.6, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26988 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 149, addl_points: 1, points_per_level: 0, sp_bonus: 0.13, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26988 #1 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 304, addl_points: 53, points_per_level: 3.9, sp_bonus: 0.15, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "moonfire" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "moonfire" ) end
        end,

        proc_chance = 100,
    },

-- Moonkin Aura - Increases spell critical chance by 5%.
    moonkin_aura = {
        id = 24907,
        cast = 0,
        school = "nature",
        texture = 136057,
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 24907 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_SPELL_CRIT_CHANCE, points: 4, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 24907 #1 -- effect: APPLY_AREA_AURA_PARTY, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 10, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        radius = 30,
    },

-- Moonkin Form - Shapeshift into Moonkin Form. While in this form the armor contribution from items is increased by 400%, attack power is increased by 150% of your level and all party members within $24907a1 yards have their spell critical chance increased by 5%. Melee attacks in this form have a chance on hit to regenerate mana based on attack power. The Moonkin can only cast Balance and Remove Curse spells while shapeshifted. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    moonkin_form = {
        id = 24858,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 136036,
        spend_pct = 22,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 24858 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 24858 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [ ] Rank 24858 #2 -- effect: TRIGGER_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 24907

        handler = function ()
            clear_druid_forms()
            applyBuff( "moonkin_form" )
        end,

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Nature's Grasp - While active, any time an enemy strikes the caster they have a $h% chance to become afflicted by Entangling Roots (Rank 1). Only useable outdoors. $n charge. Lasts 45 sec.
    natures_grasp = {
        id = 16689,
        cast = 0,
        duration = 45,
        category_cooldown = 60,
        gcd = "spell",
        school = "nature",
        texture = 136063,
        cooldown_category_id = 531,
        cooldown_category = "Nature's Grasp",
        max_stack = 1,
        copy = { 16689, 16810, 16811, 16812, 16813, 17329, 27009 },

        -- Effects:
        -- [x] Rank 16689 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19975
        -- [x] Rank 16810 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19974
        -- [x] Rank 16811 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19973
        -- [x] Rank 16812 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19972
        -- [x] Rank 16813 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19971
        -- [x] Rank 17329 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 19970
        -- [x] Rank 27009 #1 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 27010

        handler = function ()
            applyBuff( "natures_grasp" )
        end,

        proc_chance = 35,
        proc_charges = 1,
        proc_type_mask = { 40, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Nature's Swiftness - When activated, your next Nature spell becomes an instant cast spell.
    natures_swiftness = {
        id = 17116,
        cast = 0,
        cooldown = 180,
        school = "physical",
        texture = 136076,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 17116 #0 -- effect: APPLY_AURA, aura: ADD_PCT_MODIFIER, points: -101, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

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

-- Omen of Clarity - Imbues the Druid with natural energy. Each of the Druid's melee attacks has a chance of causing the caster to enter a Clearcasting state. The Clearcasting state reduces the Mana, Rage or Energy cost of your next damage or healing spell or offensive ability by 100%. Lasts 1800 sec.
    omen_of_clarity = {
        id = 16864,
        cast = 0,
        duration = 1800,
        gcd = "spell",
        school = "nature",
        texture = 136017,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 16864 #0 -- effect: APPLY_AURA, aura: PROC_TRIGGER_SPELL, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 16870

        handler = function ()
            applyBuff( "omen_of_clarity" )
        end,

        proc_chance = 100,
        proc_category_recovery = 10,
        proc_type_mask = { 20, 0 },
        -- Proc type flags: mask0: Deal Melee Swing; Deal Melee Ability

        -- Related talents:
        -- talent_0 [0]
    },

-- Pounce - Pounce, stunning the target for 3 sec and causing $9007o1 damage over $9007d. Must be prowling. Awards 1 combo $lpoint:points;.
    pounce = {
        id = 9005,
        cast = 0,
        duration = 3,
        gcd = "spell",
        school = "physical",
        texture = 132142,
        range = 5,
        spend = 50,
        spendType = "Energy",
        max_stack = 1,
        copy = { 9005, 9823, 9827, 27006 },

        -- Effects:
        -- [x] Rank 9005 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: stunned
        -- [ ] Rank 9005 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 9007
        -- [ ] Rank 9005 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9823 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: stunned
        -- [ ] Rank 9823 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 9824
        -- [ ] Rank 9823 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9827 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: stunned
        -- [ ] Rank 9827 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 9826
        -- [ ] Rank 9827 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27006 #0 -- effect: APPLY_AURA, aura: MOD_STUN, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: stunned
        -- [ ] Rank 27006 #1 -- effect: TRIGGER_SPELL, aura: NONE, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0, trigger_spell_id: 27007
        -- [ ] Rank 27006 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
            applyDebuff( "target", "pounce" )
        end,

        proc_chance = 100,
    },

-- Pounce Bleed - Bleeding for 45/55/75/100 damage every $t1 seconds.
    pounce_bleed = {
        id = 9007,
        cast = 0,
        duration = 18,
        texture = 136231,
        range = 5,
        spendType = "Energy",
        max_stack = 1,
        copy = { 9007, 9824, 9826, 27007 },

        -- Effects:
        -- [x] Rank 9007 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9824 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9826 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 74, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27007 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 99, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "pounce_bleed" )
        end,

        proc_chance = 100,
    },

-- Primal Fury - Gives you a $16958h% chance to gain an additional $/10;16959s1 Rage anytime you get a critical strike while in Bear and Dire Bear Form and your critical strikes from Cat Form abilities that add combo points have a $16952h% chance to add an additional combo point.
    primal_fury = {
        id = 37116,
        cast = 0,
        texture = 132278,
        max_stack = 1,
        copy = { 37116, 37117 },

        -- Effects:
        -- [ ] Rank 37116 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 16958
        -- [ ] Rank 37116 #1 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 16952
        -- [ ] Rank 37117 #0 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 16961
        -- [ ] Rank 37117 #1 -- effect: LEARN_SPELL, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 16954

        proc_chance = 100,

        -- Related talents:
        -- talent_0 [0]
    },

-- Prowl - Allows the Druid to prowl around, but reduces your movement speed by 30/35/40%. Lasts until cancelled.
    prowl = {
        id = 5215,
        cast = 0,
        category_cooldown = 10,
        school = "physical",
        texture = 132089,
        cooldown_category_id = 38,
        cooldown_category = "Aura",
        spendType = "Energy",
        max_stack = 1,
        copy = { 5215, 6783, 9913 },

        -- Effects:
        -- [x] Rank 5215 #0 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 99, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 5215 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -41, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6783 #0 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 199, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6783 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -36, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9913 #0 -- effect: APPLY_AURA, aura: MOD_STEALTH, points: 299, addl_points: 1, points_per_level: 5, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9913 #1 -- effect: APPLY_AURA, aura: MOD_DECREASE_SPEED, points: -31, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "prowl" )
        end,

        proc_chance = 100,
        proc_charges = 1,
        proc_type_mask = { 139944, 0 },
        -- Proc type flags: mask0: Take Melee Swing; Take Melee Ability; Take Ranged Attack; Take Ranged Ability; Take Harmful Ability; Take Harmful Spell

        -- Aura restrictions: exclude_caster_state=12
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

-- Rake - Rake the target for ${$AP/100+$m1} bleed damage and an additional ${$m2*3+$AP*0.06} damage over 9 sec. Awards 1 combo $lpoint:points;.
    rake = {
        id = 1822,
        cast = 0,
        duration = 9,
        gcd = "spell",
        school = "physical",
        texture = 132122,
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 40 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1822, 1823, 1824, 9904, 27003 },

        -- Effects:
        -- [x] Rank 1822 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1822 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [ ] Rank 1822 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1823 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 25, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1823 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [ ] Rank 1823 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1824 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 1824 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [ ] Rank 1824 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9904 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 54, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9904 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [ ] Rank 9904 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27003 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 77, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27003 #1 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 35, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: bleeding
        -- [ ] Rank 27003 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
            applyDebuff( "target", "rake" )
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "rake" ) end
        end,

        proc_chance = 100,
    },

-- Ravage - Ravage the target, causing 385% damage plus 147 to the target. Must be prowling and behind the target. Awards 1 combo $lpoint:points;.
    ravage = {
        id = 6785,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132141,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,
        copy = { 6785, 6787, 9866, 9867, 27005 },

        -- Effects:
        -- [ ] Rank 6785 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 41, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6785 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 384, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6785 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6787 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 61, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6787 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 384, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6787 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9866 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 77, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9866 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 384, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9866 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9867 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 97, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9867 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 384, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9867 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27005 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 146, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27005 #1 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 384, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27005 #2 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
        end,

        proc_chance = 100,
    },

-- Rebirth - Returns the spirit to the body, restoring a dead target to life with 400-3200 health and $q mana.
    rebirth = {
        id = 20484,
        cast = 2,
        category_cooldown = 1200,
        gcd = "spell",
        school = "nature",
        texture = 136080,
        cooldown_category_id = 26,
        cooldown_category = "Resurrection (Full)",
        range = 30,
        spend_pct = 68,
        spendType = "Mana",
        max_stack = 1,
        copy = { 20484, 20739, 20742, 20747, 20748, 26994 },

        -- Effects:
        -- [ ] Rank 20484 #0 -- effect: 329, aura: NONE, points: 399, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20739 #0 -- effect: 329, aura: NONE, points: 749, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20742 #0 -- effect: 329, aura: NONE, points: 1099, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20747 #0 -- effect: 329, aura: NONE, points: 1599, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 20748 #0 -- effect: 329, aura: NONE, points: 2199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
        -- [ ] Rank 26994 #0 -- effect: 329, aura: NONE, points: 3199, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: NONE, target2: NONE, mechanic: 0
    },

-- Regrowth - Heals a friendly target for 84-1215 and another 98-1274 over 21 sec.
    regrowth = {
        id = 8936,
        cast = 2,
        duration = 21,
        gcd = "spell",
        school = "nature",
        texture = 136085,
        range = 40,
        spend = 80,
        spendType = "Mana",
        max_stack = 1,
        copy = { 8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980 },

        -- Effects:
        -- [ ] Rank 8936 #0 -- effect: HEAL, aura: NONE, points: 83, addl_points: 15, points_per_level: 1.8, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8936 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0.07, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8938 #0 -- effect: HEAL, aura: NONE, points: 163, addl_points: 25, points_per_level: 2.5, sp_bonus: 0.264, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8938 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0.093, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8939 #0 -- effect: HEAL, aura: NONE, points: 239, addl_points: 35, points_per_level: 3.1, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8939 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 36, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8940 #0 -- effect: HEAL, aura: NONE, points: 317, addl_points: 43, points_per_level: 3.6, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8940 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 48, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 8941 #0 -- effect: HEAL, aura: NONE, points: 404, addl_points: 53, points_per_level: 4.1, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8941 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 60, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9750 #0 -- effect: HEAL, aura: NONE, points: 510, addl_points: 65, points_per_level: 4.7, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9750 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 77, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9856 #0 -- effect: HEAL, aura: NONE, points: 645, addl_points: 79, points_per_level: 5.3, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9856 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 97, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9857 #0 -- effect: HEAL, aura: NONE, points: 808, addl_points: 97, points_per_level: 6, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9857 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 122, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 9858 #0 -- effect: HEAL, aura: NONE, points: 1002, addl_points: 117, points_per_level: 6.8, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9858 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 151, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [ ] Rank 26980 #0 -- effect: HEAL, aura: NONE, points: 1214, addl_points: 141, points_per_level: 7.7, sp_bonus: 0.286, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26980 #1 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 181, addl_points: 1, points_per_level: 0, sp_bonus: 0.1, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "regrowth" )
        end,
    },

-- Rejuvenation - Heals the target for 32-1060 over 12 sec.
    rejuvenation = {
        id = 774,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "nature",
        texture = 136081,
        range = 40,
        spend = 25,
        spendType = "Mana",
        max_stack = 1,
        copy = { 774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982 },

        -- Effects:
        -- [x] Rank 774 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 7, addl_points: 1, points_per_level: 0, sp_bonus: 0.08, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 774 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1058 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 0.125, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1058 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1430 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 28, addl_points: 1, points_per_level: 0, sp_bonus: 0.17, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1430 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 2090 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 44, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 2090 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 2091 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 60, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 2091 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 3627 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 75, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 3627 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8910 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 96, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8910 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9839 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 121, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9839 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9840 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 151, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9840 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9841 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 188, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9841 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25299 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 221, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 25299 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26981 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 232, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26981 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26982 #0 -- effect: APPLY_AURA, aura: PERIODIC_HEAL, points: 264, addl_points: 1, points_per_level: 0, sp_bonus: 0.2, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26982 #1 -- effect: APPLY_AURA, aura: MOD_RATING, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "rejuvenation" )
        end,
    },

-- Remove Curse - Dispels 1 Curse from a friendly target.
    remove_curse = {
        id = 2782,
        cast = 0,
        gcd = "spell",
        school = "arcane",
        texture = 135952,
        range = 40,
        spend_pct = 8,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 2782 #0 -- effect: DISPEL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
    },

-- Rip - Finishing move that causes damage over time. Damage increases per combo point and by your attack power: 1 point : 42 damage over 12 sec. 2 points: 66 damage over 12 sec. 3 points: 90 damage over 12 sec. 4 points: 114 damage over 12 sec. 5 points: 138 damage over 12 sec.
    rip = {
        id = 1079,
        cast = 0,
        duration = 12,
        gcd = "spell",
        school = "physical",
        texture = 132152,
        range = 5,
        spend = 30,
        spendType = "Energy",
        max_stack = 1,
        copy = { 1079, 9492, 9493, 9752, 9894, 9896, 27008 },

        -- Effects:
        -- [x] Rank 1079 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9492 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 3, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9493 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9752 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9894 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9896 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 16, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 27008 #0 -- effect: APPLY_AURA, aura: PERIODIC_DAMAGE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "rip" )
            spend_cat_combo_points()
        end,

        proc_chance = 100,
    },

-- Shred - Shred the target, causing 225% damage plus 54 to the target. Must be behind the target. Awards 1 combo $lpoint:points;.
    shred = {
        id = 5221,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 136231,
        range = 5,
        spend = 60,
        spendType = "Energy",
        max_stack = 1,
        copy = { 5221, 6800, 8992, 9829, 9830, 27001, 27002 },

        -- Effects:
        -- [ ] Rank 5221 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 23, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 5221 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 5221 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6800 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 31, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6800 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 6800 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8992 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 43, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8992 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 8992 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9829 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 63, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9829 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9829 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9830 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 79, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9830 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 9830 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27001 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 104, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27001 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27001 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27002 #0 -- effect: WEAPON_DAMAGE, aura: NONE, points: 179, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27002 #1 -- effect: 328, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [ ] Rank 27002 #2 -- effect: WEAPON_PERCENT_DAMAGE, aura: NONE, points: 224, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            gain( 1, "combo_points" )
        end,

        proc_chance = 100,
    },

-- Soothe Animal - Soothes the target beast, reducing the range at which it will attack you by 10 yards. Only affects Beast targets level 40 or lower. Lasts 15 sec.
    soothe_animal = {
        id = 2908,
        cast = 1.5,
        duration = 15,
        gcd = "spell",
        school = "nature",
        texture = 132163,
        range = 40,
        spend = 50,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2908, 8955, 9901, 26995 },

        -- Effects:
        -- [x] Rank 2908 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8955 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9901 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26995 #0 -- effect: APPLY_AURA, aura: MOD_DETECT_RANGE, points: -11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0

        handler = function ()
            applyDebuff( "target", "soothe_animal" )
        end,

        proc_chance = 100,
    },

-- Starfire - Causes 89-540 Arcane damage to the target.
    starfire = {
        id = 2912,
        cast = 3.5,
        gcd = "spell",
        school = "arcane",
        texture = 135753,
        range = 30,
        spend = 95,
        spendType = "Mana",
        max_stack = 1,
        copy = { 2912, 8949, 8950, 8951, 9875, 9876, 25298, 26986 },

        -- Effects:
        -- [x] Rank 2912 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 88, addl_points: 21, points_per_level: 1.2, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8949 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 136, addl_points: 31, points_per_level: 1.6, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8950 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 200, addl_points: 41, points_per_level: 1.9, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8951 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 279, addl_points: 55, points_per_level: 2.3, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9875 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 361, addl_points: 67, points_per_level: 2.7, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9876 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 444, addl_points: 81, points_per_level: 3, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 25298 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 495, addl_points: 89, points_per_level: 3.1, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26986 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 539, addl_points: 97, points_per_level: 3.4, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "starfire" ) end
        end,

        proc_chance = 100,
    },

-- Swift Flight Form - Shapeshift into swift flight form, increasing movement speed by 280% and allowing you to fly. Cannot use in combat. Can only use this form in Outland. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    swift_flight_form = {
        id = 40120,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132128,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,
        copy = { 33943, 40120 },

        -- Effects:
        -- [x] Rank 40120 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 40120 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 40120 #2 -- effect: APPLY_AURA, aura: FLY, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "swift_flight_form" )
        end,

        proc_chance = 100,
    },

-- Swiftmend - Consumes a Rejuvenation or Regrowth effect on a friendly target to instantly heal them an amount equal to 12 sec. of Rejuvenation or 18 sec. of Regrowth.
    swiftmend = {
        id = 18562,
        cast = 0,
        cooldown = 15,
        gcd = "spell",
        school = "nature",
        texture = 134914,
        range = 40,
        spend_pct = 16,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 18562 #0 -- effect: HEAL, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        -- Aura restrictions: target_state=15

        -- Related talents:
        -- talent_0 [0]
    },

-- Swipe - Swipe $x1 nearby enemies, inflicting 10-84 damage. Damage increased by attack power.
    swipe = {
        id = 769,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 134296,
        cooldown_category_id = 85,
        cooldown_category = "Direct Damage (AE-Chain) - Ability",
        range = 5,
        spend = function ()
            if buff.clearcasting.up then return 0 end
            return max( 0, 20 - ( talent.ferocity.rank or 0 ) )
        end,
        spendType = "Rage",
        max_stack = 1,
        copy = { 769, 779, 780, 9754, 9908, 26997 },

        -- Effects:
        -- [x] Rank 769 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 20, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 779 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 780 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 13, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9754 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 40, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9908 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 59, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26997 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 83, addl_points: 1, points_per_level: 0, sp_bonus: 1, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "swipe" ) end
        end,

        proc_chance = 100,
    },

-- Teleport: Moonglade - Teleports the caster to the Moonglade.
    teleport_moonglade = {
        id = 18960,
        cast = 10,
        gcd = "spell",
        school = "arcane",
        texture = 135758,
        spend = 120,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [ ] Rank 18960 #0 -- effect: TELEPORT_UNITS, aura: NONE, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: TARGET_DEST_DB, mechanic: 0
    },

-- Thorns - Thorns sprout from the friendly target causing 3-25 Nature damage to attackers when hit. Lasts 600 sec.
    thorns = {
        id = 467,
        cast = 0,
        duration = 600,
        gcd = "spell",
        school = "nature",
        texture = 136104,
        range = 30,
        spend = 35,
        spendType = "Mana",
        max_stack = 1,
        copy = { 467, 782, 1075, 8914, 9756, 9910, 26992 },

        -- Effects:
        -- [x] Rank 467 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 2, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 782 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 5, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 1075 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 8, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8914 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 11, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9756 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 14, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9910 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 17, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26992 #0 -- effect: APPLY_AURA, aura: DAMAGE_SHIELD, points: 24, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_TARGET_ALLY, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "thorns" )
        end,
    },

-- Tiger's Fury - Increases damage done by 10/20/30/40 for 6 sec.
    tigers_fury = {
        id = 5217,
        cast = 0,
        duration = 6,
        cooldown = 1,
        school = "physical",
        texture = 132242,
        spend = 30,
        spendType = "Energy",
        max_stack = 1,
        copy = { 5217, 6793, 9845, 9846 },

        -- Effects:
        -- [x] Rank 5217 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 9, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 6793 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 19, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9845 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 29, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 9846 #0 -- effect: APPLY_AURA, aura: MOD_DAMAGE_DONE, points: 39, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "tigers_fury" )
        end,
    },

-- Track Humanoids - Shows the location of all nearby humanoids on the minimap. Only one type of thing can be tracked at a time.
    track_humanoids = {
        id = 5225,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132328,
        spendType = "Energy",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 5225 #0 -- effect: APPLY_AURA, aura: TRACK_CREATURES, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            applyBuff( "track_humanoids" )
        end,
    },

-- Tranquility - Heals all nearby group members for 351/515/765/1097/1518 every $t2 seconds for 8 sec. Druid must channel to maintain the spell.
    tranquility = {
        id = 740,
        cast = 0,
        duration = 8,
        category_cooldown = 600,
        gcd = "spell",
        school = "nature",
        texture = 136107,
        cooldown_category_id = 46,
        cooldown_category = "Healing (Group) - Spell",
        spend = 525,
        spendType = "Mana",
        max_stack = 1,
        copy = { 740, 8918, 9862, 9863, 26983 },

        -- Effects:
        -- [ ] Rank 740 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DUMMY, points: 350, addl_points: 1, points_per_level: 2.2, sp_bonus: 0.286, radius_idx: 10, target: TARGET_DEST_DYNOBJ_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 740 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44203
        -- [ ] Rank 8918 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DUMMY, points: 514, addl_points: 1, points_per_level: 2.6, sp_bonus: 0.286, radius_idx: 10, target: TARGET_DEST_DYNOBJ_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 8918 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44205
        -- [ ] Rank 9862 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DUMMY, points: 764, addl_points: 1, points_per_level: 3.4, sp_bonus: 0.286, radius_idx: 10, target: TARGET_DEST_DYNOBJ_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9862 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44206
        -- [ ] Rank 9863 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DUMMY, points: 1096, addl_points: 1, points_per_level: 3.7, sp_bonus: 0.286, radius_idx: 10, target: TARGET_DEST_DYNOBJ_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 9863 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44207
        -- [ ] Rank 26983 #0 -- effect: APPLY_AREA_AURA_PARTY, aura: DUMMY, points: 1517, addl_points: 1, points_per_level: 4.5, sp_bonus: 0.286, radius_idx: 10, target: TARGET_DEST_DYNOBJ_ALLY, target2: NONE, mechanic: 0
        -- [x] Rank 26983 #1 -- effect: APPLY_AURA, aura: PERIODIC_TRIGGER_SPELL, points: 0, addl_points: 0, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0, trigger_spell_id: 44208

        radius = 30,

        channeled = true,

        handler = function ()
            applyBuff( "tranquility" )
        end,

        proc_chance = 100,
    },

-- Travel Form - Shapeshift into travel form, increasing movement speed by 40%. Also protects the caster from Polymorph effects. Only useable outdoors. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    travel_form = {
        id = 783,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132144,
        spend_pct = 13,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 783 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 783 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "travel_form" )
        end,

        proc_chance = 100,
    },

-- Tree of Life - Shapeshift into the Tree of Life. While in this form you increase healing received by 25% of your total Spirit for all party members within 45 yards, your movement speed is reduced by 20%, and you can only cast Swiftmend, Innervate, Nature's Swiftness, Rebirth, Barkskin, poison removing and healing over time spells, but the mana cost of these spells is reduced by 20%. The act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.
    tree_of_life = {
        id = 33891,
        cast = 0,
        gcd = "spell",
        school = "physical",
        texture = 132145,
        spend_pct = 28,
        spendType = "Mana",
        max_stack = 1,

        -- Effects:
        -- [x] Rank 33891 #0 -- effect: APPLY_AURA, aura: MOD_SHAPESHIFT, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0
        -- [x] Rank 33891 #1 -- effect: APPLY_AURA, aura: MECHANIC_IMMUNITY, points: -1, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        handler = function ()
            clear_druid_forms()
            applyBuff( "tree_of_life" )
        end,

        proc_chance = 100,
        proc_type_mask = { 174624, 0 },
        -- Proc type flags: mask0: Take Melee Ability; Take Ranged Ability; Take Helpful Ability; Take Harmful Ability; Take Helpful Spell; Take Harmful Spell

        -- Related talents:
        -- talent_0 [0]
    },

-- Wonderheal XT40 Shades
    wonderheal_xt40_shades = {
        id = 41318,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 41318 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Wonderheal XT68 Shades
    wonderheal_xt68_shades = {
        id = 46106,
        cast = 50,
        texture = 136243,
        max_stack = 1,

        -- Effects:
        -- [x] Rank 46106 #0 -- effect: CREATE_ITEM, aura: NONE, points: 0, addl_points: 1, points_per_level: 0, sp_bonus: 0, radius_idx: 0, target: TARGET_UNIT_CASTER, target2: NONE, mechanic: 0

        proc_chance = 100,
    },

-- Wrath - Causes 12-381 Nature damage to the target.
    wrath = {
        id = 5176,
        cast = 1.5,
        gcd = "spell",
        school = "nature",
        texture = 136006,
        range = 30,
        spend = 20,
        spendType = "Mana",
        max_stack = 1,
        copy = { 5176, 5177, 5178, 5179, 5180, 6780, 8905, 9912, 26984, 26985 },

        -- Effects:
        -- [x] Rank 5176 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 11, addl_points: 3, points_per_level: 0.4, sp_bonus: 0.123, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5177 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 24, addl_points: 5, points_per_level: 0.6, sp_bonus: 0.231, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5178 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 43, addl_points: 9, points_per_level: 0.8, sp_bonus: 0.443, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5179 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 62, addl_points: 11, points_per_level: 1, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 5180 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 100, addl_points: 15, points_per_level: 1.3, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 6780 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 138, addl_points: 19, points_per_level: 1.6, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 8905 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 187, addl_points: 23, points_per_level: 1.8, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 9912 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 235, addl_points: 29, points_per_level: 2.1, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26984 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 277, addl_points: 35, points_per_level: 2.4, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        -- [x] Rank 26985 #0 -- effect: SCHOOL_DAMAGE, aura: NONE, points: 380, addl_points: 49, points_per_level: 2.7, sp_bonus: 0.571, radius_idx: 0, target: TARGET_UNIT_TARGET_ENEMY, target2: NONE, mechanic: 0
        startsCombat = true,

        handler = function ()
            if type( trackSchoolDamage ) == "function" then trackSchoolDamage( "wrath" ) end
        end,

        proc_chance = 100,
    },

} )

spec:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED", function()
    if not is_bear_form_active() then return end

    local _, subtype, _, sourceGUID, _, _, _, destGUID, _, _, _, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10 = CombatLogGetCurrentEventInfo()

    if sourceGUID == state.GUID then
        if subtype == "SWING_DAMAGE" then
            local maul_queued = state.buff.maul_queue.up

            if maul_queued then
                removeBuff( "maul_queue" )
                return
            end

            gain_bear_auto_attack_rage( a1, a10, a7 )
            return
        end

        if subtype == "SWING_MISSED" and state.buff.maul_queue.up then
            removeBuff( "maul_queue" )
            return
        end

        if ( subtype == "SPELL_DAMAGE" or subtype == "SPELL_MISSED" ) and MAUL_SPELL_IDS[ a1 or 0 ] then
            removeBuff( "maul_queue" )
            return
        end
    end

    if destGUID ~= state.GUID then return end

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
        gain_bear_damage_taken_rage( damage )
        add_passive_rage_damage_event( damage )
    end
end )

-- Resources
spec:RegisterResource( "combo_points" )
spec:RegisterResource( "energy" )
spec:RegisterResource( "mana" )
spec:RegisterResource( "rage", {
    bear_mainhand_swing = {
        resource = "rage",
        swing = "mainhand",
        last = function () return get_swing_forecast_last( "mainhand" ) end,
        interval = function () return state.swings.mainhand_speed or 0 end,
        value = function () return get_bear_forecast_rage_per_swing() end,
    },

    bear_offhand_swing = {
        resource = "rage",
        swing = "offhand",
        last = function () return get_swing_forecast_last( "offhand" ) end,
        interval = function () return state.swings.offhand_speed or 0 end,
        value = function () return get_bear_forecast_rage_per_swing( true ) end,
    },

    bear_incoming_damage = {
        resource = "rage",
        setting = "passive_rage_prediction",
        last = function () return state.now + state.offset - 1 end,
        interval = 1,
        value = function () return get_bear_passive_incoming_rage_per_second() end,
    },
} )

if spec.RegisterRanges then
    spec:RegisterRanges( "ferocious_bite", "lacerate", "pounce_bleed", "rake", "rip", "swipe" )
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

    package = "Feral\ DPS\ \(IV\)",
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
    name = "|T132276:0|t Passive Rage Prediction",
    desc = "When enabled, rage forecasting includes average incoming damage over the last 10 seconds.",
    width = "full",
} )

spec:RegisterSetting( "show_energy_ticks", false, {
    type = "toggle",
    name = "|T136018:0|t Show Energy Ticks",
    desc = "Print detected passive energy ticks in chat for debugging.",
    width = "full",
} )

-- WoWSims: Balance
spec:RegisterSetting( "balance_use_faerie_fire", true, {
    type = "toggle",
    name = "WoWSims Balance: Use Faerie Fire",
    desc = "When enabled, the WoWSims Balance priority keeps Faerie Fire active.",
    width = "full",
} )

spec:RegisterSetting( "balance_use_hurricane", false, {
    type = "toggle",
    name = "WoWSims Balance: Use Hurricane",
    desc = "When enabled, the WoWSims Balance priority can cast Hurricane.",
    width = "full",
} )

spec:RegisterSetting( "balance_use_insect_swarm", false, {
    type = "toggle",
    name = "WoWSims Balance: Use Insect Swarm",
    desc = "When enabled, the WoWSims Balance priority applies Insect Swarm.",
    width = "full",
} )

spec:RegisterSetting( "balance_use_moonfire", true, {
    type = "toggle",
    name = "WoWSims Balance: Use Moonfire",
    desc = "When enabled, the WoWSims Balance priority applies Moonfire.",
    width = "full",
} )

spec:RegisterSetting( "balance_primary_wrath", false, {
    type = "toggle",
    name = "WoWSims Balance: Primary Wrath",
    desc = "When enabled, the WoWSims Balance priority uses Wrath as its primary filler.",
    width = "full",
} )

-- WoWSims: Feral DPS
spec:RegisterSetting( "feral_rip_end_thresh", 10, {
    type = "range",
    name = "WoWSims Feral: Rip End Threshold",
    desc = "Sets the time-to-die and Rip-remains threshold used for Rip/Bite decisions.",
    width = "full",
    min = 0,
    max = 60,
    step = 1,
} )

spec:RegisterSetting( "feral_max_wait_time", 1, {
    type = "range",
    name = "WoWSims Feral: Max Wait Time",
    desc = "Maximum wait time value used by the WoWSims Feral profile.",
    width = "full",
    min = 0,
    max = 10,
    step = 1,
} )

spec:RegisterSetting( "feral_bite_trick_max", 39, {
    type = "range",
    name = "WoWSims Feral: Bite Trick Max Energy",
    desc = "Maximum energy threshold used for bite trick logic in the WoWSims Feral profile.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "feral_rip_trick_min", 52, {
    type = "range",
    name = "WoWSims Feral: Rip Trick Min Energy",
    desc = "Minimum energy threshold used for rip trick logic in the WoWSims Feral profile.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "feral_bite_trick_cp", 2, {
    type = "range",
    name = "WoWSims Feral: Bite Trick Combo Points",
    desc = "Combo point threshold used for bite trick logic in the WoWSims Feral profile.",
    width = "full",
    min = 0,
    max = 5,
    step = 1,
} )

-- WoWSims: Feral Tank
spec:RegisterSetting( "tank_maul_rage_threshold", 50, {
    type = "range",
    name = "WoWSims Tank: Maul Rage Threshold",
    desc = "Minimum rage required before the WoWSims Feral Tank profile recommends Maul.",
    width = "full",
    min = 0,
    max = 100,
    step = 1,
} )

spec:RegisterSetting( "tank_swipe_ap_threshold", 2700, {
    type = "range",
    name = "WoWSims Tank: Swipe Attack Power Threshold",
    desc = "Minimum attack power required before the WoWSims Feral Tank profile recommends Swipe in its AP check.",
    width = "full",
    min = 0,
    max = 10000,
    step = 50,
} )

-- Pets (Hekili-style scaffold)
spec:RegisterPet( "treants", 33831, "force_of_nature", 30 )

spec:RegisterPack( "Balance", 20260313, [[Hekili:vwvtVTnpm4Fl9sXgwF9YhRD4DR9sXoS0dDhC36HHklzB6yIylzijVSCr)2hLDCSAqs2ccqGef5ZJi1dPztzpXIZfwG94SjZUzY8PZJMmz(KjFKfB30aS4gr2kXsAHuut)FVOsiZ6SVPsjY9XBuTAVPNvphJ1gwCAlwzxizPha7z))1tPqAGm2JtPvLyEo07kyY2rGJ)fDlM74nAuPr7ghVqPD8VcRWkKOxRkWkIurMfvstuJgYu1Pc77U791kLCfktOiQVclUlTTOik0yuUAT09WbJvOxLOksSLqYASkFm(9o4eyylvAPzxK9B36)Uii)keGgHKcudENnG1IYLMO0(AqsRHoC0NlZHo8cmfPHAbkn3ope3YwTgZeYJJ6opcdJWbYSjM1I(Y2bJm0PlVixzJcTezXmQiVmewFH)KP4Gd9WnS7qqTwlSLhehsMqpqBs68imeJvO9WXI)fOnKXDQXjSy6kl9WWIFQenEXwNQYX9BQrJXZp3020O02TkWLGKk)zoUvJYvG1e54o(cBFqDQGAqMdK21wkiZar8MqHmkZQAj1oDesQj9Nivb))C8F(Dd4rcQnVCLJVUeZkd9wi3mYQJlvEW)DtfMH2QrCZ9R8KdJK(zhNU7BP5PEiC8PV4bnp00SaMjvEvqgTfs7GRDvJotY26uq7j2urVGUhwu7lyEdZig6ElC8k04lwpWI7w1n5bkeTvwA5JDtIaPiTcYz3ZIZORnvNf0SI)sBHJFPJF8wdh)whF(WGcwCGlmljgopE314mc4OjcU5NhCH9oD5XfuQCKEQrgdp1t6hopsh6WcjC)UUrYgoXt01)7e9QgYr063sqDJhQbRJnPJGBPFX7MQEAjYHhW)6Cy4Ot)OF8r9bOT3XN(DF)pbmItVXUeLs1uHbY)Mm4lGVzXpEl5DR3pwCCBdOLTM(ay)5p]] )
spec:RegisterPack( "Feral", 20260322, [[Hekili:1IvBVTTnq4Fl9lUjnPAwYXDBD2gyfdBl5dzatzOFyOsIwIYIisKAKuXnag63(oQxIKLjLTt3(sGm19YZ9ChV7I8S9EWZncjXE37m15dtN54yzpZ(g75EUYNZXEU5OWhrBGhOOm4V)kMJsvN(CkdfP0wWk4HWB(m7ZUKmHN76csQ8wQ3A9w2bujhh6DVTTNBcjkcxlkwe2y(YGFHxqIkdY5egNiFUmiMXld(D8JKuc4ColMKcUefkjmQWkNJdzzRrYRw(DHiPpiD21K4LRlIJTApWkITLwENoDYq8h9zX(YeS)wsA0l6o8fJydzcJtfVOz9pBK)fnoD8bsgJWCc2pMWH)O4fLkr4kLo4DwCCgIqflM13epH4e06u81QK3srcjwIJUMLVuGLx)ekTaVmdrrwHfCoMkxuRzhKGefnQVb5KCfkATRvJjNOObMFoJqLIwRTA58jVjIjTaLSKKWhj0ntUatX8np3jZSP72vZdPyepejKGywf5xorI4BWsqZmSVK5hrWRu4w9EHvvq7dw2hqiKF4yrsFGcH1MuSpejAXBdnwl1lCNT18dbydN0zWAwXaQ3lbI5SqcRq4VMiXNfVDinn)eCOaOHiT(5a7DJZjyVMS9jNC)MYyhYwgjNd9ZIrDZUDxmeQT)Un1pQ(xEK0QjGEGt1v1TAPQS7W8T5QzJfVMvzO5DENHY637mDaww44CLbHBLSnrKH(6IL2ARi1vRPvWdlup9O60H5kBt9KX)tbjphhzTLLglsWOi)eCA2qsze67SkTM0V)7lrG5gWVcOAp9uCIN7tyUaoVDET9mp3TiovbDy6(p)N3F79)2hldkdEibxgqYYzCzZK53gHJrfPY3wgWvOcYLLbcwgihQqYYG1aGdcta2clSkVRYcXS0u2wW8kH4irzWwmhoVqOeMqldKkXQrBzqkraUBDHSvokRY9f09KoksjmS4bAnsG)im8n49GR7v5PMh)qcrO2VOArcqD4hzeHOcmII8EH2gfBscbZZj0hXWfCffCRSwPQfaYa6tbzzccogd84Z93DHqdtlG1BGxramYBX0F)xcSYs4mXxUgcQesysFPr0N78At4I)AEkjKit7SB)OV1P)uzaG9g38qTjkdS)IYOr9pYPNNHfCs7frnMu2kAfBuDeTiBnUofNc16L3DBvTG6aN9ZxQCTNB1tvlAwxLapEF1INyQAivK3N8Cdbyd8msT(4WLIAx0dKQ5ypjuLA0chBhPYGfLbZ6S6bcQm)SbMNLd7TILDA1oJv9eSiLNB)lzvUW09me3VEz6MPZk3DJXOz4S8YGjq9SMjoLbRwwgmV69VbUcS)WNQJVaQG2R5qToZMwgSBN6YLMM0bxwP6HZCR1D0UBDSfCUkmNFEHP2jDvCRAA3irKH2ZJgMDGTtnfM)W5H5JLAmLdMFIGB)1pua87ppaAaaWG2tdavJQv(9hm63JXbgkp)VPg7hF1W6c9qyXrqqnVDH(yAW2aNI1U8i5B7PV6iulc1FjtPu7Tm9fSJIrZn4h9sTPlH2MB3RdCqT87gPlamw0zQ2idqHdO8vJOCNw9wOe0uXxgH)WXjdN3T)9nnx2SnpHq)TzD2WC73ZQjQbgy1yeG5UOgwJ1u65esQVI7CGw7p)UhbmCaUUTrSn3e(mJp7PFZOrQ(gznFAQ)Vx2Y83jRFPW(Vw3(vdSyVVFwNDQpSkaHquTFF0Fah)jukIQ(eKW)RbiHN7TqpCAeftle1s79V)]] )
spec:RegisterPack( "Tank", 20260313, [[Hekili:9w1sVTnoq4)n5Y2vRFeNwSBSpuuu04dPhukYHfHIusJIimfPajv969a)T3Hu2w0X2Xn9qViqnp((goVizm5bsAjZcK7NmAYnJMoEAYi87SjKu7MwGK2YkwXEgpizn43hyYvEHBekwP3zJQtxGkEu9ykVXqsZ74c7Dss(jb(6zOlTqb5(XJjP18YsO3uWu0JUJ(jDhV0rB1CLMB34OvkTJ(fyfxWrU1QkUazKvy5kPjPvdfQMCM9pM)xLCnKLdmDg6tZ74vZZ7QQsouCsPAT0T8u(3W0RYuvz2AiBnxuUhHxQ4vWWwR0sZEp7)9vShKAmb7wUx7V29a9sWkanMZ92xcbp2jkXyXc58zxvQSdc1qdJln3oozwmovmqZHSkpBvOLIiaps3EqMEWfaAuOs()ZLpNPvmDeehPBpetIHOHjFw0FDJfBwZBFZ3WftVIz96ZAvRb9I5gWAr6njwSLllGzgRflVAWuReLNlT6lvjfDAniTlM3Btui0cYYdVdDIJD7qY92K5nyGDs63bTbXy)0Zis6AMw69chtQ5g)8ryqWr9)0WnguPJA6ABvA72HMNbjwUkCuRMlxbwtIJ6O3z7Dk0e2GHmGJB2AgkgqI3ep7XLfIoC6evXXMF9FJnQ0)0r)3VzapsqJ5P35ORR5f1XwZKBgy1rLkp4)xRGxWTIbCl9N8KddK(pokg7BP5HEiC0Xp5bTmw0KiMXHsr0nAlK2DMgYgbrYUMCq7j2iWof3Y7A8jmVGjidHsNJk4gFYAjjnCkSMeQWkLfpEFyTjiz5cOK8rsAbg2yEM53(D6X0DRRqyoqjXIL4ZI2jBXD05o6mh9kh9uT6o6TyYkz2aJ7SWZ10lX1zNVd4oDa1Jm0d)1xc(Zo7hGFsuA6Lg6HFMh(DweTFiMt0SBUuu8gtOlWlEqD8oeum62L2JmeUbD(O79Nn6I3s0d)jxWC6k7hEdW(tSaAil35RSw)dVBFZ635eW5F8noepu9R3N)YhLhWPx4(24DI7FF(WwSqcjNzGYVIw85q7FkRZJajnTRf0YoJjyg5h)]] )


spec:RegisterPackSelector( "balance", "Balance", "|T136096:0|t Balance",
    "If you have spent more points in |T136096:0|t Balance than in any other tree, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "feral_dps", "Feral", "|T132115:0|t Feral DPS",
    "If you have spent more points in |T132276:0|t Feral than in any other tree and have not taken Thick Hide, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 ) and talent.thick_hide.rank == 0
    end )

spec:RegisterPackSelector( "feral_tank", "Tank", "|T132276:0|t Feral Tank",
    "If you have spent more points in |T132276:0|t Feral than in any other tree and have taken Thick Hide, this priority will be automatically selected for you.",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 ) and talent.thick_hide.rank > 0
    end )

