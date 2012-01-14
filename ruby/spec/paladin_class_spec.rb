require 'spec_helper'

describe PaladinClass do
  Given(:character) { Character.new("Pally", PaladinClass) }
  Given(:defender) { Character.new("Defender") }

  describe "has 8 hit points per level instead of 5" do
    context "at level 1" do
      Then { character.hit_points.should == 8 }
    end
    context "at level 2" do
      Given { character.set_level(2) }
      Then { character.hit_points.should == 16 }
    end
  end

  describe "+2 to attack and damage (3x on crit) on evil dudes" do
    Given(:base_damage) { 1 }
    context "when attacking a good guy" do
      Given(:defender) { Character.new("Good Guy") }
      When(:attack) { character.attacking_with(defender, 10) }
      Then { attack.attack_value(defender).should == 10 }
      Then { attack.normal_damage(defender).should == base_damage }
      Then { attack.critical_damage(defender).should == 2 * base_damage }
    end

    context "when attacking a bad guy" do
      Given(:defender) {
        Character.new("Bad Guy") do |c|
          c.alignment = :evil
        end
      }
      When(:attack) { character.attacking_with(defender, 10) }
      Then { attack.attack_value(defender).should == 12 }
      Then { attack.normal_damage(defender).should == base_damage + 2 }
      Then { attack.critical_damage(defender).should == 3 * (base_damage + 2) }
    end
  end

  describe "attacks roll is increased by 1 for every level instead of every other level" do
    When(:attack) { character.attacking_with(defender, 10) }

    context "at level 1" do
      Then { attack.attack_value(defender).should == 10 }
    end
    context "at level 2" do
      Given { character.set_level(2) }
      Then { attack.attack_value(defender).should == 11 }
    end
    context "at level 3" do
      Given { character.set_level(3) }
      Then { attack.attack_value(defender).should == 12 }
    end
    context "at level 4" do
      Given { character.set_level(4) }
      Then { attack.attack_value(defender).should == 13 }
    end
  end
end
