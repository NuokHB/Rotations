--Version: 15595
local ni = ...

local queue = {
   "Pause",
   "Cache",
   "GCD", --All Spells on GCD need to be
   "CrusaderStrike",
   "Judgement",
   "AutoAttack"
}

local spells = {
   --General
  ArmorSkills = {id = 76271, name = ni.spell.info(76271)},
  AutoAttack = {id = 6603, name = ni.spell.info(6603)},
  Cultivation = {id = 20552, name = ni.spell.info(20552)},
  Endurance = {id = 20550, name = ni.spell.info(20550)},
  Languages = {id = 79746, name = ni.spell.info(79746)},
  NatureResistance = {id = 20551, name = ni.spell.info(20551)},
  WarStomp = {id = 20549, name = ni.spell.info(20549)},
  WeaponSkills = {id = 76294, name = ni.spell.info(76294)},
  ApprenticeRiding = {id = 33388, name = ni.spell.info(33388)},
  JourneymanRiding = {id = 33391, name = ni.spell.info(33391)},
  PlateSpecialization = {id = 86525, name = ni.spell.info(86525)},
  ExpertRiding = {id = 34090, name = ni.spell.info(34090)},
  FlightMastersLicense = {id = 90267, name = ni.spell.info(90267)},
  ColdWeatherFlying = {id = 54197, name = ni.spell.info(54197)},
  ArtisanRiding = {id = 34091, name = ni.spell.info(34091)},
  MasterRiding = {id = 90265, name = ni.spell.info(90265)},
  Mastery = {id = 86474, name = ni.spell.info(86474)},
--Holy
  HolyLight = {id = 635, name = ni.spell.info(635)},
  WordofGlory = {id = 85673, name = ni.spell.info(85673)},
  Redemption = {id = 7328, name = ni.spell.info(7328)},
  FlashofLight = {id = 19750, name = ni.spell.info(19750)},
  LayonHands = {id = 633, name = ni.spell.info(633)},
  Exorcism = {id = 879, name = ni.spell.info(879)},
  Consecration = {id = 26573, name = ni.spell.info(26573)},
  HolyWrath = {id = 2812, name = ni.spell.info(2812)},
  SealofInsight = {id = 20165, name = ni.spell.info(20165)},
  Cleanse = {id = 4987, name = ni.spell.info(4987)},
  ConcentrationAura = {id = 19746, name = ni.spell.info(19746)},
  DivinePlea = {id = 54428, name = ni.spell.info(54428)},
  DivineLight = {id = 82326, name = ni.spell.info(82326)},
  TurnEvil = {id = 10326, name = ni.spell.info(10326)},
  HolyRadiance = {id = 82327, name = ni.spell.info(82327)},
--Protection
  SealofRighteousness = {id = 20154, name = ni.spell.info(20154)},
  DevotionAura = {id = 465, name = ni.spell.info(465)},
  Parry = {id = 82242, name = ni.spell.info(82242)},
  RighteousFury = {id = 25780, name = ni.spell.info(25780)},
  HammerofJustice = {id = 853, name = ni.spell.info(853)},
  HandofReckoning = {id = 62124, name = ni.spell.info(62124)},
  HandofProtection = {id = 1022, name = ni.spell.info(1022)},
  BlessingofKings = {id = 20217, name = ni.spell.info(20217)},
  DivineProtection = {id = 498, name = ni.spell.info(498)},
  RighteousDefense = {id = 31789, name = ni.spell.info(31789)},
  DivineShield = {id = 642, name = ni.spell.info(642)},
  HandofFreedom = {id = 1044, name = ni.spell.info(1044)},
  SealofJustice = {id = 20164, name = ni.spell.info(20164)},
  HandofSalvation = {id = 1038, name = ni.spell.info(1038)},
  ResistanceAura = {id = 19891, name = ni.spell.info(19891)},
  HandofSacrifice = {id = 6940, name = ni.spell.info(6940)},
  GuardianofAncientKings = {id = 86150, name = ni.spell.info(86150)},
--Retribution
  CrusaderStrike = {id = 35395, name = ni.spell.info(35395)},
  Judgement = {id = 20271, name = ni.spell.info(20271)},
  RetributionAura = {id = 7294, name = ni.spell.info(7294)},
  SealofTruth = {id = 31801, name = ni.spell.info(31801)},
  HammerofWrath = {id = 24275, name = ni.spell.info(24275)},
  Rebuke = {id = 96231, name = ni.spell.info(96231)},
  BlessingofMight = {id = 19740, name = ni.spell.info(19740)},
  CrusaderAura = {id = 32223, name = ni.spell.info(32223)},
  AvengingWrath = {id = 31884, name = ni.spell.info(31884)},
  Inquisition = {id = 84963, name = ni.spell.info(84963)},
}

local t, p = "target", "player"
local cache = {
	targets = nil,
   target_count = 0,
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
		cache.targets = ni.player.enemies_in_range(8)
      cache.target_count = ni.table.length(cache.targets)
	end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["Judgement"] = function()
      if ni.spell.valid(spells.Judgement.id, t, true, true) then
         ni.spell.cast(spells.Judgement.id, t)
         return true
      end
   end,
   ["CrusaderStrike"] = function()
      if ni.spell.valid(spells.CrusaderStrike.id, t, true, true) then
         ni.spell.cast(spells.CrusaderStrike.id, t)
         return true
      end
   end,
}
ni.profile.new("Protection_Cata", queue, abilities)
