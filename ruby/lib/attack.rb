class Attack
  def initialize(attacker, defender, die_value)
    @attacker = attacker
    @defender = defender
    @die_value = die_value
  end

  def invoke
    if critical?
      @defender.take_damage(critical_damage)
      @attacker.gains_experience(10)
    elsif successful?
      @defender.take_damage(normal_damage)
      @attacker.gains_experience(10)
    end
  end

  def successful?
    ac = choose_defenders_armor(@defender.base_armor_class, @defender.armor_class(@attacker))
    attack_value >= ac
  end

  def attack_value
    @die_value + @attacker.attack_bonus(@defender)
  end

  def critical_damage
    @attacker.critical_damage_multiplier(@defender) * normal_damage
  end

  def normal_damage
    @attacker.normal_damage_multiplier_for(@defender) * (@attacker.base_damage(@defender) + @attacker.strength_modifier)
  end

  def critical?
    @attacker.critical?(@die_value)
  end

  def choose_defenders_armor(basic_armor, normal_armor)
    @attacker.choose_defenders_armor(basic_armor, normal_armor)
  end
end
