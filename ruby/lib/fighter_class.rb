require 'standard_class'

class FighterClass < StandardClass
  def name
    :fighter
  end

  def level_bonus
    @character.level - 1
  end

  def hits_per_level
    10
  end
end
