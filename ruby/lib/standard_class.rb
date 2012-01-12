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
end
