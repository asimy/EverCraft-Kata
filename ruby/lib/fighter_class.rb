require 'standard_class'

class FighterClass < StandardClass
  def level_bonus
    @character.level - 1
  end
  def hits_per_level
    10
  end
end
