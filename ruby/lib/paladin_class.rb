require 'standard_class'

class PaladinClass < StandardClass
  def hits_per_level
    8
  end

  def attack_bonus(defender)
    @character.strength_modifier + ((defender.alignment == :evil) ? 2 : 0)
  end

  def normal_damage_multiplier_for(defender)
    (defender.alignment == :evil) ? 3 : 1
  end

  def level_bonus
    @character.level - 1
  end
end
