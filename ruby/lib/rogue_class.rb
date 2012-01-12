class RogueClass < StandardClass
  def critical_damage_multiplier
    3
  end

  def attack_bonus
    @character.dexterity_modifier
  end
end
