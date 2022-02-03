--Version: 15595
local ni = ...

local queue = {
   "Pause",
   "Cache",
   "GCD",
   "IcyTouch",
   "PlagueStrike",
   "HeartStrike",
   "BloodStrike",
   "DeathCoil",
   "AutoAttack"
}

local spells = {--General icon = select(2, GetSpellTabInfo(1))
AutoAttack = {id = 6603, name = ni.spell.info(6603)},
--Blood icon = select(2, GetSpellTabInfo(2))
BloodStrike = {id = 45902, name = ni.spell.info(45902)},
Parry = {id = 82246, name = ni.spell.info(82246)},
DeathStrike = {id = 49998, name = ni.spell.info(49998)},
Pestilence = {id = 50842, name = ni.spell.info(50842)},
BloodPresence = {id = 48263, name = ni.spell.info(48263)},
BloodBoil = {id = 48721, name = ni.spell.info(48721)},
Strangulate = {id = 47476, name = ni.spell.info(47476)},
BloodTap = {id = 45529, name = ni.spell.info(45529)},
DarkCommand = {id = 56222, name = ni.spell.info(56222)},
DeathPact = {id = 48743, name = ni.spell.info(48743)},
DarkSimulacrum = {id = 77606, name = ni.spell.info(77606)},
HeartStrike = {id = 55050, name = ni.spell.info(55050)},

--Frost icon = select(2, GetSpellTabInfo(3))
FrostFever = {id = 59921, name = ni.spell.info(59921)},
FrostPresence = {id = 48266, name = ni.spell.info(48266)},
IcyTouch = {id = 45477, name = ni.spell.info(45477)},
RunicFocus = {id = 61455, name = ni.spell.info(61455)},
MindFreeze = {id = 47528, name = ni.spell.info(47528)},
ChainsofIce = {id = 45524, name = ni.spell.info(45524)},
Obliterate = {id = 49020, name = ni.spell.info(49020)},
PathofFrost = {id = 3714, name = ni.spell.info(3714)},
IceboundFortitude = {id = 48792, name = ni.spell.info(48792)},
FesteringStrike = {id = 85948, name = ni.spell.info(85948)},
HornofWinter = {id = 57330, name = ni.spell.info(57330)},
RuneStrike = {id = 56815, name = ni.spell.info(56815)},
RunicEmpowerment = {id = 81229, name = ni.spell.info(81229)},
EmpowerRuneWeapon = {id = 47568, name = ni.spell.info(47568)},
--Unholy icon = select(2, GetSpellTabInfo(4))
BloodPlague = {id = 59879, name = ni.spell.info(59879)},
DeathCoil = {id = 47541, name = ni.spell.info(47541)},
DeathGrip = {id = 49576, name = ni.spell.info(49576)},
PlagueStrike = {id = 45462, name = ni.spell.info(45462)},
RaiseDead = {id = 46584, name = ni.spell.info(46584)},
DeathandDecay = {id = 43265, name = ni.spell.info(43265)},
AntiMagicShell = {id = 48707, name = ni.spell.info(48707)},
UnholyPresence = {id = 48265, name = ni.spell.info(48265)},
RaiseAlly = {id = 61999, name = ni.spell.info(61999)},
ArmyoftheDead = {id = 42650, name = ni.spell.info(42650)},
Outbreak = {id = 77575, name = ni.spell.info(77575)},
NecroticStrike = {id = 73975, name = ni.spell.info(73975)},
}

local t, p = "target", "player"
local cache = {
	blood_plauge = 0,
	frost_fever = 0,
	targets = nil,
	blood_rune = 0
}

local abilities = {
   ["Pause"] = function()
      if
         ni.player.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
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
		cache.targets = ni.unit.enemies_in_range(t, 14)
	end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["IcyTouch"] = function()
      if cache.frost_fever < 1.5 and ni.spell.valid(spells.IcyTouch.id, t, true, true) then
         ni.spell.cast(spells.IcyTouch.id, t)
         return true
      end
   end,
   ["PlagueStrike"] = function()
      if cache.blood_plauge < 1.5 and ni.spell.valid(spells.PlagueStrike.id, t, true, true) then
         ni.spell.cast(spells.PlagueStrike.id, t)
         return true
      end
   end,
   ["BloodStrike"] = function ()
      if ni.spell.valid(spells.BloodStrike.id, t, true, true) and not ni.spell.known(spells.HeartStrike.id) then
         ni.spell.cast(spells.BloodStrike.id, t)
         return true
      end
   end,
   ["HeartStrike"] = function ()
      if ni.spell.valid(spells.HeartStrike.id, t, true, true) then
         ni.spell.cast(spells.HeartStrike.id, t)
         return true
      end
   end,
   ["DeathCoil"] = function()
      if ni.player.power("runicpower") > 80 and ni.spell.valid(spells.DeathCoil.id, t, true, true) then
         ni.spell.cast(spells.PlagueStrike.id, t)
         return true
      end
   end,
}

ni.profile.new("Blood_Cata", queue, abilities)
