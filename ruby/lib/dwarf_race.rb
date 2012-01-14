class DwarfRace < HumanRace
  def racial_name
    :dwarf
  end

  def ability_tweeks
    { constitution: 1, charisma: -1 }
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
