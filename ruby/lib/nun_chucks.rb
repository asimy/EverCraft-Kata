class NunChucks < BasicWeapon
  def attack_bonus(attacker, defender)
    if attacker.class_name == :war_monk
      super
    else
      super - 4
    end
  end

  def damage_bonus(attacker, defender)
    if attacker.class_name == :war_monk
      super + 6
    else
      super
    end
  end
end
