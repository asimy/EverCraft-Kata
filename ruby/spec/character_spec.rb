require 'spec_helper'

describe Character do
  Given(:character) { Character.new("Brian the Barbarian") }

  describe "its name" do
    Then { character.name.should == "Brian the Barbarian" }
  end

  describe "its race" do
    Then { character.race.should == :human }
  end

  describe "default values" do
    Given(:attacker) { Character.new("attacker") }

    Then { character.experience.should == 0 }
    Then { character.level.should == 1 }
    Then { character.alignment.should == :neutral }
    Then { character.armor_class(attacker).should == 10 }
    Then { character.hit_points.should == 5 }
  end

  describe "#alignment" do
    context "when the character is good" do
      When { character.alignment = :good }
      Then { character.alignment.should == :good }
    end

    context "when the character is evil" do
      When { character.alignment = :evil }
      Then { character.alignment.should == :evil }
    end

    context "when the character is neutral" do
      When { character.alignment = :neutral }
      Then { character.alignment.should == :neutral }
    end

    describe "invalid alignments" do
      Then {
        lambda { character.alignment = :invalid }.should raise_error(ArgumentError)
      }
    end
  end

  describe "abilities" do
    describe "defaults" do
      Then { character.strength.should == 10 }
      Then { character.dexterity.should == 10 }
      Then { character.constitution.should == 10 }
      Then { character.wisdom.should == 10 }
      Then { character.intelligence.should == 10 }
      Then { character.charisma.should == 10 }
    end
  end

  describe "ability modifiers" do
    context "default skill level" do
      it "should have modifier 0" do
        character.strength_modifier.should == 0
      end
    end

    context "at ability 16" do
      it "should have modifier +3" do
        character.strength = 16
        character.strength_modifier.should == 3
      end
    end

    context "at ability 15" do
      it "should have modifier +2" do
        character.strength = 15
        character.strength_modifier.should == 2
      end
    end

    context "at ability 20" do
      it "should have modifier +5" do
        character.strength = 20
        character.strength_modifier.should == 5
      end
    end

    context "at ability 1" do
      it "should have modifier -5" do
        character.strength = 1
        character.strength_modifier.should == -5
      end
    end

    context "at ability 5" do
      it "should have modifier -3" do
        character.strength = 5
        character.strength_modifier.should == -3
      end
    end

    context "at ability 6" do
      it "should have modifier -2" do
        character.strength = 6
        character.strength_modifier.should == -2
      end
    end
  end

  describe "how constitution effects stats" do
    Given(:defender) {
      Character.new("Me", constitution: initial_defender_constitution)
    }

    context "with a consitution increase" do
      Given(:initial_defender_constitution) { 12 }
      Then { defender.hit_points == 6 }
    end

    context "with a huge consitution decrease" do
      Given(:initial_defender_constitution) { 1 }
      Then { defender.hit_points.should == 1 }
    end
  end

  describe "gaining experience" do
    Given(:attacker) { character }
    Given!(:original_xp) { attacker.experience }
    Given(:defender) { Character.new("Them") }
    When { attacker.attacks(defender, 19) }
    Then { attacker.experience.should == original_xp + 10 }
  end

  describe "initializing values" do
    context "on setting abilities" do
      Given(:character) { Character.new("Me", strength: 13) }
      Then { character.strength.should == 13 }
    end

    context "on instance variables" do
      Given(:character) { Character.new("Me", experience: 13) }
      Then { character.experience.should == 13 }
    end

    context "on level" do
      Given(:character) { Character.new("Me", level: 2) }
      Then { character.level.should == 2 }
      Then { character.experience.should == 1000 }
    end

    context "on class strategy" do
      Given(:character) { Character.new("Me", class: FighterClass) }
      Given(:fighter_hit_points) { 10 }
      Then { character.hit_points.should == fighter_hit_points }
    end

    context "on something undefined " do
      it "fails" do
        lambda { Character.new("me", :xyzzy, 20) }.should raise_error(ArgumentError)
      end
    end
  end
end
