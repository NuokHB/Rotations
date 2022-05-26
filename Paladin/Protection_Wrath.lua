--Version: 12340
local ni = ...

local spells = {
--General
ArcaneTorrent = {id = 28730, name = ni.spell.info(28730)},
AutoAttack = {id = 6603, name = ni.spell.info(6603)},
--Holy
HolyLight = {id = 639, name = ni.spell.info(639)},
LayonHands = {id = 633, name = ni.spell.info(633)},
Purify = {id = 1152, name = ni.spell.info(1152)},
SealofRighteousness = {id = 21084, name = ni.spell.info(21084)},
--Protection
DevotionAura = {id = 10290, name = ni.spell.info(10290)},
DivineProtection = {id = 498, name = ni.spell.info(498)},
HammerofJustice = {id = 853, name = ni.spell.info(853)},
HandofProtection = {id = 1022, name = ni.spell.info(1022)},
--Retribution
BlessingofMight = {id = 19834, name = ni.spell.info(19834)},
JudgementofLight = {id = 20271, name = ni.spell.info(20271)},
JudgementofWisdom = {id = 53408, name = ni.spell.info(53408)},
}

local enables = {}
local values = {}
local inputs = {}
local menus = {
	["Blessing"] = 1,
   ["Seals"] = 1,
}

local Blessing ={
   BlessingofMight = 1
}

local Seals = {
   SealofRighteousness = 1,
}

local function GUICallback(key, item_type, value)
   if item_type == "enabled" then
      enables[key] = value
   elseif item_type == "value" then
      values[key] = value
   elseif item_type == "input" then
      inputs[key] = value
   elseif item_type == "menu" then
      menus[key] = value
   end
end

local ui = {
   settingsfile = ni.player.guid().."_prot_pala_wrath.json",
   callback = GUICallback,
   {type = "label", text = "Blessings"},
   {
		type = "combobox",
		menu = {
			{selected = (menus["Blessing"] == Blessing.BlessingofMight), text = spells.BlessingofMight.name},
		},
		key = "Blessing"
	},
   {type = "label", text = "Seals"},
   {
		type = "combobox",
		menu = {
			{selected = (menus["Seals"] == Seals.SealofRighteousness), text = spells.SealofRighteousness.name},
		},
		key = "Seals"
	},
   {type = "label", text = "Prot Pala by Nuok"},
}

local queue = {
   "Pause",
   "Cache",
   "AutoAttack",
   "GCD",
   "DevotionAura",
   "BlessingofMight",
   "SealofRighteousness",
   "JudgementofLight",
}

local t, p = "target", "player"

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
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["DevotionAura"] = function ()
      if not ni.player.buff(spells.DevotionAura.id) and ni.spell.available(spells.DevotionAura.id) then
         ni.spell.cast(spells.DevotionAura.id)
         return true
      end
   end,
   ["SealofRighteousness"] = function ()
      if ni.spell.available(spells.SealofRighteousness.name) and not ni.player.buff(spells.SealofRighteousness.id) then
         ni.spell.cast(spells.SealofRighteousness.name)
         return true
      end
   end,
   ["BlessingofMight"] = function ()
      if menus["Blessing"] == Blessing.BlessingofMight and ni.spell.available(spells.BlessingofMight.name) and not ni.player.buff(spells.BlessingofMight.id) then
         ni.spell.cast(spells.BlessingofMight.name, p)
         return true
      end
   end,
   ["JudgementofLight"] = function ()
      if ni.spell.valid(spells.JudgementofLight.id, t, true, true) then
         ni.spell.cast(spells.JudgementofLight.name, t)
         return true
      end
   end,
}

ni.profile.new("Protection_Wrath", queue, abilities, ui)
