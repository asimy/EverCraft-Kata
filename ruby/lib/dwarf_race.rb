class DwarfRace < HumanRace
  ABILITY_MODS = { constitution: 1, charisma: -1 }

  def racial_name
    :dwarf
  end

  def modifier_bonus_for(ability)
    ABILITY_MODS[ability] || super
  end

  def hit_point_multiplier
    2
  end

  def attack_bonus(defender)
    defender.race == :orc ? 2 : 0
  end

  def damage_bonus(defender)
    defender.race == :orc ? 2 : 0
  end
end
