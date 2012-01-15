require 'standard_class'

class PaladinClass < StandardClass
  def name
    :paladin
  end

  def hits_per_level
    8
  end

  def attack_bonus(defender)
    @character.strength_modifier + ((defender.alignment == :evil) ? 2 : 0)
  end

  def base_damage(defender)
    (defender.alignment == :evil) ? super + 2 : super
  end

  def critical_damage_multiplier(defender)
    (defender.alignment == :evil) ? 3 : super
  end

  def level_bonus
    @character.level - 1
  end
end
