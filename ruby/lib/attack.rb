class Attack
  def initialize(attacker, die_value)
    @attacker = attacker
    @die_value = die_value
  end

  def attack_value
    @die_value + @attacker.attack_bonus
  end

  def critical_damage
    @attacker.critical_damage_multiplier * normal_damage
  end

  def normal_damage
    @attacker.base_damage + @attacker.strength_modifier
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
