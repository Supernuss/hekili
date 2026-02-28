if UnitClassBase( 'player' ) ~= 'SHAMAN' then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local spec = Hekili:NewSpecialization( 7 )

local LastConsumedStackTS, LastSwingTimestamp, last_consumed_stack_ts = 0,0,0
spec:RegisterResource( Enum.PowerType.Mana, {
    mainhand = {
        swing = "mainhand",
        aura = "flurry",

        last = function ()
            local swing = state.combat == 0 and state.now or state.swings.mainhand
            local t = state.query_time

            return swing + ( floor( ( t - swing ) / state.swings.mainhand_speed ) * state.swings.mainhand_speed )
        end,

        interval = "mainhand_speed",

        stop = function () return state.swings.mainhand == 0 end,
        value = function( now )
            local secsSinceLastConsume = now - last_consumed_stack_ts
            if secsSinceLastConsume >= 0.5 and state.buff.flurry.stack > 0 then
                state.removeStack("flurry")
            end
            return 0
        end,
    },

    offhand = {
        swing = "offhand",
        aura = "flurry",

        last = function ()
            local swing = state.combat == 0 and state.now or state.swings.offhand
            local t = state.query_time

            return swing + ( floor( ( t - swing ) / state.swings.offhand_speed ) * state.swings.offhand_speed )
        end,

        interval = "offhand_speed",

        stop = function () return state.swings.offhand == 0 end,
        value = function( now )
            local secsSinceLastConsume = now - last_consumed_stack_ts
            if secsSinceLastConsume >= 0.5 and state.buff.flurry.stack > 0  then
                state.removeStack("flurry")
            end
            return 0
        end,
    }
} )

-- Talents
spec:RegisterTalents( {
    ancestral_healing         = {   581, 3, 16176, 16235, 16240 },
    ancestral_knowledge       = {   614, 5, 17485, 17486, 17487, 17488, 17489 },
    anticipation              = {   601, 5, 16254, 16271, 16272, 16273, 16274 },
    call_of_flame             = {   561, 3, 16038, 16160, 16161 },
    call_of_thunder           = {   562, 5, 16041, 16117, 16118, 16119, 16120 },
    concussion                = {   563, 5, 16035, 16105, 16106, 16107, 16108 },
    convection                = {   564, 5, 16039, 16109, 16110, 16111, 16112 },
    dual_wield                = {  1690, 1, 30798 },
    dual_wield_specialization = {  1692, 3, 30816, 30818, 30819 },
    earth_shield              = {  1698, 1,   974 },
    earths_grasp              = {   572, 2, 16043, 16130 },
    elemental_devastation     = {  1645, 3, 30160, 29179, 29180 },
    elemental_focus           = {   574, 1, 16164 },
    elemental_fury            = {   565, 1, 16089 },
    elemental_mastery         = {   573, 1, 16166 },
    elemental_precision       = {  1685, 3, 30672, 30673, 30674 },
    elemental_reach           = {  1641, 2, 28999, 29000 },
    elemental_shields         = {  1683, 3, 30669, 30670, 30671 },
    elemental_warding         = {  1640, 3, 28996, 28997, 28998 },
    elemental_weapons         = {   611, 3, 16266, 29079, 29080 },
    enhancing_totems          = {   610, 2, 16259, 16295 },
    eye_of_the_storm          = {  1642, 3, 29062, 29064, 29065 },
    flurry                    = {   602, 5, 16256, 16281, 16282, 16283, 16284 },
    focused_mind              = {  1695, 3, 30864, 30865, 30866 },
    guardian_totems           = {   609, 2, 16258, 16293 },
    healing_focus             = {   587, 5, 16181, 16230, 16232, 16233, 16234 },
    healing_grace             = {  1646, 3, 29187, 29189, 29191 },
    healing_way               = {  1648, 3, 29206, 29205, 29202 },
    improved_chain_heal       = {  1697, 2, 30872, 30873 },
    improved_fire_nova        = {   567, 2, 16086, 16544 },
    improved_ghost_wolf       = {   605, 2, 16262, 16287 },
    improved_healing_wave     = {   586, 5, 16182, 16226, 16227, 16228, 16229 },
    improved_reincarnation    = {   589, 2, 16184, 16209 },
    improved_shields          = {   607, 3, 16261, 16290, 16291 },
    shield_specialization     = {   612, 5, 16253, 16298, 16299, 16300, 16301 },
    natures_guidance          = {   583, 3, 16180, 16196, 16198 },
    improved_windfury_totem   = {  1647, 2, 29192, 29193 },
    lightning_mastery         = {   721, 5, 16578, 16579, 16580, 16581, 16582 },
    lightning_overload        = {  1686, 5, 30675, 30678, 30679, 30680, 30681 },
    mana_tide_totem           = {   590, 1, 16190 },
    mental_quickness          = {  1691, 3, 30812, 30813, 30814 },
    natures_blessing          = {  1696, 3, 30867, 30868, 30869 },
    natures_guardian          = {  1699, 5, 30881, 30883, 30884, 30885, 30886 },
    natures_swiftness         = {   591, 1, 16188 },
    purification              = {   592, 5, 16178, 16210, 16211, 16212, 16213 },
    restorative_totems        = {   588, 5, 16187, 16205, 16206, 16207, 16208 },
    reverberation             = {   575, 5, 16040, 16113, 16114, 16115, 16116 },
    shamanistic_focus         = {   617, 1, 43338 },
    shamanistic_rage          = {  1693, 1, 30823 },
    spirit_weapons            = {   616, 1, 16268 },
    stormstrike               = {   901, 1, 17364 },
    thundering_strikes        = {   613, 5, 16255, 16302, 16303, 16304, 16305 },
    tidal_focus               = {   593, 5, 16179, 16214, 16215, 16216, 16217 },
    tidal_mastery             = {   594, 5, 16194, 16218, 16219, 16220, 16221 },
    totem_of_wrath            = {  1687, 1, 30706 },
    totemic_focus             = {   595, 5, 16173, 16222, 16223, 16224, 16225 },
    totemic_mastery           = {   582, 1, 16189 },
    toughness                 = {   615, 5, 16252, 16306, 16307, 16308, 16309 },
    unleashed_rage            = {  1689, 5, 30802, 30808, 30809, 30810, 30811 },
    unrelenting_storm         = {  1682, 5, 30664, 30665, 30666, 30667, 30668 },
    weapon_mastery            = {  1643, 5, 29082, 29084, 29086, 29087, 29088 },
} )


-- Auras
spec:RegisterAuras( {
    -- Reduces physical damage taken by $s1%.
    ancestral_fortitude = {
        id = 16237,
        duration = 15,
        max_stack = 1,
        copy = { 16177, 16236, 16237 },
    },
    -- Enable Cleanse Toxins.
    can_cure_toxins = {
        alias = { "dispellable_poison" },
        aliasMode = "first",
        aliasType = "buff",
    },
    can_cure_disease = {
        alias = { "dispellable_disease" },
        aliasMode = "first",
        aliasType = "buff",
    },
    -- Your next $n damage or healing spells have their mana cost reduced by $s1%.
    clearcasting = {
        id = 16246,
        duration = 15,
        max_stack = 2,
    },
    -- Reduces casting or channeling time lost when damaged by $s2% and attacks heal the shielded target for $s1.
    earth_shield = {
        id = 32594,
        duration = 600,
        max_stack = 6,
        copy = { 974, 32593, 32594 },
    },
    -- Interrupts spellcasting in that school for $d.
    earth_shock = {
        id = 25454,
        duration = 2,
        max_stack = 1,
        copy = { 8042, 8044, 8045, 8046, 10412, 10413, 10414, 25454 },
    },
    -- Increases your chance to get a critical strike with melee attacks by $s1%.
    elemental_devastation = {
        id = 30165,
        duration = 10,
        max_stack = 1,
        copy = { 29177, 29178, 30165 },
    },
    -- Makes LB, CL, LvB instant.
    elemental_mastery = {
        id = 16166,
        duration = 30,
        max_stack = 1,
    },
    -- Cannot move while using Farsight.
    far_sight = {
        id = 6196,
        duration = 60,
        max_stack = 1,
    },
    -- $s2 Fire damage every $t2 seconds.
    flame_shock = {
        id = 25457,
        duration = 12,
        max_stack = 1,
        copy = { 8050, 8052, 8053, 10447, 10448, 25457, 29228 },
    },
    flurry = { -- TODO: Check Aura (https://wowhead.com/wotlk/spell=16284)
        id = 16284,
        duration = 3600,
        max_stack = 1,
        copy = { 16284, 16283, 16282, 16281, 16280, 16279, 16278, 16277, 16257, 16256 },
    },
    -- Movement slowed to $s1% of normal speed.
    frost_shock = {
        id = 25464,
        duration = function() return glyph.frost_shock.enabled and 10 or 8 end,
        max_stack = 1,
        copy = { 8056, 8058, 10472, 10473, 25464 },
    },
    -- Increases movement speed by $s2%$?s59289[ and regenerates $59289s1% of your maximum health every 5 sec][].  Effects that reduce movement speed may not bring you below your normal movement speed.
    ghost_wolf = {
        id = 2645,
        duration = 3600,
        max_stack = 1,
    },
    grounding_totem_effect = {
        id = 8178,
        duration = 3600,
        max_stack = 1,
    },
    -- Causes $49279s1 Nature damage to attacker on hit.  $n charges.
    lightning_shield = {
        id = 25472,
        duration = 600,
        max_stack = 3,
        copy = { 324, 325, 905, 945, 8134, 8788, 10431, 10432, 25469, 25472 },
    },
    -- Your next Nature spell with a casting time less than 10 secs will be an instant cast spell.
    natures_swiftness = {
        id = 16188,
        duration = 3600,
        max_stack = 1,
    },
    -- All damage taken reduced by $s2% and successful melee attacks have a chance to regenerate mana equal to $s1% of your attack power.
    shamanistic_rage = {
        id = 30823,
        duration = 15,
        max_stack = 1,
    },
    -- Any elemental shield is applied.
    shield = {
        alias = { "lightning_shield", "earth_shield", "water_shield" },
        aliasMode = "first",
        aliasType = "buff",
    },
    -- Increases Nature damage taken from the Shaman by $s1%.
    stormstrike = {
        id = 17364,
        duration = 12,
        max_stack = 2,
    },
    -- Attack power party buff.
    unleashed_rage = {
        id = 30807,
        duration = 10,
        max_stack = 1,
        copy = { 30803, 30804, 30805, 30806, 30807 },
    },
    -- Able to breathe underwater.
    water_breathing = {
        id = 131,
        duration = 600,
        max_stack = 1,
    },
    -- $s2 mana per 5 sec.  Attacks and spells used against you restore $57961s1 mana.  $n charges.
    water_shield = {
        id = 33736,
        duration = 600,
        max_stack = function() return glyph.water_shield.enabled and 4 or 3 end,
        copy = { 23575, 24398, 33736, 33737 },
    },
    -- Allows walking over water.
    water_walking = {
        id = 546,
        duration = 600,
        max_stack = 1,
    },

    -- Totems.
    earthbind_totem = {
        duration = 45,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136102 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    earth_elemental_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136024 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    stoneclaw_totem = {
        duration = 15,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136097 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    stoneskin_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136098 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    strength_of_earth_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136023 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    tremor_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 2 )

            if up and texture == 136108 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    earth_totem = {
        alias = { "earthbind_totem", "stoneclaw_totem", "stoneskin_totem", "strength_of_earth_totem", "earth_elemental_totem", "tremor_totem" },
        aliasMode = "first",
        aliasType = "buff",
    },

    flametongue_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 136040 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    magma_totem = {
        duration = 20,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135826 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    searing_totem = {
        duration = 50,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135825 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    frost_resistance_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135866 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    fire_elemental_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135790 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    fire_nova_totem = {
        duration = 5,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135824 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    totem_of_wrath = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 1 )

            if up and texture == 135829 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    fire_totem = {
        alias = { "flametongue_totem", "magma_totem", "searing_totem", "frost_resistance_totem", "fire_elemental_totem", "fire_nova_totem", "totem_of_wrath" },
        aliasMode = "first",
        aliasType = "buff",
    },

    fire_resistance_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 135832 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    cleansing_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 136019 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    poison_cleansing_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 136070 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    healing_stream_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 135127 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    mana_spring_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 136053 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    mana_tide_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 3 )

            if up and texture == 135861 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    water_totem = {
        alias = { "fire_resistance_totem", "cleansing_totem", "poison_cleansing_totem", "healing_stream_totem", "mana_spring_totem", "mana_tide_totem" },
        aliasMode = "first",
        aliasType = "buff",
    },

    grounding_totem = {
        duration = 45,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136039 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    nature_resistance_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136061 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    grace_of_air_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136046 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    tranquil_air_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136013 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    sentry_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136082 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    windfury_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136114 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    wrath_of_air_totem = {
        duration = 300,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136092 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    windwall_totem = {
        duration = 120,
        max_stack = 1,
        generate = function( t )
            local up, name, start, duration, texture = GetTotemInfo( 4 )

            if up and texture == 136022 then
                t.count = 1
                t.expires = start + duration
                t.applied = start
                t.caster = "player"
                return
            end

            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end,
    },
    air_totem = {
        alias = { "grounding_totem", "nature_resistance_totem", "grace_of_air_totem", "tranquil_air_totem", "sentry_totem", "windfury_totem", "wrath_of_air_totem", "windwall_totem" },
        aliasMode = "first",
        aliasType = "buff",
    },
} )


-- Glyphs
spec:RegisterGlyphs( {
    [58058] = "astral_recall",
    [55437] = "chain_heal",
    [55449] = "chain_lightning",
    [63279] = "earth_shield",
    [55452] = "elemental_mastery",
    [55455] = "fire_elemental_totem",
    [55450] = "fire_nova",
    [55447] = "flame_shock",
    [55451] = "flametongue_weapon",
    [55443] = "frost_shock",
    [59289] = "ghost_wolf",
    [55456] = "healing_stream_totem",
    [55440] = "healing_wave",
    [55454] = "lava",
    [55438] = "lesser_healing_wave",
    [55453] = "lightning_bolt",
    [55448] = "lightning_shield",
    [55441] = "mana_tide",
    [58059] = "renewed_life",
    [55442] = "shocking",
    [63298] = "stoneclaw_totem",
    [55446] = "stormstrike",
    [58135] = "arctic_wolf",
    [58134] = "black_wolf",
    [63280] = "totem_of_wrath",
    [58055] = "water_breathing",
    [55436] = "water_mastery",
    [58063] = "water_shield",
    [58057] = "water_walking",
    [55445] = "windfury_weapon",
} )


spec:RegisterStateExpr( "windfury_mainhand", function () return false end )
spec:RegisterStateExpr( "windfury_offhand", function () return false end )
spec:RegisterStateExpr( "flametongue_mainhand", function () return false end )
spec:RegisterStateExpr( "flametongue_offhand", function () return false end )
spec:RegisterStateExpr( "frostbrand_mainhand", function () return false end )
spec:RegisterStateExpr( "frostbrand_offhand", function () return false end )
spec:RegisterStateExpr( "rockbiter_mainhand", function () return false end )
spec:RegisterStateExpr( "rockbiter_offhand", function () return false end )
spec:RegisterStateExpr( "mainhand_imbued", function () return false end )
spec:RegisterStateExpr( "offhand_imbued", function () return false end )

local GetWeaponEnchantInfo = _G.GetWeaponEnchantInfo

local enchant_ids = {
    [283]  = "windfury",
    [284]  = "windfury",
    [525]  = "windfury",
    [1669] = "windfury",
    [2636] = "windfury",
    [5]    = "flametongue",
    [4]    = "flametongue",
    [3]    = "flametongue",
    [523]  = "flametongue",
    [1665] = "flametongue",
    [1666] = "flametongue",
    [2634] = "flametongue",
    [2]    = "frostbrand",
    [12]   = "frostbrand",
    [524]  = "frostbrand",
    [1667] = "frostbrand",
    [1668] = "frostbrand",
    [2635] = "frostbrand",
    [3023] = "rockbiter",
    [3026] = "rockbiter",
    [3028] = "rockbiter",
    [3031] = "rockbiter",
    [3034] = "rockbiter",
    [3037] = "rockbiter",
    [3040] = "rockbiter", -- ???
    [3043] = "rockbiter"  -- ???
}

local MainhandHasSpellpower = false
spec:RegisterStateExpr( "mainhand_has_spellpower", function() return MainhandHasSpellpower end )

local AURA_APPLIED_EVENTS = {
    SPELL_AURA_APPLIED      = 1,
    SPELL_AURA_APPLIED_DOSE = 1,
    SPELL_AURA_REFRESH      = 1,
}

local AURA_REMOVED_EVENTS = {
    SPELL_AURA_REMOVED      = 1,
    SPELL_AURA_REMOVED_DOSE = 1,
}

spec:RegisterCombatLogEvent( function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, ...)
    if sourceGUID ~= state.GUID then
        return
    end

    local timestamp = GetTime()
    if subtype == "SWING_DAMAGE" then
        LastSwingTimestamp = timestamp
    end

    if spellID == state.buff.flurry.id then
        local _, amount = select(1, ...)
        local secsSinceLastConsume = timestamp - LastConsumedStackTS
        if AURA_APPLIED_EVENTS[subtype] then
            if secsSinceLastConsume > 0.5 then
                LastConsumedStackTS = timestamp
            end
        end

        if AURA_REMOVED_EVENTS[subtype] then
            LastConsumedStackTS = timestamp
        end
    end

end, false )

local reset_gear = function()
    MainhandHasSpellpower = false
end

local update_gear = function(slotId, itemId)
    if slotId == 16 then
        local mhStats = GetItemStats("item:"..itemId)
        local mhSpellPower = mhStats and mhStats["ITEM_MOD_SPELL_POWER"]
        MainhandHasSpellpower = mhSpellPower and tonumber(mhSpellPower) > 0
    end
end

spec:RegisterHook( "reset_precast", function()
    windfury_mainhand = nil
    windfury_offhand = nil
    flametongue_mainhand = nil
    flametongue_offhand = nil
    frostbrand_mainhand = nil
    frostbrand_offhand = nil
    rockbiter_mainhand = nil
    rockbiter_offhand = nil
    mainhand_imbued = nil
    offhand_imbued = nil

    local mh, mh_expires, _, mh_id, oh, oh_expires, _, oh_id = GetWeaponEnchantInfo()

    if mh then
        mainhand_imbued = true

        mh = enchant_ids[ mh ]

        if mh == "windfury" then windfury_mainhand = true
        elseif mh == "flametongue" then flametongue_mainhand = true
        elseif mh == "frostbrand" then frostbrand_mainhand = true
        elseif mh == "rockbiter" then rockbiter_mainhand = true end
    end

    if oh then
        offhand_imbued = true

        oh = enchant_ids[ oh ]

        if oh == "windfury" then windfury_offhand = true
        elseif oh == "flametongue" then flametongue_offhand = true
        elseif oh == "frostbrand" then frostbrand_offhand = true
        elseif oh == "rockbiter" then rockbiter_offhand = true end
    end

    last_consumed_stack_ts = LastConsumedStackTS
    state.swings.mh_pseudo_speed = state.swings.mainhand_speed
end )


Hekili:RegisterGearHook( reset_gear, update_gear )

-- Abilities
spec:RegisterAbilities( {
    -- Returns the spirit to the body, restoring a dead target to life with 1800 health and 1365 mana.  Cannot be cast when in combat.
    ancestral_spirit = {
        id = 2008,
        cast = 10,
        cooldown = 0,
        gcd = "spell",

        spend = 0.72,
        spendType = "mana",

        startsCombat = false,
        texture = 136077,

        handler = function ()
        end,

        copy = { 20609, 20610, 20776, 20777, 25590, 49277 },
    },


    -- Yanks the caster through the twisting nether back to Dalaran.  Speak to an Innkeeper in a different place to change your home location.
    astral_recall = {
        id = 556,
        cast = 10,
        cooldown = function() return glyph.astral_recall.enabled and 450 or 900 end,
        gcd = "spell",

        spend = 0.05,
        spendType = "mana",

        startsCombat = false,
        texture = 136010,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    -- Increases melee, ranged, and spell casting speed by 30% for all party and raid members.  Lasts 40 sec.    After the completion of this effect, those affected will become Sated and unable to benefit from Bloodlust again for 10 min.
    bloodlust = {
        id = 2825,
        cast = 0,
        cooldown = 300,
        gcd = "spell",

        spend = 0.26,
        spendType = "mana",

        startsCombat = false,
        texture = 136012,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "bloodlust" )
            applyDebuff( "player", "sated" )
        end,

        copy = { "heroism", 32182 }
    },


    -- Heals the friendly target for 1055 to 1205, then jumps to heal additional nearby targets.  If cast on a party member, the heal will only jump to other party members.  Each jump reduces the effectiveness of the heal by 40%.  Heals 3 total targets.
    chain_heal = {
        id = 1064,
        cast = 2.5,
        cooldown = 0,
        gcd = "spell",

        spend = 0.19,
        spendType = "mana",

        startsCombat = false,
        texture = 136042,

        handler = function ()
        end,

        copy = { 10622, 10623, 25422, 25423, 55458, 55459 },
    },


    -- Hurls a lightning bolt at the enemy, dealing 982 to 1123 Nature damage and then jumping to additional nearby enemies.  Each jump reduces the damage by 30%.  Affects 3 total targets.
    chain_lightning = {
        id = 421,
        cast = function ()
            if buff.elemental_mastery.up then return 0 end
            return 2 * haste
        end,
        cooldown = 6,
        gcd = "spell",

        spend = function ()
            return ( buff.clearcasting.up and 0.6 or 1 ) * 0.26
        end,
        spendType = "mana",

        startsCombat = true,
        texture = 136015,

        handler = function ()
            removeBuff( "elemental_mastery" )
            removeStack( "clearcasting" )
            removeDebuffStack( "target", "stormstrike" )
        end,

        copy = { 930, 2860, 10605, 25439, 25442 },
    },

    -- Summons a Cleansing Totem with 5 health at the feet of the caster that attempts to remove 1 disease and 1 poison effect from party members within 30 yards every 3 seconds.  Lasts 5 min.
    cleansing_totem = {
        id = 8170,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        startsCombat = false,
        texture = 136019,

        totem = "water",

        handler = function ()
            removeBuff( "water_totem" )
            summonTotem( "cleansing_totem" )
            applyBuff( "cleansing_totem" )
        end,

        copy = { "disease_cleansing_totem" },
    },

    -- Summons a Poison Cleansing Totem with 5 health at the feet of the caster that attempts to remove 1 poison effect from party members within 30 yards every 5 seconds.  Lasts 2 min.
    poison_cleansing_totem = {
        id = 8166,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        startsCombat = false,
        texture = 136070,

        totem = "water",

        handler = function ()
            removeBuff( "water_totem" )
            summonTotem( "poison_cleansing_totem" )
            applyBuff( "poison_cleansing_totem" )
        end,

        copy = { "poison_cleansing" },
    },

    -- Cures 1 poison effect on a friendly target.
    cure_toxins = {
        id = 526,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.07,
        spendType = "mana",

        startsCombat = false,
        texture = 136067,

        buff = "can_cure_toxins",

        handler = function ()
            removeBuff( "can_cure_toxins" )
        end,
    },

    -- Cures 1 disease effect on a friendly target.
    cure_disease = {
        id = 2870,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.07,
        spendType = "mana",

        startsCombat = false,
        texture = 136083,

        buff = "can_cure_disease",

        handler = function ()
            removeBuff( "can_cure_disease" )
        end,
    },


    -- Summon an elemental totem that calls forth a greater earth elemental to protect the caster and his allies.  Lasts 2 min.
    earth_elemental_totem = {
        id = 2062,
        cast = 0,
        cooldown = 600,
        gcd = "spell",

        spend = 0.24,
        spendType = "mana",

        startsCombat = false,
        texture = 136024,

        toggle = "cooldowns",

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "earth_elemental_totem" )
            applyBuff( "earth_elemental_totem" )
        end,
    },


    -- Protects the target with an earthen shield, reducing casting or channeling time lost when damaged by 30%  and causing attacks to heal the shielded target for 150.  This effect can only occur once every few seconds.  6 charges.  Lasts 10 min.  Earth Shield can only be placed on one target at a time and only one Elemental Shield can be active on a target at a time.
    earth_shield = {
        id = 974,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.15,
        spendType = "mana",

        talent = "earth_shield",
        startsCombat = false,
        texture = 136089,

        handler = function ()
            removeBuff( "shield" )
            applyBuff( "earth_shield", nil, buff.earth_shield.max_stack )
        end,
    },


    -- Instantly shocks the target with concussive force, causing 862 to 909 Nature damage and reducing melee attack speed by 10% for 8 sec.
    earth_shock = {
        id = 8042,
        cast = 0,
        cooldown = 6,
        gcd = function() return glyph.shocking.enabled and "totem" or "spell" end,

        spend = function ()
            return ( buff.clearcasting.up and 0.6 or 1 ) * 0.18
        end,

        spendType = "mana",

        startsCombat = true,
        texture = 136026,

        handler = function ()
            applyDebuff( "target", "earth_shock" )
            setCooldown( "flame_shock", 6 )
            setCooldown( "frost_shock", 6 )
            removeDebuffStack( "target", "stormstrike" )
        end,

        copy = { 8044, 8045, 8046, 10412, 10413, 10414, 25454 },
    },


    -- Summons an Earthbind Totem with 5 health at the feet of the caster for 45 sec that slows the movement speed of enemies within 10 yards.
    earthbind_totem = {
        id = 2484,
        cast = 0,
        cooldown = 15,
        gcd = "spell",

        spend = 0.05,
        spendType = "mana",

        startsCombat = false,
        texture = 136102,

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "earthbind_totem" )
            applyBuff( "earthbind_totem" )
        end,
    },


    -- When activated, your next Lightning Bolt, Chain Lightning or Lava Burst spell becomes an instant cast spell. In addition, you gain 15% spell haste for 15 sec. Elemental Mastery shares a cooldown with Nature's Swiftness.
    elemental_mastery = {
        id = 16166,
        cast = 0,
        cooldown = function() return glyph.elemental_mastery.enabled and 150 or 180 end,
        gcd = "spell",

        talent = "elemental_mastery",
        startsCombat = false,
        texture = 136115,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "elemental_mastery" )
            haste = haste + 0.15
        end,
    },


    -- Changes the caster's viewpoint to the targeted location.  Lasts 1 min.  Only useable outdoors.
    far_sight = {
        id = 6196,
        cast = 2,
        cooldown = 0,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 136034,

        handler = function ()
            applyBuff( "far_sight" )
        end,
    },


    -- Summons an elemental totem that calls forth a greater fire elemental to rain destruction on the caster's enemies.  Lasts 2 min.
    fire_elemental_totem = {
        id = 2894,
        cast = 0,
        cooldown = function() return glyph.fire_elemental_totem.enabled and 300 or 600 end,
        gcd = "totem",

        spend = 0.23,
        spendType = "mana",

        startsCombat = true,
        texture = 135790,

        toggle = "cooldowns",

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "fire_elemental_totem" )
            applyBuff( "fire_elemental_totem" )
        end,
    },


    -- Summons a Fire Nova Totem with 5 health at the feet of the caster that pulses a wave of fire damage after 5 sec.
    fire_nova_totem = {
        id = 1535,
        cast = 0,
        cooldown = 15,
        gcd = "totem",

        spend = 0.22,
        spendType = "mana",

        startsCombat = true,
        texture = 135824,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "fire_nova_totem" )
            applyBuff( "fire_nova_totem" )
        end,

        copy = { "fire_nova", 8498, 8499, 11314, 11315, 25546, 25547 },
    },


    -- Summons a Fire Resistance Totem with 5 health at the feet of the caster for 5 min that increases the fire resistance of party and raid members within 30 yards by 130.
    fire_resistance_totem = {
        id = 8184,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.08,
        spendType = "mana",

        startsCombat = false,
        texture = 135832,

        totem = "water",

        handler = function ()
            removeBuff( "water_totem" )
            summonTotem( "fire_resistance_totem" )
            applyBuff( "fire_resistance_totem" )
        end,

        copy = { 10537, 10538, 25563, 58737, 58739 },
    },


    -- Instantly sears the target with fire, causing 505 Fire damage immediately and 842 Fire damage over 16.45 sec. This periodic damage may critically strike and will occur more rapidly based on the caster's spell haste.
    flame_shock = {
        id = 8050,
        cast = 0,
        cooldown = 6,
        gcd = function() return glyph.shocking.enabled and "totem" or "spell" end,

        spend = function ()
            return ( buff.clearcasting.up and 0.6 or 1 ) * 0.17
        end,
        spendType = "mana",

        startsCombat = true,
        texture = 135813,

        handler = function ()
            applyDebuff( "target", "flame_shock" )
            setCooldown( "frost_shock", 6 )
            setCooldown( "earth_shock", 6 )
        end,

        copy = { 8052, 8053, 10447, 10448, 29228, 25457 },
    },


    -- Summons a Flametongue Totem with 5 health at the feet of the caster.  Party and raid members within 30 yards of the totem have their spell damage and healing increased by up to 144.  Lasts 5 min.
    flametongue_totem = {
        id = 8227,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.11,
        spendType = "mana",

        startsCombat = false,
        texture = 136040,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "flametongue_totem" )
            applyBuff( "flametongue_totem" )
        end,

        copy = { 8249, 10526, 16387, 25557 },
    },


    -- Imbue the Shaman's weapon with fire, increasing total spell damage by 211. Each hit causes 89.0 to 274 additional Fire damage, based on the speed of the weapon.  Slower weapons cause more fire damage per swing.  Lasts 30 minutes.
    flametongue_weapon = {
        id = 8024,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        max_rank = 10,

        spend = 0.06,
        spendType = "mana",

        startsCombat = false,
        texture = 135814,

        usable = function() return ( equipped.mainhand and not mainhand_imbued ) or ( equipped.offhand and not offhand_imbued ), "must have an unimbued weapon" end,

        handler = function ()
            if equipped.mainhand and not mainhand_imbued then
                mainhand_imbued = true
                flametongue_mainhand = true
            elseif equipped.offhand and not offhand_imbued then
                offhand_imbued = true
                flametongue_offhand = true
            end
        end,

        copy = { 8027, 8030, 16339, 16341, 16342, 25489, 58785, 58789, 58790 },
    },


    -- Summons a Frost Resistance Totem with 5 health at the feet of the caster for 5 min.  The totem increases party and raid members' frost resistance by 130, if within 30 yards.
    frost_resistance_totem = {
        id = 8181,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.08,
        spendType = "mana",

        startsCombat = false,
        texture = 135866,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "frost_resistance_totem" )
            applyBuff( "frost_resistance_totem" )
        end,

        copy = { 10478, 10479, 25560, 58741, 58745 },
    },


    -- Instantly shocks the target with frost, causing 820 to 867 Frost damage and slowing movement speed by 50%.  Lasts 8 sec.  Causes a high amount of threat.
    frost_shock = {
        id = 8056,
        cast = 0,
        cooldown = 6,
        gcd = function() return glyph.shocking.enabled and "totem" or "spell" end,

        spend = function ()
            return ( buff.clearcasting.up and 0.6 or 1 ) * 0.18
        end,
        spendType = "mana",

        startsCombat = true,
        texture = 135849,

        handler = function ()
            applyDebuff( "target", "frost_shock" )
            setCooldown( "flame_shock", 6 )
            setCooldown( "earth_shock", 6 )
        end,

        copy = { 8058, 10472, 10473, 25464 },
    },


    -- Imbue the Shaman's weapon with frost.  Each hit has a chance of causing 530 additional Frost damage and slowing the target's movement speed by 50% for 8 sec.  Lasts 30 minutes.
    frostbrand_weapon = {
        id = 8033,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.06,
        spendType = "mana",

        startsCombat = false,
        texture = 135847,

        usable = function() return ( equipped.mainhand and not mainhand_imbued ) or ( equipped.offhand and not offhand_imbued ), "must have an unimbued weapon" end,

        handler = function( rank )
            if equipped.mainhand and not mainhand_imbued then
                mainhand_imbued = true
                frostbrand_mainhand = true
            elseif equipped.offhand and not offhand_imbued then
                offhand_imbued = true
                frostbrand_offhand = true
            end
        end,

        copy = { 8038, 10456, 16355, 16356, 25500, 58794, 58795, 58796 },
    },


    -- Turns the Shaman into a Ghost Wolf, increasing speed by 40%. As a Ghost Wolf, the Shaman is less hindered by effects that would reduce movement speed. Only useable outdoors.
    ghost_wolf = {
        id = 2645,
        cast = 2,
        cooldown = 0,
        gcd = "spell",

        spend = 0.06,
        spendType = "mana",

        startsCombat = false,
        texture = 136095,

        handler = function ()
            applyBuff( "ghost_wolf" )
        end,
    },


    -- Summons a Grounding Totem with 5 health at the feet of the caster that will redirect one harmful spell cast on a nearby party member to itself, destroying the totem.  Will not redirect area of effect spells.  Lasts 45 sec.
    grounding_totem = {
        id = 8177,
        cast = 0,
        cooldown = 15,
        gcd = "spell",

        spend = 0.05,
        spendType = "mana",

        startsCombat = false,
        texture = 136039,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "grounding_totem" )
            applyBuff( "grounding_totem" )
        end,
    },


    -- Summons a Healing Stream Totem with 5 health at the feet of the caster for 5 min that heals group members within 30 yards for 25 every 2 seconds.
    healing_stream_totem = {
        id = 5394,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 135127,

        totem = "water",

        handler = function( rank )
            removeBuff( "water_totem" )
            summonTotem( "healing_stream_totem" )
            applyBuff( "healing_stream_totem" )
        end,

        copy = { 6375, 6377, 10462, 10463, 25567, 58755, 58756, 58757 },
    },


    -- Heals a friendly target for 3034 to 3466.
    healing_wave = {
        id = 331,
        cast = function()
            if buff.natures_swiftness.up then return 0 end
            return 3 * haste
        end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.25,
        spendType = "mana",

        startsCombat = false,
        texture = 136052,

        handler = function ()
            removeBuff( "natures_swiftness" )
        end,

        copy = { 332, 547, 913, 939, 959, 8005, 10395, 10396, 25357, 25391, 25396 },
    },


    -- Heals a friendly target for 1624 to 1852.
    lesser_healing_wave = {
        id = 8004,
        cast = function ()
            if buff.natures_swiftness.up then return 0 end
            return 1.5 * haste
        end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.15,
        spendType = "mana",

        startsCombat = false,
        texture = 136043,

        handler = function ()
            removeBuff( "natures_swiftness" )
        end,

        copy = { 8008, 8010, 10466, 10467, 10468, 25420 },
    },


    -- Casts a bolt of lightning at the target for 726 to 828 Nature damage.
    lightning_bolt = {
        id = 403,
        cast = function ()
            if buff.elemental_mastery.up or buff.natures_swiftness.up then return 0 end
            return 2.5 * haste
        end,
        cooldown = 0,
        gcd = "spell",

        spend = function ()
            return 0.1 * ( buff.clearcasting.up and 0.6 or 1 )
        end,
        spendType = "mana",

        startsCombat = true,
        texture = 136048,

        handler = function ()
            removeStack( "clearcasting" )
            removeBuff( "natures_swiftness" )
            removeBuff( "elemental_mastery" )
            removeDebuffStack( "target", "stormstrike" )
        end,

        copy = { 529, 548, 915, 943, 6041, 10391, 10392, 15207, 15208, 25448, 25449 },
    },


    -- The caster is surrounded by 3 balls of lightning.  When a spell, melee or ranged attack hits the caster, the attacker will be struck for 380 Nature damage.  This expends one lightning ball.  Only one ball will fire every few seconds.  Lasts 10 min.  Only one Elemental Shield can be active on the Shaman at any one time.
    lightning_shield = {
        id = 324,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = false,
        texture = 136051,

        handler = function ()
            removeBuff( "shield" )
            applyBuff( "lightning_shield", nil, buff.lightning_shield.max_stack )
        end,

        copy = { 325, 905, 945, 8134, 10431, 10432, 25469, 25472, 49280, 49281 },
    },


    -- Summons a Magma Totem with 5 health at the feet of the caster for 20 sec that causes 371 Fire damage to creatures within 8 yards every 2 seconds.
    magma_totem = {
        id = 8190,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.27,
        spendType = "mana",

        startsCombat = true,
        texture = 135826,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "magma_totem" )
            applyBuff( "magma_totem" )
        end,

        copy = { 10585, 10586, 10587, 25552, 58731, 58734 },
    },


    -- Summons a Mana Spring Totem with 5 health at the feet of the caster for 5 min that restores 91 mana every 5 seconds to all party and raid members within 30 yards.
    mana_spring_totem = {
        id = 5675,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.04,
        spendType = "mana",

        startsCombat = false,
        texture = 136053,

        totem = "water",

        handler = function ()
            removeBuff( "water_totem" )
            summonTotem( "mana_spring_totem" )
            applyBuff( "mana_spring_totem" )
        end,

        copy = { 10495, 10496, 10497, 25570, 58771, 58773, 58774 },
    },


    -- Summons a Mana Tide Totem with 10% of the caster's health at the feet of the caster for 12 sec that restores 6% of total mana every 3 seconds to group members within 30 yards.
    mana_tide_totem = {
        id = 16190,
        cast = 0,
        cooldown = 300,
        gcd = "spell",

        talent = "mana_tide_totem",
        startsCombat = false,
        texture = 135861,

        toggle = "cooldowns",

        totem = "water",

        handler = function ()
            removeBuff( "water_totem" )
            summonTotem( "mana_tide_totem" )
            applyBuff( "mana_tide_totem" )
        end,
    },


    -- Summons a Nature Resistance Totem with 5 health at the feet of the caster for 5 min that increases the nature resistance of party and raid members within 30 yards by 130.
    nature_resistance_totem = {
        id = 10595,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        startsCombat = true,
        texture = 136061,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "nature_resistance_totem" )
            applyBuff( "nature_resistance_totem" )
        end,

        copy = { 10600, 10601, 25574, 58746, 58749 },
    },


    -- When activated, your next Nature spell with a base casting time less than 10 sec. becomes an instant cast spell. Nature's Swiftness shares a cooldown with Elemental Mastery.
    natures_swiftness = {
        id = 16188,
        cast = 0,
        cooldown = 120,
        gcd = "off",

        talent = "natures_swiftness",
        startsCombat = false,
        texture = 136076,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "natures_swiftness" )
            setCooldown( "elemental_mastery", 120 )
        end,
    },


    -- Purges the enemy target, removing 2 beneficial magic effects.
    purge = {
        id = 370,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        startsCombat = true,
        texture = 136075,

        debuff = "dispellable_magic",

        handler = function ()
            removeDebuff( "target", "dispellable_magic" )
        end,

        copy = { 8012 },
    },


    -- Imbue the Shaman's weapon, increasing its damage per second by 9.  Lasts 30 minutes.
    rockbiter_weapon = {
        id = 8017,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        startsCombat = false,
        texture = 136086,

        usable = function() return ( equipped.mainhand and not mainhand_imbued ) or ( equipped.offhand and not offhand_imbued ), "must have an unimbued weapon" end,

        handler = function ()
            if equipped.mainhand and not mainhand_imbued then
                mainhand_imbued = true
                rockbiter_mainhand = true
            elseif equipped.offhand and not offhand_imbued then
                offhand_imbued = true
                rockbiter_offhand = true
            end
        end,

        copy = { 8018, 8019, 10399, 16314, 16315, 16316, 25479, 25485 },
    },


    -- Summons a Searing Totem with 5 health at your feet for 1 min that repeatedly attacks an enemy within 201 yards for 90 to 120 Fire damage.
    searing_totem = {
        id = 3599,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.07,
        spendType = "mana",

        startsCombat = false,
        texture = 135825,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "searing_totem" )
            applyBuff( "searing_totem" )
        end,

        copy = { 6363, 6364, 6365, 10437, 10438, 25533, 58699, 58703, 58704 },
    },


    -- Summons an immobile Sentry Totem with 100 health at your feet for 5 min that allows vision of nearby area and warns of enemies that attack it.  Right-Click on buff to switch back and forth between totem sight and shaman sight.
    sentry_totem = {
        id = 6495,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 136082,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "sentry_totem" )
            applyBuff( "sentry_totem" )
        end,

        copy = { 6363, 6364, 6365, 10437, 10438, 25533 },
    },


    -- Reduces all damage taken by 30% and gives your successful melee attacks a chance to regenerate mana equal to 15% of your attack power. This spell is usable while stunned. Lasts 15 sec.
    shamanistic_rage = {
        id = 30823,
        cast = 0,
        cooldown = 120,
        gcd = "spell",

        talent = "shamanistic_rage",
        startsCombat = false,
        texture = 136088,

        -- Shamanistic Rage is on Defensives toggle unless mana is below the threshold.
        toggle = function ()
            if mana.percent > settings.shaman_rage_threshold then return "defensives" end
        end,

        handler = function ()
            applyBuff( "shamanistic_rage" )
        end,

        copy = { 30824 },
    },


    -- Summons a Stoneclaw Totem with 1632  health at the feet of the caster for 15 sec that taunts creatures within 8 yards to attack it.  Enemies attacking the Stoneclaw Totem have a 50% chance to be stunned for 3 sec. Stoneclaw totem also protects all your totems, causing them to absorb 1085 damage.
    stoneclaw_totem = {
        id = 5730,
        cast = 0,
        cooldown = 30,
        gcd = "totem",

        spend = 0.06,
        spendType = "mana",

        startsCombat = true,
        texture = 136097,

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "stoneclaw_totem" )
            applyBuff( "stoneclaw_totem" )
        end,

        copy = { 6390, 6391, 6392, 10427, 10428, 25525, 58580, 58581, 58582 },
    },


    -- Summons a Stoneskin Totem with 5 health at the feet of the caster.  The totem protects party and raid members within 30 yards, increasing armor by 1150.  Lasts 5 min.
    stoneskin_totem = {
        id = 8071,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.1,
        spendType = "mana",

        startsCombat = false,
        texture = 136098,

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "stoneskin_totem" )
            applyBuff( "stoneskin_totem" )
        end,

        copy = { 8154, 8155, 10406, 10407, 10408, 25508, 25509, 58751, 58753 },
    },


    -- Instantly attack with both weapons.  In addition, the next 4 sources of Nature damage dealt to the target from the Shaman are increased by 20%. Lasts 12 sec.
    stormstrike = {
        id = 17364,
        cast = 0,
        cooldown = 10,
        gcd = "spell",

        spend = 0.08,
        spendType = "mana",

        talent = "stormstrike",
        startsCombat = true,
        texture = 132314,

        handler = function ()
            applyDebuff( "target", "stormstrike", nil, 2 )
        end,

        copy = { 32175, 32176 },
    },


    -- Summons a Strength of Earth Totem with 5 health at the feet of the caster.  The totem increases the strength and agility of all party and raid members within 30 yards by 155.  Lasts 5 min.
    strength_of_earth_totem = {
        id = 8075,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.1,
        spendType = "mana",

        startsCombat = true,
        texture = 136023,

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "strength_of_earth_totem" )
            applyBuff( "strength_of_earth_totem" )
        end,

        copy = { 8160, 8161, 10442, 25361, 25528, 57622, 58643 },
    },


    -- Summons a Totem of Wrath with 5 health at the feet of the caster.  The totem increases spell power by 100 for all party and raid members, and increases the critical strike chance of all attacks by 3% against all enemies within 40 yards.  Lasts 5 min.
    totem_of_wrath = {
        id = 30706,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.05,
        spendType = "mana",

        talent = "totem_of_wrath",
        startsCombat = false,
        texture = 135829,

        totem = "fire",

        handler = function ()
            removeBuff( "fire_totem" )
            summonTotem( "totem_of_wrath" )
            applyBuff( "totem_of_wrath" )
        end,

        copy = { 30708 },
    },


    -- Returns your totems to the earth, giving you 25% of the mana required to cast each totem destroyed by Totemic Recall.
    totemic_recall = {
        id = 36936,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = false,
        texture = 310733,

        handler = function ()
            if buff.earth_totem.up then
                gain( 0.25 * action[ buff.earth_totem.actual ].cost, "mana" )
                removeBuff( "earth_totem" )
            end
            if buff.fire_totem.up then
                gain( 0.25 * action[ buff.fire_totem.actual ].cost, "mana" )
                removeBuff( "fire_totem" )
            end
            if buff.water_totem.up then
                gain( 0.25 * action[ buff.water_totem.actual ].cost, "mana" )
                removeBuff( "water_totem" )
            end
            if buff.air_totem.up then
                gain( 0.25 * action[ buff.air_totem.actual ].cost, "mana" )
                removeBuff( "air_totem" )
            end
        end,

        copy = { "totemic_call" },
    },

    -- Allows the shaman to resurrect after death with a percentage of health and mana.
    reincarnation = {
        id = 20608,
        cast = 0,
        cooldown = 1800,
        gcd = "off",

        startsCombat = false,
        texture = 136080,

        handler = function ()
        end,

        copy = { 21169, 27740 },
    },


    -- Summons a Tremor Totem with 5 health at the feet of the caster that shakes the ground around it, removing Fear, Charm and Sleep effects from party members within 30 yards.  Lasts 5 min.
    tremor_totem = {
        id = 8143,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 136108,

        totem = "earth",

        handler = function ()
            removeBuff( "earth_totem" )
            summonTotem( "tremor_totem" )
            applyBuff( "tremor_totem" )
        end,
    },


    -- Allows the target to breathe underwater for 10 min.
    water_breathing = {
        id = 131,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        texture = 136148,

        handler = function ()
            applyBuff( "water_breathing" )
        end,
    },


    -- The caster is surrounded by 3 globes of water, granting 100 mana per 5 sec.  When a spell, melee or ranged attack hits the caster, 428 mana is restored to the caster. This expends one water globe.  Only one globe will activate every few seconds.  Lasts 10 min.  Only one Elemental Shield can be active on the Shaman at any one time.
    water_shield = {
        id = 24398,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        startsCombat = false,
        texture = 132315,

        handler = function ()
            removeBuff( "shield" )
            applyBuff( "water_shield", nil, glyph.water_shield.enabled and 4 or 3 )
        end,

        copy = { 23575, 33736, 33737 },
    },


    -- Allows the friendly target to walk across water for 10 min.  Any damage will cancel the effect.
    water_walking = {
        id = 546,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 135863,

        handler = function ()
            applyBuff( "water_walking" )
        end,
    },


    -- Summons a Windfury Totem with 5 health at the feet of the caster.  The totem provides 16% melee haste to all party and raid members within 30 yards.  Lasts 5 min.
    windfury_totem = {
        id = 8512,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.11,
        spendType = "mana",

        startsCombat = false,
        texture = 136114,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "windfury_totem" )
            applyBuff( "windfury_totem" )
        end,

        copy = { 10613, 10614, 25585, 25587 },
    },


    -- Summons a Windwall Totem with 5 health at the feet of the caster.  The totem reduces ranged damage done to party and raid members within 30 yards.  Lasts 2 min.
    windwall_totem = {
        id = 15107,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.1,
        spendType = "mana",

        startsCombat = false,
        texture = 136022,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "windwall_totem" )
            applyBuff( "windwall_totem" )
        end,

        copy = { 15111, 15112, 25577 },
    },


    -- Summons a Grace of Air Totem with 5 health at the feet of the caster.  The totem increases Agility for all party and raid members within 30 yards.  Lasts 5 min.
    grace_of_air_totem = {
        id = 8835,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.11,
        spendType = "mana",

        startsCombat = false,
        texture = 136046,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "grace_of_air_totem" )
            applyBuff( "grace_of_air_totem" )
        end,

        copy = { 10627, 25359 },
    },


    -- Summons a Tranquil Air Totem with 5 health at the feet of the caster.  The totem reduces threat generated by all party and raid members within 30 yards.  Lasts 5 min.
    tranquil_air_totem = {
        id = 25908,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.11,
        spendType = "mana",

        startsCombat = false,
        texture = 136013,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "tranquil_air_totem" )
            applyBuff( "tranquil_air_totem" )
        end,
    },


    -- Imbue the Shaman's weapon with wind.  Each hit has a 20% chance of dealing additional damage equal to two extra attacks with 1250 extra attack power.  Lasts 30 minutes.
    windfury_weapon = {
        id = 8232,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.07,
        spendType = "mana",

        startsCombat = false,
        texture = 136018,

        usable = function() return ( equipped.mainhand and not mainhand_imbued ) or ( equipped.offhand and not offhand_imbued ), "must have an unimbued weapon" end,

        handler = function ()
            if equipped.mainhand and not mainhand_imbued then
                mainhand_imbued = true
                windfury_mainhand = true
            elseif equipped.offhand and not offhand_imbued then
                offhand_imbued = true
                windfury_offhand = true
            end
        end,

        copy = { 8235, 10486, 16362, 25505, 58801, 58803, 58804 },
    },


    -- Summons a Wrath of Air Totem with 5 health at the feet of the caster.  The totem provides 5% spell haste to all party and raid members within 30 yards.  Lasts 5 min.
    wrath_of_air_totem = {
        id = 3738,
        cast = 0,
        cooldown = 0,
        gcd = "totem",

        spend = 0.11,
        spendType = "mana",

        startsCombat = false,
        texture = 136092,

        totem = "air",

        handler = function ()
            removeBuff( "air_totem" )
            summonTotem( "wrath_of_air_totem" )
            applyBuff( "wrath_of_air_totem" )
        end,

        copy = { 2895 },
    },
} )


spec:RegisterSetting( "st_cl_mana_threshold", 80, {
    type = "range",
    name = "|T136015:0|t Single-Target Chain Lightning Mana %",
    desc = "When below the specified mana percentage, the default priority will not recommend |T136015:0|t Chain Lightning in single-target.",
    min = 0,
    max = 100,
    step = 1,
    width = "full",
} )

spec:RegisterSetting( "st_fn_mana_threshold", 3000, {
    type = "range",
    name = "Single-Target Fire Nova Mana",
    desc = "When below the specified mana level, the default priority will not recommend Fire Nova in single-target.",
    min = 0,
    softMax = 10000,
    step = 100,
    width = "full",
} )

spec:RegisterSetting( "shaman_rage_threshold", 60, {
    type = "range",
    name = "|T136088:0|t Shamanistic Rage Threshold",
    desc = "When below the specified mana percentage, the addon may recommend using Shamanistic Rage to regenerate mana.",
    min = 0,
    max = 100,
    step = 1,
    width = "full",
} )


spec:RegisterOptions( {
    enabled = true,

    aoe = 2,

    gcd = 8017,

    nameplates = true,
    nameplateRange = 8,

    damage = true,
    damageExpiration = 6,
    potion = "speed",

    package = "Enhancement",
    usePackSelector = true
} )


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