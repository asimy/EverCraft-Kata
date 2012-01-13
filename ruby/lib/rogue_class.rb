class RogueClass < StandardClass
  def critical_damage_multiplier
    3
  end

  def attack_bonus
    @character.dexterity_modifier
  end

  def choose_defenders_armor(base_armor, normal_armor)
    base_armor
  end
end
