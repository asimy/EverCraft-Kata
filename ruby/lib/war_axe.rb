class WarAxe < BasicWeapon
  def attack_bonus(attacker, defender)
    2
  end

  def damage_bonus(attacker, defender)
    6
  end

  def critical_damage_multiplier(attacker, defender)
    (attacker.class_name == :rogue) ? 4.0 / 3.0 : 3.0 / 2.0
  end
end
