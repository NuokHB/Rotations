--Version: 12340
local ni = ...
local spells = {
--General
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   Cultivation = {id = 20552, name = ni.spell.info(20552)},
   Dodge = {id = 81, name = ni.spell.info(81)},
   DualWield = {id = 674, name = ni.spell.info(674)},
   Endurance = {id = 20550, name = ni.spell.info(20550)},
   FirstAid = {id = 10846, name = ni.spell.info(10846)},
   NatureResistance = {id = 20551, name = ni.spell.info(20551)},
   Parry = {id = 3127, name = ni.spell.info(3127)},
   Runeforging = {id = 53428, name = ni.spell.info(53428)},
   WarStomp = {id = 20549, name = ni.spell.info(20549)},
--Blood
   AbominationsMight = {id = 53138, name = ni.spell.info(53138)},
   BloodBoil = {id = 48721, name = ni.spell.info(48721)},
   BloodPresence = {id = 48266, name = ni.spell.info(48266)},
   BloodStrike = {id = 49926, name = ni.spell.info(49926)},
   ForcefulDeflection = {id = 49410, name = ni.spell.info(49410)},
   HeartStrike = {id = 55258, name = ni.spell.info(55258)},
   Pestilence = {id = 50842, name = ni.spell.info(50842)},
   RuneTap = {id = 48982, name = ni.spell.info(48982)},
   Strangulate = {id = 47476, name = ni.spell.info(47476)},
   VampiricBlood = {id = 55233, name = ni.spell.info(55233)},
--Frost
   ChainsofIce = {id = 45524, name = ni.spell.info(45524)},
   FrostFever = {id = 59921, name = ni.spell.info(59921)},
   FrostPresence = {id = 48263, name = ni.spell.info(48263)},
   IceboundFortitude = {id = 48792, name = ni.spell.info(48792)},
   IcyTouch = {id = 49896, name = ni.spell.info(49896)},
   MindFreeze = {id = 47528, name = ni.spell.info(47528)},
   Obliterate = {id = 49020, name = ni.spell.info(49020)},
   PathofFrost = {id = 3714, name = ni.spell.info(3714)},
   RunicFocus = {id = 61455, name = ni.spell.info(61455)},
--Unholy
   BloodPlague = {id = 59879, name = ni.spell.info(59879)},
   DeathandDecay = {id = 43265, name = ni.spell.info(43265)},
   DeathCoil = {id = 49892, name = ni.spell.info(49892)},
   DeathGrip = {id = 49576, name = ni.spell.info(49576)},
   DeathStrike = {id = 49999, name = ni.spell.info(49999)},
   PlagueStrike = {id = 49917, name = ni.spell.info(49917)},
   RaiseDead = {id = 46584, name = ni.spell.info(46584)},
}

local queue = {
   "Pause",
   "Cache",
   "AutoAttack",
   "MindFreeze",
   "RuneTap",
   "GCD",
   "Presence",
   "MindFreeze",
   "DeathandDecay",
   "Pestilence",
   "IcyTouch",
   "PlagueStrike",
   "DeathStrike",
   "HeartStrike",
   "BloodStrike",
   "DeathCoil",
}

local enables = {}
local values = {
   ["DeathandDecay"] = 2
}
local menus = {
   ["Presence"] = spells.BloodPresence.name
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
   settingsfile = ni.player.guid() .. "_blood_dk_wrath.json",
   callback = GUICallback,
   {type = "separator"},
   {
      type = "combobox",
      text = "Presence Selection",
      menu = {
         {selected = (menus["Presence"] == spells.BloodPresence.name), text = spells.BloodPresence.name},
         {selected = (menus["Presence"] == spells.FrostPresence.name), text = spells.FrostPresence.name},
      },
      key = "Presence"
   },
   {type = "separator"},
}


local t, p = "target", "player"
local cache = {
	blood_plauge = 0,
	frost_fever = 0,
	targets = nil,
   target_count = 0,
	blood_rune = 0,
   runicpower = 0
}

local abilities = {
   ["Pause"] = function()
      if ni.player.mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t)
       then
         return true
      end
   end,
   ["GCD"] = function ()
      if ni.spell.on_gcd() then
         return true
      end
   end,
   ["Cache"] = function()
		_, cache.blood_rune = ni.runes.blood.status()
		cache.blood_plauge = ni.unit.debuff_remaining(t, 55078, p)
		cache.frost_fever = ni.unit.debuff_remaining(t, 55095, p)
      cache.runicpower = ni.player.power(6)
      ni.objects.update()
		cache.targets = ni.unit.enemies_in_range(t, 10)
      cache.target_count = ni.table.length(cache.targets)
	end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["Presence"] = function ()
      if menus["Presence"] == spells.FrostPresence.name and not ni.player.buff(spells.FrostPresence.id) and ni.spell.available(spells.FrostPresence.name) then
         ni.spell.cast(spells.FrostPresence.name)
         return true
      end
      if menus["Presence"] == spells.BloodPresence.name and not ni.player.buff(spells.BloodPresence.id) and ni.spell.available(spells.BloodPresence.name) then
         ni.spell.cast(spells.BloodPresence.name)
         return true
      end
   end,
   ["IcyTouch"] = function()
      if cache.frost_fever < 1.5 and ni.spell.valid(spells.IcyTouch.name, t, true, true) then
         ni.spell.cast(spells.IcyTouch.name, t)
         return true
      end
   end,
   ["PlagueStrike"] = function()
      if cache.blood_plauge < 1.5 and ni.spell.valid(spells.PlagueStrike.name, t, true, true) then
         ni.spell.cast(spells.PlagueStrike.name, t)
         return true
      end
   end,
   ["BloodStrike"] = function()
      if ni.spell.valid(spells.BloodStrike.name, t, true, true) then
         ni.spell.cast(spells.BloodStrike.name, t)
         return true
      end
   end,
   ["DeathStrike"] = function()
      if ni.spell.valid(spells.DeathStrike.name, t, true, true) then
         ni.spell.cast(spells.DeathStrike.name, t)
         return true
      end
   end,
   ["HeartStrike"] = function()
      if ni.spell.valid(spells.HeartStrike.name, t, true, true) then
         ni.spell.cast(spells.HeartStrike.name, t)
         return true
      end
   end,
   ["DeathCoil"] = function()
      if cache.runicpower > 80 and ni.spell.valid(spells.DeathCoil.name, t, true, true) then
         ni.spell.cast(spells.DeathCoil.name, t)
         return true
      end
   end,
   ["Pestilence"] = function ()
      local should_cast = false
      if cache.blood_plauge > 1 and cache.frost_fever > 1 and cache.target_count >= 2 then
         if ni.spell.valid(spells.Pestilence.name, t, true, true) then
            for guid in ni.table.opairs(cache.targets) do
               if ni.unit.debuff_remaining(guid, 55078, p) < 2 or ni.unit.debuff_remaining(guid, 55095, p) < 2 then
                  should_cast = true
               end
            end
            if should_cast then
               ni.spell.cast(spells.Pestilence.name, t)
               return true
            end
         end
      end
   end,
   ["RuneTap"] = function ()
      if ni.spell.available(spells.RuneTap.name) and ni.player.hp() < 80 then
         ni.spell.cast(spells.RuneTap.name)
      end
   end,
   ["MindFreeze"] = function()
      if ni.spell.valid(spells.MindFreeze.id, t, true, true) and ni.unit.can_interupt(t, 30) then
         ni.spell.cast(spells.MindFreeze.id, t)
         return true
      end
   end,
   ["DeathandDecay"] = function ()
      if ni.spell.available(spells.DeathandDecay.name) and cache.target_count >= values["DeathandDecay"] and ni.spell.in_range(spells.IcyTouch.name, t) then
         ni.spell.cast_on(spells.DeathandDecay.name, t)
         return true
      end
   end
}

ni.profile.new("Blood_Wrath", queue, abilities, ui)
