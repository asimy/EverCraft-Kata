class RogueClass < StandardClass
  def critical_damage_multiplier(defender)
    3
  end

  def attack_bonus(defender)
    @character.dexterity_modifier
  end

  def choose_defenders_armor(base_armor, normal_armor)
    base_armor
  end
end
