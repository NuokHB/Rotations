--Version: 12340
local ni = ...

local spells = {
   --General
   ArcaneAffinity = {id = 28877, name = ni.spell.info(28877)},
   ArcaneTorrent = {id = 28730, name = ni.spell.info(28730)},
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   Dodge = {id = 81, name = ni.spell.info(81)},
   MagicResistance = {id = 822, name = ni.spell.info(822)},
   Shoot = {id = 5019, name = ni.spell.info(5019)},
   --Arcane
   AmplifyMagic = {id = 10170, name = ni.spell.info(10170)},
   ArcaneBlast = {id = 30451, name = ni.spell.info(30451)},
   ArcaneBrilliance = {id = 27127, name = ni.spell.info(27127)},
   ArcaneExplosion = {id = 10202, name = ni.spell.info(10202)},
   ArcaneIntellect = {id = 27126, name = ni.spell.info(27126)},
   ArcaneMissiles = {id = 10212, name = ni.spell.info(10212)},
   Blink = {id = 1953, name = ni.spell.info(1953)},
   ConjureFood = {id = 33717, name = ni.spell.info(33717)},
   ConjureManaGem = {id = 27101, name = ni.spell.info(27101)},
   ConjureWater = {id = 27090, name = ni.spell.info(27090)},
   Counterspell = {id = 2139, name = ni.spell.info(2139)},
   DampenMagic = {id = 10173, name = ni.spell.info(10173)},
   Evocation = {id = 12051, name = ni.spell.info(12051)},
   Invisibility = {id = 66, name = ni.spell.info(66)},
   MageArmor = {id = 22783, name = ni.spell.info(22783)},
   ManaShield = {id = 10192, name = ni.spell.info(10192)},
   Polymorph = {id = 12826, name = ni.spell.info(12826)},
   PortalShattrath = {id = 35717, name = ni.spell.info(35717)},
   PortalSilvermoon = {id = 32267, name = ni.spell.info(32267)},
   PortalUndercity = {id = 11418, name = ni.spell.info(11418)},
   RemoveCurse = {id = 475, name = ni.spell.info(475)},
   RitualofRefreshment = {id = 43987, name = ni.spell.info(43987)},
   SlowFall = {id = 130, name = ni.spell.info(130)},
   Spellsteal = {id = 30449, name = ni.spell.info(30449)},
   TeleportShattrath = {id = 35715, name = ni.spell.info(35715)},
   TeleportSilvermoon = {id = 32272, name = ni.spell.info(32272)},
   TeleportUndercity = {id = 3563, name = ni.spell.info(3563)},
   --Fire
   FireBlast = {id = 10199, name = ni.spell.info(10199)},
   FireWard = {id = 10223, name = ni.spell.info(10223)},
   Fireball = {id = 38692, name = ni.spell.info(38692)},
   Flamestrike = {id = 10216, name = ni.spell.info(10216)},
   MoltenArmor = {id = 30482, name = ni.spell.info(30482)},
   Scorch = {id = 10207, name = ni.spell.info(10207)},
   --Frost
   Blizzard = {id = 27085, name = ni.spell.info(27085)},
   ColdSnap = {id = 11958, name = ni.spell.info(11958)},
   ConeofCold = {id = 27087, name = ni.spell.info(27087)},
   DeepFreeze = {id = 44572, name = ni.spell.info(44572)},
   FrostArmor = {id = 7301, name = ni.spell.info(7301)},
   FrostNova = {id = 10230, name = ni.spell.info(10230)},
   FrostWard = {id = 10177, name = ni.spell.info(10177)},
   Frostbolt = {id = 38697, name = ni.spell.info(38697)},
   IceArmor = {id = 10219, name = ni.spell.info(10219)},
   IceBarrier = {id = 33405, name = ni.spell.info(33405)},
   IceBlock = {id = 45438, name = ni.spell.info(45438)},
   IceLance = {id = 30455, name = ni.spell.info(30455)},
   IcyVeins = {id = 12472, name = ni.spell.info(12472)},
   SummonWaterElemental = {id = 31687, name = ni.spell.info(31687)}
}

local t,
   p = "target", "player"

local cache = {
   mana = 0,
   moving = true,
   targets = {},
   target_count = 0
}

local queue = {
   "Pause",
   "Cache",
   "GCD",
   "WaitForCast",
   "ArcaneIntellect",
   "ArcaneIntellectGroup",
   "MageArmor",
   "FrostArmor",
   "SummonWaterElemental",
   "PauseTarget",
   "IceBarrier",
   "ManaGem",
   "Evocation",
   "Counterspell",
   "PetAttack",
   "ConeofCold",
   "Blizzard",
   "IceLance",
   "DeepFreeze",
   "Fireball",
   "Frostbolt",
   "Shoot"
}

local ManaGem = ni.item.info(22044)
local BrainFreeze = 57761
local FingersofFrost = 74396
local Frostbite = 12494
local GlyphofEternalWater = ni.player.has_glyph(70937)

local abilities = {
   ["Pause"] = function()
      if ni.player.mounted() or ni.player.is_dead_or_ghost() then
         return true
      end
   end,
   ["PauseTarget"] = function()
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
   ["WaitForCast"] = function()
      if ni.player.casting() or ni.player.is_channeling() then
         return true
      end
   end,
   ["Cache"] = function()
      ni.members.update()
      ni.objects.update()
      cache.mana = ni.player.power_percent("mana")
      cache.moving = ni.player.is_moving()
      cache.targets = ni.unit.enemies_in_range(t, 10)
      cache.target_count = ni.table.length(cache.targets)
   end,
   ["Fireball"] = function()
      if ni.player.buff(BrainFreeze) and ni.spell.valid(spells.Fireball.name, t, true, true) then
         ni.spell.cast(spells.Fireball.name, t)
         return true
      end
   end,
   ["Frostbolt"] = function()
      if not cache.moving and ni.spell.valid(spells.Frostbolt.name, t, true, true) then
         ni.spell.cast(spells.Frostbolt.name, t)
         return true
      end
   end,
   ["MageArmor"] = function()
      if not ni.player.buff(spells.MageArmor.name) and ni.spell.available(spells.MageArmor.name) then
         ni.spell.cast(spells.MageArmor.name)
         return true
      end
   end,
   ["FrostArmor"] = function()
      if
         not ni.spell.known(spells.MageArmor.name) and not ni.player.buff(spells.FrostArmor.name) and
            ni.spell.available(spells.FrostArmor.name)
       then
         ni.spell.cast(spells.FrostArmor.name)
         return true
      end
   end,
   ["ArcaneIntellect"] = function()
      if not ni.player.buff(spells.ArcaneIntellect.name) and ni.spell.available(spells.ArcaneIntellect.id) then
         ni.spell.cast(spells.ArcaneIntellect.name, p)
         return true
      end
   end,
   ["ArcaneIntellectGroup"] = function()
      for guid, value in ni.table.opairs(ni.members) do
         if
            not ni.unit.buff(guid, spells.ArcaneIntellect.name) and
               ni.spell.valid(spells.ArcaneIntellect.id, guid, false, true, true) and
               ni.unit.power(guid, "mana") > 100
          then
            ni.spell.cast(spells.ArcaneIntellect.name, guid)
            return true
         end
      end
   end,
   ["Evocation"] = function()
      if ni.spell.available(spells.Evocation.id) and not cache.moving and cache.mana < 20 then
         ni.spell.cast(spells.Evocation.name)
         return true
      end
   end,
   ["Blizzard"] = function()
      if
         not cache.moving and ni.spell.available(spells.Blizzard.id) and ni.spell.in_range(spells.Frostbolt.id, t) and
            cache.target_count >= 2
       then
         ni.spell.cast_on(spells.Blizzard.name, t)
         return true
      end
   end,
   ["Shoot"] = function()
      if
         ni.spell.valid(spells.Shoot.name, t, true, true) and not ni.spell.is_current(spells.Shoot.id) and
            ni.gear.id(18) and
            not cache.moving
       then
         ni.spell.cast(spells.Shoot.id, t)
         return true
      end
   end,
   ["ConeofCold"] = function()
      if ni.player.is_facing(t, 70) and ni.player.distance(t) < 8 and ni.spell.available(spells.ConeofCold.id) then
         ni.spell.cast(spells.ConeofCold.name)
         return true
      end
   end,
   ["ConjureManaGem"] = function()
      if
         not ni.item.is_present(ManaGem) and ni.spell.available(spells.ConjureManaGem.id) and cache.mana > 90 and
            not cache.moving
       then
         ni.spell.cast(spells.ConjureManaGem.name)
         return true
      end
   end,
   ["ManaGem"] = function()
      if ni.item.is_present(ManaGem) and cache.mana < 20 and ni.item.cooldown(ManaGem) == 0 then
         ni.item.use(ManaGem)
         return true
      end
   end,
   ["Counterspell"] = function()
      if ni.spell.valid(spells.Counterspell.id, t, true, true) and ni.unit.can_interupt(t, 30) then
         ni.spell.cast(spells.Counterspell.id, t)
         return true
      end
   end,
   ["SummonWaterElemental"] = function()
      if ni.spell.available(spells.SummonWaterElemental.id) and GlyphofEternalWater and not ni.pet.exists() then
         ni.spell.cast(spells.SummonWaterElemental.id)
         return true
      end
   end,
   ["PetAttack"] = function()
      if ni.pet.exists() and ni.pet.current_target() ~= ni.unit.guid(t) then
         ni.pet.attack()
      end
   end,
   ["DeepFreeze"] = function()
      if ni.spell.valid(spells.DeepFreeze.name, t, true, true) and ni.spell.is_usable(spells.DeepFreeze.name) then
         ni.spell.cast(spells.DeepFreeze.name)
         return true
      end
   end,
   ["IceBarrier"] = function()
      if
         ni.spell.available(spells.IceBarrier.id) and ni.unit.guid("targettarget") == ni.player.guid() and
            not ni.player.buff(spells.IceBarrier.name)
       then
         ni.spell.cast(spells.IceBarrier.name)
         return true
      end
   end,
   ["IceLance"] = function()
      if
         ni.spell.valid(spells.IceLance.name, t, true, true) and
            (ni.player.buff(FingersofFrost) or ni.unit.debuff(t, Frostbite, p) or
               ni.unit.debuff(t, spells.FrostNova.name, p))
       then
         ni.spell.cast(spells.IceLance.id)
         return true
      end
   end
}

ni.profile.new("Frost_Wrath", queue, abilities)
