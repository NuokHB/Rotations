--Version: 12340
local ni = ...

local spells = {
--General
 ArcaneAffinity = {id = 28877, name = ni.spell.info(28877)},
 ArcaneTorrent = {id = 28730, name = ni.spell.info(28730)},
 AutoAttack = {id = 6603, name = ni.spell.info(6603)},
 Disenchant = {id = 13262, name = ni.spell.info(13262)},
 Dodge = {id = 81, name = ni.spell.info(81)},
 Enchanting = {id = 7411, name = ni.spell.info(7411)},
 MagicResistance = {id = 822, name = ni.spell.info(822)},
 Shoot = {id = 5019, name = ni.spell.info(5019)},
--Arcane
 AmplifyMagic = {id = 33946, name = ni.spell.info(33946)},
 ArcaneBlast = {id = 42894, name = ni.spell.info(42894)},
 ArcaneBrilliance = {id = 27127, name = ni.spell.info(27127)},
 ArcaneExplosion = {id = 27082, name = ni.spell.info(27082)},
 ArcaneIntellect = {id = 27126, name = ni.spell.info(27126)},
 ArcaneMissiles = {id = 42843, name = ni.spell.info(42843)},
 Blink = {id = 1953, name = ni.spell.info(1953)},
 ConjureFood = {id = 33717, name = ni.spell.info(33717)},
 ConjureManaGem = {id = 27101, name = ni.spell.info(27101)},
 ConjureRefreshment = {id = 42955, name = ni.spell.info(42955)},
 ConjureWater = {id = 27090, name = ni.spell.info(27090)},
 Counterspell = {id = 2139, name = ni.spell.info(2139)},
 DampenMagic = {id = 33944, name = ni.spell.info(33944)},
 Evocation = {id = 12051, name = ni.spell.info(12051)},
 FocusMagic = {id = 54646, name = ni.spell.info(54646)},
 Invisibility = {id = 66, name = ni.spell.info(66)},
 MageArmor = {id = 43023, name = ni.spell.info(43023)},
 ManaShield = {id = 43019, name = ni.spell.info(43019)},
 Polymorph = {id = 12826, name = ni.spell.info(12826)},
 PortalDalaran = {id = 53142, name = ni.spell.info(53142)},
 PortalShattrath = {id = 35717, name = ni.spell.info(35717)},
 PortalSilvermoon = {id = 32267, name = ni.spell.info(32267)},
 PortalUndercity = {id = 11418, name = ni.spell.info(11418)},
 RemoveCurse = {id = 475, name = ni.spell.info(475)},
 RitualofRefreshment = {id = 43987, name = ni.spell.info(43987)},
 SlowFall = {id = 130, name = ni.spell.info(130)},
 Spellsteal = {id = 30449, name = ni.spell.info(30449)},
 TeleportDalaran = {id = 53140, name = ni.spell.info(53140)},
 TeleportShattrath = {id = 35715, name = ni.spell.info(35715)},
 TeleportSilvermoon = {id = 32272, name = ni.spell.info(32272)},
 TeleportUndercity = {id = 3563, name = ni.spell.info(3563)},
--Fire
 FireBlast = {id = 42872, name = ni.spell.info(42872)},
 FireWard = {id = 27128, name = ni.spell.info(27128)},
 Fireball = {id = 42832, name = ni.spell.info(42832)},
 Flamestrike = {id = 42925, name = ni.spell.info(42925)},
 FrostfireBolt = {id = 44614, name = ni.spell.info(44614)},
 MoltenArmor = {id = 43045, name = ni.spell.info(43045)},
 Scorch = {id = 42858, name = ni.spell.info(42858)},
--Frost
 Blizzard = {id = 42939, name = ni.spell.info(42939)},
 ColdSnap = {id = 11958, name = ni.spell.info(11958)},
 ConeofCold = {id = 42930, name = ni.spell.info(42930)},
 DeepFreeze = {id = 44572, name = ni.spell.info(44572)},
 FrostArmor = {id = 7301, name = ni.spell.info(7301)},
 FrostNova = {id = 42917, name = ni.spell.info(42917)},
 FrostWard = {id = 32796, name = ni.spell.info(32796)},
 Frostbolt = {id = 42841, name = ni.spell.info(42841)},
 IceArmor = {id = 27124, name = ni.spell.info(27124)},
 IceBarrier = {id = 43038, name = ni.spell.info(43038)},
 IceBlock = {id = 45438, name = ni.spell.info(45438)},
 IceLance = {id = 42913, name = ni.spell.info(42913)},
 IcyVeins = {id = 12472, name = ni.spell.info(12472)},
 SummonWaterElemental = {id = 31687, name = ni.spell.info(31687)},
--Pet
 Waterbolt = {id = 31707, name = ni.spell.info(31707)},
}

local enables = {
   ["Blizzard"] = true,
   ["Spellsteal"] = true,
   ["ArcaneIntellectGroup"] = false,
}
local values = {
   ["BlizzardCount"] = 3
}
local menus = {
   ["Armor"] = spells.IceArmor.name
}

local function GUICallback(key, item_type, value)
   ni.utilities.log("GUICallback " .. key .. " " .. item_type .. " " .. tostring(value) .. " ")
   if item_type == "enabled" then
      enables[key] = value
   elseif item_type == "value" then
      values[key] = value
   elseif item_type == "menu" then
      menus[key] = value
   end
end

local ui = {
   settingsfile = ni.player.guid() .. "_frost_mage_wrath.json",
   callback = GUICallback,
   {type = "label", text = "Armor Selection"},
   {
      type = "combobox",
      menu = {
         {selected = (menus["Armor"] == spells.IceArmor.name), text = spells.IceArmor.name},
         {selected = (menus["Armor"] == spells.FrostArmor.name), text = spells.FrostArmor.name},
         {selected = (menus["Armor"] == spells.MoltenArmor.name), text = spells.MoltenArmor.name},
         {selected = (menus["Armor"] == spells.MageArmor.name), text = spells.MageArmor.name}
      },
      key = "Armor"
   },
   {type = "separator"},
   {
      type = "checkbox",
      text = spells.ArcaneIntellect.name .. " on Group",
      enabled = enables["ArcaneIntellectGroup"],
      key = "ArcaneIntellectGroup"
   },
   {type = "separator"},
   {
      type = "checkbox",
      text = spells.Blizzard.name,
      enabled = enables["Blizzard"],
      key = "Blizzard"
   },
   {
      type = "slider",
      text = spells.Blizzard.name,
      value = values["BlizzardCount"],
      min = 1,
      max = 10,
      key = "BlizzardCount"
   },
   {type = "separator"},
   {
      type = "checkbox",
      text = spells.Spellsteal.name,
      enabled = enables["Spellsteal"],
      key = "Spellsteal"
   },
   {type = "separator"},
   {type = "label", text = "Frost Mage by Nuok"}
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
   "Armor",
   "SummonWaterElemental",
   "PauseTarget",
   "IceBarrier",
   "ManaGem",
   "Evocation",
   "Counterspell",
   "Spellsteal",
   "PetAttack",
   "ConeofCold",
   "Blizzard",
   "DeepFreeze",
   "IceLance",
   "FrostfireBolt",
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
   ["FrostfireBolt"] = function()
      if ni.player.buff(BrainFreeze) and ni.spell.valid(spells.FrostfireBolt.name, t, true, true) then
         ni.spell.cast(spells.FrostfireBolt.name, t)
         return true
      end
   end,
   ["Fireball"] = function()
      if not ni.spell.known(spells.FrostfireBolt.name) and ni.player.buff(BrainFreeze) and ni.spell.valid(spells.Fireball.name, t, true, true) then
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
   ["Armor"] = function()
      if menus["Armor"] == spells.MoltenArmor.name and not ni.player.buff(spells.MoltenArmor.name) and
            ni.spell.available(spells.MoltenArmor.name)
       then
         ni.spell.cast(spells.MoltenArmor.name)
         return true
      elseif menus["Armor"] == spells.IceArmor.name and not ni.player.buff(spells.IceArmor.name) and
            ni.spell.available(spells.IceArmor.name)
       then
         ni.spell.cast(spells.IceArmor.name)
         return true
      elseif menus["Armor"] == spells.FrostArmor.name and not ni.player.buff(spells.FrostArmor.name) and
            ni.spell.available(spells.FrostArmor.name)
       then
         ni.spell.cast(spells.FrostArmor.name)
         return true
      elseif menus["Armor"] == spells.MageArmor.name and not ni.player.buff(spells.MageArmor.name) and
            ni.spell.available(spells.MageArmor.name)
       then
         ni.spell.cast(spells.MageArmor.name)
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
      if enables["ArcaneIntellectGroup"] then
         for guid, value in ni.table.opairs(ni.members) do
            if not ni.unit.buff(guid, spells.ArcaneIntellect.name) and
               ni.spell.valid(spells.ArcaneIntellect.id, guid, false, true, true) and
               ni.unit.power(guid, "mana") > 100
            then
               ni.spell.cast(spells.ArcaneIntellect.name, guid)
               return true
            end
         end
      end
   end,
   ["Evocation"] = function()
      if ni.spell.available(spells.Evocation.name) and not cache.moving and cache.mana < 20 then
         ni.spell.cast(spells.Evocation.name)
         return true
      end
   end,
   ["Blizzard"] = function()
      if enables["Blizzard"] and not cache.moving and ni.spell.available(spells.Blizzard.name) and
         ni.spell.in_range(spells.Frostbolt.name, t) and
         cache.target_count >= values["BlizzardCount"]
       then
         ni.spell.cast_on(spells.Blizzard.name, t)
         return true
      end
   end,
   ["Shoot"] = function()
      if ni.spell.valid(spells.Shoot.name, t, true, true) and not ni.spell.is_current(spells.Shoot.id) and
            ni.gear.id(18) and
            not cache.moving
       then
         ni.spell.cast(spells.Shoot.id, t)
         return true
      end
   end,
   ["ConeofCold"] = function()
      if ni.player.is_facing(t, 70) and ni.player.distance(t) < 8 and ni.spell.available(spells.ConeofCold.name) then
         ni.spell.cast(spells.ConeofCold.name)
         return true
      end
   end,
   ["ConjureManaGem"] = function()
      if not ni.item.is_present(ManaGem) and ni.spell.available(spells.ConjureManaGem.name) and cache.mana > 90 and
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
         ni.spell.available(spells.IceBarrier.name) and ni.unit.guid("targettarget") == ni.player.guid() and
            not ni.player.buff(spells.IceBarrier.name)
       then
         ni.spell.cast(spells.IceBarrier.name)
         return true
      end
   end,
   ["IceLance"] = function()
      if ni.spell.valid(spells.IceLance.name, t, true, true) and
            (ni.player.buff(FingersofFrost) or ni.unit.debuff(t, Frostbite, p) or
               ni.unit.debuff(t, spells.FrostNova.name, p) or
               ni.unit.debuff(t, spells.DeepFreeze.id, p)
            )
       then
         ni.spell.cast(spells.IceLance.name)
         return true
      end
   end,
   ["Spellsteal"] = function()
      if enables["Spellsteal"] and ni.spell.valid(spells.Spellsteal.name, t, true, true) then
         local buffs = ni.unit.buffs(t)
         for k, v in ni.table.pairs(buffs) do
            if v.buffType == "Magic" and v.isStealable ~= nil then
               ni.spell.cast(spells.Spellsteal.name, t)
               return true
            end
         end
      end
   end
}

ni.profile.new("Frost_Wrath", queue, abilities, ui)
