class ElfRace < StandardRace
  def racial_name
    :elf
  end

  def ability_tweeks
    { dexterity: 1, constitution: -1 }
  end

  def armor_bonus(attacker)
    (attacker.race == :orc) ? 2 : 0
  end

  def critical_range_bonus
    1
  end
end
