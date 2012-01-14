require 'spec_helper'

describe RogueClass do
  Given(:character) { Character.new("Me", RogueClass) }
  Given(:defender) { Character.new("Them") }

  describe "critical damage" do
    Given(:attack) { character.attacking_with(20) }
    Then { attack.critical_damage(defender).should == 3 }
  end

  describe "dexterity based attack" do
    Given { character.dexterity = 12 }
    Then { character.attack_bonus(defender).should == 1 }
  end

  describe "ignore dexterity of defender" do
    Given(:defender) {
      Character.new("Defender") do |c|
        c.dexterity = 12
      end
    }
    When { defender.attacked_by(character.attacking_with(10)) }
    Then { character.experience.should == 10 }
  end
end
