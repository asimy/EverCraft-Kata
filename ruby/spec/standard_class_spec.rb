require 'spec_helper'

describe StandardClass do
  describe "defending against an attack" do
    Given(:defender) {
      Character.new("Me",
        hit_points:  original_hits,
        dexterity: initial_defender_dexterity)
    }
    Given(:original_hits) { 5 }
    Given(:initial_defender_dexterity) { 10 }
    Given(:attack_roll) { 1 }

    Given(:initial_attacker_experience) { 100 }
    Given(:initial_attacker_strength) { 10 }
    Given(:attacker) {
      Character.new("Them",
        experience: initial_attacker_experience,
        strength: initial_attacker_strength)
    }
    When { attacker.attacks(defender, attack_roll) }

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
      Given(:character) { Character.new("Me", experience: xp) }

      context "low level 1" do
        Given(:xp) { 0 }
        Then { character.level.should == 1 }

        describe "no increase attack value" do
          When(:attack) { Attack.new(character, defender, 10) }
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
          When(:attack) { Attack.new(character, defender, 10) }
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
end
