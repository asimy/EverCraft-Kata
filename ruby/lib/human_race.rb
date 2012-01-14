class HumanRace
  def initialize(character)
    @character = character
  end

  def racial_name
    :human
  end

  def modifier_bonus_for(ability)
    0
  end

  def attack_bonus(defender)
    0
  end

  def armor_bonus
    0
  end

  def damage_bonus(defender)
    0
  end

  def hit_point_multiplier
    1
  end
end
