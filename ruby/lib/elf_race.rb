class ElfRace < HumanRace
  ABILITY_MODS = { dexterity: 1, constitution: -1 }

  def racial_name
    :elf
  end

  def modifier_bonus_for(ability)
    ABILITY_MODS[ability] || super
  end

  def armor_bonus(attacker)
    (attacker.race == :orc) ? 2 : 0
  end

  def critical_range_bonus
    1
  end
end
