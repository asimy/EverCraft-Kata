class HalflingRace < StandardRace
  def racial_name
    :halfling
  end

  def ability_tweeks
    { strength: -1, dexterity: 1 }
  end

  def armor_bonus(attacker)
    (attacker.race == :halfling) ? 0 : 2
  end
end
