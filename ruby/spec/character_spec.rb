require 'spec_helper'

describe Character do
  Given(:character) { Character.new("Brian the Barbarian") }

  describe "its name" do
    Then { character.name.should == "Brian the Barbarian" }
  end

  describe "default values" do
    Then { character.experience.should == 0 }
    Then { character.level.should == 1 }
    Then { character.alignment.should == :neutral }
    Then { character.armor_class.should == 10 }
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

  describe "defending against an attack" do
    Given(:defender) {
      Character.new("Me") do |c|
        c.hit_points = original_hits
        c.dexterity = initial_defender_dexterity
      end
    }
    Given(:original_hits) { 5 }
    Given(:initial_defender_dexterity) { 10 }
    Given(:attack_roll) { 1 }

    Given(:initial_attacker_experience) { 100 }
    Given(:initial_attacker_strength) { 10 }
    Given(:attacker) {
      Character.new("Them") do |c|
        c.experience = initial_attacker_experience
        c.strength = initial_attacker_strength
      end
    }
    When { defender.attacked_by(attacker.attacking_with(defender, attack_roll)) }

    context "when it is unsuccessful" do
      Then { defender.hit_points.should == original_hits }
    end

    context "when it is successful" do
      Given(:attack_roll) { 10 }
      Then { defender.hit_points.should == original_hits - 1 }
      Then { attacker.experience.should == initial_attacker_experience + 10 }
    end

    context "when it is critical" do
      Given(:attack_roll) { 20 }
      Then { defender.hit_points.should == original_hits - 2 }
    end

    context "when the defender dies" do
      Given(:attack_roll) { 19 }
      Given(:original_hits) { 1 }
      Then { defender.should be_dead }
    end

    context "when the attacker is strong" do
      Given(:initial_attacker_strength) { 12 }
      Given(:attack_roll) { 9 }
      Then { defender.hit_points.should == original_hits - 2 }
    end

    context "when the attacker is weak" do
      Given(:initial_attacker_strength) { 8 }
      Given(:attack_roll) { 10 }
      Then { defender.hit_points.should == original_hits }
    end

    context "when a week attacker hits" do
      Given(:initial_attacker_strength) { 8 }
      Given(:attack_roll) { 19 }
      Then { defender.hit_points.should == original_hits-1 }
    end

    context "when a strong attacker crits" do
      Given(:attack_roll) { 20 }
      Given(:initial_attacker_strength) { 12 }
      Then { defender.hit_points.should == original_hits - 4 }
    end

    context "when the defender is dexterous" do
      Given(:attack_roll) { 10 }
      Given(:initial_defender_dexterity) { 12 }
      Then { defender.hit_points.should == original_hits }
    end

    context "when then attacker wins a bunch of battles" do
      Given(:xp) { 0 }
      Given(:character) { Character.new("Me") do |c| c.experience = xp end }

      context "low level 1" do
        Given(:xp) { 0 }
        Then { character.level.should == 1 }

        describe "no increase attack value" do
          When(:attack) { character.attacking_with(defender, 10) }
          Then { attack.attack_value.should == 10 }
        end
      end

      context "high level 1" do
        Given(:xp) { 999 }
        Then { character.level.should == 1 }
      end

      context "low level 2" do
        Given(:xp) { 1000 }
        Then { character.level.should == 2 }

        describe "increase attack value" do
          When(:attack) { character.attacking_with(defender, 10) }
          Then { attack.attack_value.should == 11 }
        end
      end

      context "high level 2" do
        Given(:xp) { 1999 }
        Then { character.level.should == 2 }
      end

      context "low level 3" do
        Given(:xp) { 2000 }
        Then { character.level.should == 3 }
      end
    end
  end

  describe "how constitution effects stats" do
    Given(:defender) {
      Character.new("Me") do |c|
        c.constitution = initial_defender_constitution
      end
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
    it "gains 10 points experience"do
      attacker.had_a_successful_attack
      attacker.experience.should == 10
    end
  end

  describe "#attacking_with" do
    Given(:defender) { Character.new("defender") }
    it "returns an an attack object" do
      attack = character.attacking_with(defender, 10)
      attack.attack_value.should == 10
      attack.normal_damage.should == 1
    end
  end
end
