class StandardClass
  def initialize(character)
    @character = character
  end

  def level_bonus
    @character.level/2
  end

  def hits_per_level
    5
  end

  def critical_damage_multiplier
    2
  end

  def attack_bonus
    @character.strength_modifier
  end

  def choose_defenders_armor(base_armor, normal_armor)
    normal_armor
  end
end
