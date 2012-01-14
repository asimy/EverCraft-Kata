class WarMonkClass < StandardClass
  def hits_per_level
    6
  end

  def base_damage(defender)
    3
  end

  def armor_bonus
    @character.dexterity_modifier +
      @character.wisdom_modifier
  end

  def level_bonus
    n = @character.level - 1
    2*(n/3) + n%3
  end
end
