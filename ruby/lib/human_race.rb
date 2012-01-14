class HumanRace
  def initialize(character)
    @character = character
  end

  def racial_name
    :human
  end

  def modifier_bonus_for(ability)
    ability_tweeks[ability] || 0
  end

  def ability_tweeks
    {}
  end

  def attack_bonus(defender)
    0
  end

  def armor_bonus(attacker)
    0
  end

  def damage_bonus(defender)
    0
  end

  def hit_point_multiplier
    1
  end

  def critical_range_bonus
    0
  end
end
