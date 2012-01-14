class OrcRace < HumanRace
  def racial_name
    :orc
  end

  def armor_bonus(attacker)
    2
  end

  def ability_tweeks
    { strength: 2, intelligence: -1, wisdom: -1, charisma: -1 }
  end
end
