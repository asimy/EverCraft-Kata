class Attack
  def initialize(attacker, die_value)
    @attacker = attacker
    @die_value = die_value
  end

  def attack_value
    @die_value + @attacker.attack_bonus
  end

  def critical_damage
    2 * @attacker.strength_modifier
  end

  def normal_damage
    1 + @attacker.strength_modifier
  end

  def critical?
    @die_value == 20
  end

  def was_successful
    @attacker.had_a_successful_attack
  end
end