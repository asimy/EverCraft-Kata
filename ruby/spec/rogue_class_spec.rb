require 'spec_helper'

describe RogueClass do
  Given(:character) { Character.new("Me", RogueClass) }
  Then { character.should_not be_nil }

  describe "critical damage" do
    Given(:attack) { character.attacking_with(20) }
    Then { attack.critical_damage.should == 3 }
  end

  describe "dexterity based attack" do
    Given { character.dexterity = 12 }
    Then { character.attack_bonus.should == 1 }
  end
end
