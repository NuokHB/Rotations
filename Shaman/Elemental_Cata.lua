--Version: 15595
local ni = ...

local queue = {
   "Pause",
   "Cache",
   "WaitForCast",
   "GCD",
   "FlametongueWeapon",
   "LightningShield",
   "FlameShock",
   "LavaBurst",
   "EarthShock",
   "ChainLightning",
   "LightningBolt"
}

local spells = {
   --General icon = select(2, GetSpellTabInfo(1))
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   --Elemental Combat icon = select(2, GetSpellTabInfo(2))
   BindElemental = {id = 76780, name = ni.spell.info(76780)},
   CalloftheAncestors = {id = 66843, name = ni.spell.info(66843)},
   CalloftheElements = {id = 66842, name = ni.spell.info(66842)},
   CalloftheSpirits = {id = 66844, name = ni.spell.info(66844)},
   ChainLightning = {id = 421, name = ni.spell.info(421)},
   EarthShock = {id = 8042, name = ni.spell.info(8042)},
   EarthbindTotem = {id = 2484, name = ni.spell.info(2484)},
   ElementalFury = {id = 60188, name = ni.spell.info(60188)},
   ElementalMastery = {id = 16166, name = ni.spell.info(16166)},
   FireElementalTotem = {id = 2894, name = ni.spell.info(2894)},
   FireNova = {id = 1535, name = ni.spell.info(1535)},
   FlameShock = {id = 8050, name = ni.spell.info(8050)},
   FrostShock = {id = 8056, name = ni.spell.info(8056)},
   LavaBurst = {id = 51505, name = ni.spell.info(51505)},
   LightningBolt = {id = 403, name = ni.spell.info(403)},
   MagmaTotem = {id = 8190, name = ni.spell.info(8190)},
   Purge = {id = 370, name = ni.spell.info(370)},
   SearingTotem = {id = 3599, name = ni.spell.info(3599)},
   Shamanism = {id = 62099, name = ni.spell.info(62099)},
   StoneclawTotem = {id = 5730, name = ni.spell.info(5730)},
   Thunderstorm = {id = 51490, name = ni.spell.info(51490)},
   WindShear = {id = 57994, name = ni.spell.info(57994)},
   Hex = {id = 51514, name = ni.spell.info(51514)},
   SpiritwalkersGrace = {id = 79206, name = ni.spell.info(79206)},
   --Enhancement icon = select(2, GetSpellTabInfo(3))
   AstralRecall = {id = 556, name = ni.spell.info(556)},
   Bloodlust = {id = 2825, name = ni.spell.info(2825)},
   EarthElementalTotem = {id = 2062, name = ni.spell.info(2062)},
   ElementalResistanceTotem = {id = 8184, name = ni.spell.info(8184)},
   FarSight = {id = 6196, name = ni.spell.info(6196)},
   FlametongueTotem = {id = 8227, name = ni.spell.info(8227)},
   FlametongueWeapon = {id = 8024, name = ni.spell.info(8024)},
   FrostbrandWeapon = {id = 8033, name = ni.spell.info(8033)},
   GhostWolf = {id = 2645, name = ni.spell.info(2645)},
   GroundingTotem = {id = 8177, name = ni.spell.info(8177)},
   LightningShield = {id = 324, name = ni.spell.info(324)},
   PrimalStrike = {id = 73899, name = ni.spell.info(73899)},
   StoneskinTotem = {id = 8071, name = ni.spell.info(8071)},
   StrengthofEarthTotem = {id = 8075, name = ni.spell.info(8075)},
   WaterBreathing = {id = 131, name = ni.spell.info(131)},
   WaterWalking = {id = 546, name = ni.spell.info(546)},
   WindfuryTotem = {id = 8512, name = ni.spell.info(8512)},
   WindfuryWeapon = {id = 8232, name = ni.spell.info(8232)},
   WrathofAirTotem = {id = 3738, name = ni.spell.info(3738)},
   RockbiterWeapon = {id = 8017, name = ni.spell.info(8017)},
   UnleashElements = {id = 73680, name = ni.spell.info(73680)},
   --Restoration icon = select(2, GetSpellTabInfo(4))
   AncestralSpirit = {id = 2008, name = ni.spell.info(2008)},
   ChainHeal = {id = 1064, name = ni.spell.info(1064)},
   CleanseSpirit = {id = 51886, name = ni.spell.info(51886)},
   EarthlivingWeapon = {id = 51730, name = ni.spell.info(51730)},
   GreaterHealingWave = {id = 77472, name = ni.spell.info(77472)},
   HealingStreamTotem = {id = 5394, name = ni.spell.info(5394)},
   HealingSurge = {id = 8004, name = ni.spell.info(8004)},
   HealingWave = {id = 331, name = ni.spell.info(331)},
   ManaSpringTotem = {id = 5675, name = ni.spell.info(5675)},
   Reincarnation = {id = 20608, name = ni.spell.info(20608)},
   TotemicRecall = {id = 36936, name = ni.spell.info(36936)},
   TremorTotem = {id = 8143, name = ni.spell.info(8143)},
   WaterShield = {id = 52127, name = ni.spell.info(52127)},
   TotemofTranquilMind = {id = 87718, name = ni.spell.info(87718)},
   HealingRain = {id = 73920, name = ni.spell.info(73920)}
}

local t,
   p = "target", "player"

local cache = {
   targets = nil,
   target_count = 0
}

local abilities = {
   ["Pause"] = function()
      if
         ni.player.mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t)
       then
         return true
      end
   end,
   ["GCD"] = function()
      if ni.spell.on_gcd() then
         return true
      end
   end,
   ["WaitForCast"] = function ()
      if ni.player.casting() then
         return true
      end
   end,
   ["Cache"] = function()
      ni.objects.update()
      cache.targets = ni.unit.enemies_in_range(t, 15)
      cache.target_count = ni.table.length(cache.targets)
   end,
   ["LightningBolt"] = function()
      if ni.spell.valid(spells.LightningBolt.id, t, true, true) then
         ni.spell.cast(spells.LightningBolt.id, t)
         return true
      end
   end,
   ["ChainLightning"] = function()
      if ni.spell.valid(spells.ChainLightning.id, t, true, true) and cache.target_count > 1 then
         ni.spell.cast(spells.ChainLightning.id, t)
         return true
      end
   end,
   ["LightningShield"] = function()
      if not ni.player.buff(spells.LightningShield.name) and ni.spell.available(spells.LightningShield.id) then
         ni.spell.cast(spells.LightningShield.id)
         return true
      end
   end,
   ["FlameShock"] = function()
      if
         ni.unit.debuff_remaining(t, spells.FlameShock.id, p) < 1.5 and
            ni.spell.valid(spells.FlameShock.id, t, true, true)
       then
         ni.spell.cast(spells.FlameShock.id, t)
         return true
      end
   end,
   ["EarthShock"] = function()
      if ni.player.buff_stacks(spells.LightningShield.id) == 9 and ni.spell.valid(spells.EarthShock.id, t, true, true) then
         ni.spell.cast(spells.EarthShock.id, t)
         return true
      end
   end,
   ["LavaBurst"] = function()
      if
         ni.unit.debuff_remaining(t, spells.FlameShock.id, p) > 1.8 and
            ni.spell.valid(spells.LavaBurst.id, t, true, true)
       then
         ni.spell.cast(spells.LavaBurst.id, t)
         return true
      end
   end,
   ["FlametongueWeapon"] = function()
      if not ni.gear.weapon_enchant_info() and ni.spell.available(spells.FlametongueWeapon.id) then
         ni.spell.cast(spells.FlametongueWeapon.id)
         return true
      end
   end
}
ni.profile.new("Elemental_Cata", queue, abilities)
