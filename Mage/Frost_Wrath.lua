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
   AmplifyMagic = {id = 1008, name = ni.spell.info(1008)},
   ArcaneExplosion = {id = 8437, name = ni.spell.info(8437)},
   ArcaneIntellect = {id = 1461, name = ni.spell.info(1461)},
   ArcaneMissiles = {id = 5145, name = ni.spell.info(5145)},
   Blink = {id = 1953, name = ni.spell.info(1953)},
   ConjureFood = {id = 990, name = ni.spell.info(990)},
   ConjureManaGem = {id = 759, name = ni.spell.info(759)},
   ConjureWater = {id = 5506, name = ni.spell.info(5506)},
   Counterspell = {id = 2139, name = ni.spell.info(2139)},
   DampenMagic = {id = 8450, name = ni.spell.info(8450)},
   Evocation = {id = 12051, name = ni.spell.info(12051)},
   ManaShield = {id = 8494, name = ni.spell.info(8494)},
   Polymorph = {id = 12824, name = ni.spell.info(12824)},
   RemoveCurse = {id = 475, name = ni.spell.info(475)},
   SlowFall = {id = 130, name = ni.spell.info(130)},
   TeleportSilvermoon = {id = 32272, name = ni.spell.info(32272)},
   --Fire
   FireBlast = {id = 2138, name = ni.spell.info(2138)},
   FireWard = {id = 543, name = ni.spell.info(543)},
   Fireball = {id = 8400, name = ni.spell.info(8400)},
   Flamestrike = {id = 2121, name = ni.spell.info(2121)},
   Scorch = {id = 8444, name = ni.spell.info(8444)},
   --Frost
   Blizzard = {id = 6141, name = ni.spell.info(6141)},
   ConeofCold = {id = 120, name = ni.spell.info(120)},
   FrostArmor = {id = 7301, name = ni.spell.info(7301)},
   FrostNova = {id = 865, name = ni.spell.info(865)},
   FrostWard = {id = 6143, name = ni.spell.info(6143)},
   Frostbolt = {id = 8406, name = ni.spell.info(8406)},
   IcyVeins = {id = 12472, name = ni.spell.info(12472)}
}

local t, p = "target", "player"

local cache = {
   mana = 0,
   moving = true,
   targets = {},
   target_count = 0
}

local queue = {
   "Pause",
   "Cache",
   "WaitForCast",
   "GCD",
   "ArcaneIntellect",
   "FrostArmor",
   "ManaGem",
   "Evocation",
   "ConeofCold",
   "Blizzard",
   "Frostbolt",
   "Shoot"
}

local ManaGem = ni.item.info(5514)

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
      if not cache.moving and ni.spell.valid(spells.Fireball.name, t, true, true) then
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
   ["FrostArmor"] = function()
      if not ni.player.buff(spells.FrostArmor.name) and ni.spell.available(spells.FrostArmor.name) then
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
            ni.gear.id(18)
       then
         ni.spell.cast(spells.Shoot.id, t)
         return true
      end
   end,
   ["ConeofCold"] = function ()
      if ni.player.is_facing(t, 90) and ni.player.distance(t) < 10 and ni.spell.available(spells.ConeofCold.id) then
         ni.spell.cast(spells.ConeofCold.name)
         return true
      end
   end,
   ["ConjureManaGem"] = function ()
      if not ni.item.is_present(ManaGem) and ni.spell.available(spells.ConjureManaGem.id) then
         ni.spell.cast(spells.ConjureManaGem.name)
         return true
      end
   end,
   ["ManaGem"] = function ()
      if ni.item.is_present(ManaGem) and cache.mana < 20 and ni.item.cooldown(ManaGem) == 0 then
         ni.item.use(ManaGem)
         return true
      end
   end
}

ni.profile.new("Frost_Wrath", queue, abilities)
