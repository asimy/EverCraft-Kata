class ElvenLongsword < Longsword
  def attack_bonus(attacker, defender)
    if attacker.race == :elf && defender.race == :orc
      super + 5
    elsif attacker.race == :elf || defender.race == :orc
      super + 2
    else
      super + 1
    end
  end

  def damage_bonus(attacker, defender)
    if attacker.race == :elf && defender.race == :orc
      super + 5
    elsif attacker.race == :elf || defender.race == :orc
      super + 2
    else
      super + 1
    end
  end
end
