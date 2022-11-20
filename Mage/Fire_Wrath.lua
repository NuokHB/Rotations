--Version: 12340
local ni = ...

local spells = {
--General
ArcaneAffinity = {id = 28877, name = ni.spell.info(28877)},
ArcaneTorrent = {id = 28730, name = ni.spell.info(28730)},
AutoAttack = {id = 6603, name = ni.spell.info(6603)},
ColdWeatherFlying = {id = 54197, name = ni.spell.info(54197)},
Dodge = {id = 81, name = ni.spell.info(81)},
MagicResistance = {id = 822, name = ni.spell.info(822)},
Shoot = {id = 5019, name = ni.spell.info(5019)},
--Arcane
AmplifyMagic = {id = 43017, name = ni.spell.info(43017)},
ArcaneBlast = {id = 42897, name = ni.spell.info(42897)},
ArcaneBrilliance = {id = 43002, name = ni.spell.info(43002)},
ArcaneExplosion = {id = 42921, name = ni.spell.info(42921)},
ArcaneIntellect = {id = 42995, name = ni.spell.info(42995)},
ArcaneMissiles = {id = 42846, name = ni.spell.info(42846)},
Blink = {id = 1953, name = ni.spell.info(1953)},
ConjureFood = {id = 33717, name = ni.spell.info(33717)},
ConjureManaGem = {id = 42985, name = ni.spell.info(42985)},
ConjureRefreshment = {id = 42956, name = ni.spell.info(42956)},
ConjureWater = {id = 27090, name = ni.spell.info(27090)},
Counterspell = {id = 2139, name = ni.spell.info(2139)},
DalaranBrilliance = {id = 61316, name = ni.spell.info(61316)},
DalaranIntellect = {id = 61024, name = ni.spell.info(61024)},
DampenMagic = {id = 43015, name = ni.spell.info(43015)},
Evocation = {id = 12051, name = ni.spell.info(12051)},
FocusMagic = {id = 54646, name = ni.spell.info(54646)},
Invisibility = {id = 66, name = ni.spell.info(66)},
MageArmor = {id = 43024, name = ni.spell.info(43024)},
ManaShield = {id = 43020, name = ni.spell.info(43020)},
MirrorImage = {id = 55342, name = ni.spell.info(55342)},
Polymorph = {id = 61780, name = ni.spell.info(61780)},
PortalDalaran = {id = 53142, name = ni.spell.info(53142)},
PortalOrgrimmar = {id = 11417, name = ni.spell.info(11417)},
PortalShattrath = {id = 35717, name = ni.spell.info(35717)},
PortalSilvermoon = {id = 32267, name = ni.spell.info(32267)},
PortalStonard = {id = 49361, name = ni.spell.info(49361)},
PortalThunderBluff = {id = 11420, name = ni.spell.info(11420)},
PortalUndercity = {id = 11418, name = ni.spell.info(11418)},
RemoveCurse = {id = 475, name = ni.spell.info(475)},
RitualofRefreshment = {id = 58659, name = ni.spell.info(58659)},
SlowFall = {id = 130, name = ni.spell.info(130)},
Spellsteal = {id = 30449, name = ni.spell.info(30449)},
TeleportDalaran = {id = 53140, name = ni.spell.info(53140)},
TeleportOrgrimmar = {id = 3567, name = ni.spell.info(3567)},
TeleportShattrath = {id = 35715, name = ni.spell.info(35715)},
TeleportSilvermoon = {id = 32272, name = ni.spell.info(32272)},
TeleportStonard = {id = 49358, name = ni.spell.info(49358)},
TeleportThunderBluff = {id = 3566, name = ni.spell.info(3566)},
TeleportUndercity = {id = 3563, name = ni.spell.info(3563)},
--Fire
Combustion = {id = 11129, name = ni.spell.info(11129)},
DragonsBreath = {id = 42950, name = ni.spell.info(42950)},
FireBlast = {id = 42873, name = ni.spell.info(42873)},
FireWard = {id = 43010, name = ni.spell.info(43010)},
Fireball = {id = 42833, name = ni.spell.info(42833)},
Flamestrike = {id = 42926, name = ni.spell.info(42926)},
FrostfireBolt = {id = 47610, name = ni.spell.info(47610)},
LivingBomb = {id = 55360, name = ni.spell.info(55360)},
MoltenArmor = {id = 43046, name = ni.spell.info(43046)},
Pyroblast = {id = 42891, name = ni.spell.info(42891)},
Scorch = {id = 42859, name = ni.spell.info(42859)},
--Frost
Blizzard = {id = 42940, name = ni.spell.info(42940)},
ConeofCold = {id = 42931, name = ni.spell.info(42931)},
FrostArmor = {id = 7301, name = ni.spell.info(7301)},
FrostNova = {id = 42917, name = ni.spell.info(42917)},
FrostWard = {id = 43012, name = ni.spell.info(43012)},
Frostbolt = {id = 42842, name = ni.spell.info(42842)},
IceArmor = {id = 43008, name = ni.spell.info(43008)},
IceBlock = {id = 45438, name = ni.spell.info(45438)},
IceLance = {id = 42914, name = ni.spell.info(42914)},
}


local enables = {
   ["Blizzard"] = true,
   ["Spellsteal"] = true,
   ["ArcaneIntellectGroup"] = false,
   ["Trinket1"] = true,
   ["Trinket2"] = true,
}
local values = {
   ["BlizzardCount"] = 2
}
local menus = {
   ["Armor"] = spells.MoltenArmor.name
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
   settingsfile = ni.player.guid() .. "_fire_mage_wrath.json",
   callback = GUICallback,
   {
      type = "combobox",
      text = "Armor Selection",
      menu = {
         {selected = (menus["Armor"] == spells.IceArmor.name), text = spells.IceArmor.name},
         {selected = (menus["Armor"] == spells.FrostArmor.name), text = spells.FrostArmor.name},
         {selected = (menus["Armor"] == spells.MoltenArmor.name), text = spells.MoltenArmor.name},
         {selected = (menus["Armor"] == spells.MageArmor.name), text = spells.MageArmor.name}
      },
      key = "Armor"
   },
   {type = "separator"},
   {type = "label", text = "Fire Mage by Nuok"}
}

local t, p = "target", "player"

local cache = {
   mana = 0,
   moving = true,
   targets = {},
   target_count = 0,
   is_boss = false
}

local queue = {
   "Pause",
   "Cache",
   "GCD",
   "WaitForCast",
   "ArcaneIntellect",
   "ArcaneIntellectGroup",
   "Armor",
   "Trinkets",
   "Combustion",
   "MirrorImage",
   "Pyroblast",
   "LivingBomb",
   "Flamestrike",
   "DragonsBreath",
   "Fireball",
}

local ManaGem = ni.item.info(33312)
local Firestarter = 54741

local abilities = {
   ["Pause"] = function()
      if ni.mount.is_mounted() or ni.player.is_dead_or_ghost() then
         return true
      end
   end,
   ["PauseTarget"] = function()
      if
         ni.mount.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
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
      cache.mana = ni.player.power_percent("mana")
      cache.moving = ni.player.is_moving()
      cache.targets = ni.unit.enemies_in_range(t, 10)
      cache.target_count = ni.table.length(cache.targets)
      cache.is_boss = ni.unit.is_boss(t)
   end,
   ["Fireball"] = function()
      if ni.spell.valid(spells.Fireball.name, t, true, true) and not cache.moving then
         ni.spell.cast(spells.Fireball.name, t)
         return true
      end
   end,
   ["LivingBomb"] = function()
      if ni.spell.valid(spells.LivingBomb.name, t, true, true) and not ni.unit.debuff(t, spells.LivingBomb.id, p) then
         ni.spell.cast(spells.LivingBomb.name, t)
         return true
      end
   end,
   ["Pyroblast"] = function()
      if ni.spell.valid(spells.Pyroblast.name, t, true, true) and ni.player.buff("Hot Streak") then
         ni.spell.cast(spells.Pyroblast.name, t)
         return true
      end
   end,
   ["Flamestrike"] = function()
      if ni.spell.valid(spells.Fireball.name, t, true, true) and ni.player.buff(Firestarter) then
         ni.spell.cast_on(spells.Flamestrike.name, t)
         return true
      end
   end,
   ["DragonsBreath"] = function()
      if ni.player.is_facing(t, 70) and ni.player.distance(t) < 8 and ni.spell.available(spells.DragonsBreath.name) then
         ni.spell.cast(spells.DragonsBreath.name)
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
   ["Trinkets"] = function ()
      -- Slots 13, 14
      if enables["Trinket1"] and ni.spell.valid(spells.Fireball.name, t, true, true) and cache.is_boss then
         if ni.gear.spell(13) and ni.gear.cooldown_remaining(13) == 0 then
            ni.gear.use(13)
         end
      end
      if enables["Trinket2"] and ni.spell.valid(spells.Fireball.name, t, true, true) and cache.is_boss then
         if ni.gear.spell(14) and ni.gear.cooldown_remaining(14) == 0 then
            ni.gear.use(14)
         end
      end
   end,
   ["Combustion"] = function ()
      if ni.spell.available(spells.Combustion.name) and cache.is_boss and ni.spell.valid(spells.Fireball.name, t, true, true) then
         ni.spell.delay_cast(spells.Combustion.name, p, 0.2)
      end
   end,
   ["MirrorImage"] = function ()
      if ni.spell.available(spells.MirrorImage.name) and cache.is_boss and ni.spell.valid(spells.Fireball.name, t, true, true) then
         ni.spell.delay_cast(spells.MirrorImage.name, p, 0.2)
      end
   end,
}

ni.profile.new("Fire_Wrath", queue, abilities, ui)
