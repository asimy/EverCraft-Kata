class Attack
  def initialize(attacker, defender, die_value)
    @attacker = attacker
    @defender = defender
    @die_value = die_value
  end

  def attack_value(defender)
    @die_value + @attacker.attack_bonus(defender)
  end

  def critical_damage(defender)
    @attacker.critical_damage_multiplier(defender) * normal_damage(defender)
  end

  def normal_damage(defender)
    @attacker.normal_damage_multiplier_for(defender) * (@attacker.base_damage(defender) + @attacker.strength_modifier)
  end

  def critical?
    @die_value == 20
  end

  def was_successful
    @attacker.had_a_successful_attack
  end

  def choose_defenders_armor(basic_armor, normal_armor)
    @attacker.choose_defenders_armor(basic_armor, normal_armor)
  end
end
