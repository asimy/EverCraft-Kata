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

  def normal_damage_multiplier_for(defender)
    1
  end

  def critical_damage_multiplier
    2
  end

  def attack_bonus(defender)
    @character.strength_modifier
  end

  def base_damage
    1
  end

  def choose_defenders_armor(base_armor, normal_armor)
    normal_armor
  end

  def armor_bonus
    @character.dexterity_modifier
  end
end
