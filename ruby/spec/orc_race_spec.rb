require 'spec_helper'
require 'orc_race'

describe OrcRace do
  Given(:character) { Character.new("Me", race: OrcRace) }
  Given(:base_modifier) { 0 }
  Given(:base_armor_class) { 10 }

  Then { character.strength_modifier.should == base_modifier + 2 }
  Then { character.intelligence_modifier.should == base_modifier - 1 }
  Then { character.wisdom_modifier.should == base_modifier - 1 }
  Then { character.charisma_modifier.should == base_modifier - 1 }

 Then { character.armor_class.should == base_armor_class + 2 }
end
