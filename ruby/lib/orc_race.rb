class OrcRace < HumanRace
  ABILITY_MODS = { strength: 2, intelligence: -1, wisdom: -1, charisma: -1 }

  def armor_bonus
    2
  end

  def modifier_bonus_for(ability)
    ABILITY_MODS[ability] || super
  end
end
