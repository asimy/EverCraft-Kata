require 'spec_helper'

describe WarMonkClass do
  Given(:original_hits) { 5 }
  Given(:character) { Character.new("Monk", WarMonkClass) }
  Given(:defender) { Character.new("Defender") }

  describe "has 6 hit points per level" do
    Given { character.set_level(2) }
    Then { character.hit_points.should == 12 }
  end

  describe "does 2 points of damage on successful attack" do
    When { character.attacks(defender, 10) }
    Then { defender.hit_points.should == original_hits - 3 }
  end

  describe "adds wisdom to armor class" do
    When { character.dexterity = 12 }
    When { character.wisdom = 12 }
    Then {
      character.armor_class.should == (10 +
        character.dexterity_modifier +
        character.wisdom_modifier)
      }
  end

  describe "attack roll is increased by 1 every 2nd and 3rd level" do
    When(:attack) { Attack.new(character, defender, 10) }

    context "at level 1" do
      Then { attack.attack_value.should == 10 }
    end
    context "at level 2" do
      Given { character.set_level(2) }
      Then { attack.attack_value.should == 11 }
    end
    context "at level 3" do
      Given { character.set_level(3) }
      Then { attack.attack_value.should == 12 }
    end
    context "at level 4" do
      Given { character.set_level(4) }
      Then { attack.attack_value.should == 12 }
    end
    context "at level 5" do
      Given { character.set_level(5) }
      Then { attack.attack_value.should == 13 }
    end
    context "at level 6" do
      Given { character.set_level(6) }
      Then { attack.attack_value.should == 14 }
    end
    context "at level 7" do
      Given { character.set_level(7) }
      Then { attack.attack_value.should == 14 }
    end
  end
end
