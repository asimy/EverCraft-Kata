require 'spec_helper'

describe DwarfRace do
  describe "name" do
    Given(:character) { Character.new("Me", race: DwarfRace) }
    Then { character.race.should == :dwarf }
  end

  describe "ability modifiers" do
    Given(:character) { Character.new("Me", race: DwarfRace) }
    Given(:base_modifier) { 0 }

    Then { character.constitution_modifier.should == base_modifier + 1 }
    Then { character.charisma_modifier.should == base_modifier - 1 }
  end

  describe "how constituion effects hit points per level" do
    Given(:character) { Character.new("Me", race: DwarfRace, constitution: 12) }
    Given(:base_hit_points) { 5 }

    Then { character.constitution_modifier.should == 2 }
    Then { character.hit_points.should == base_hit_points + 2*2 }
  end

  describe "+2 to attack/damage when attacking orcs" do
    Given(:dwarf) { Character.new("attacker", race: DwarfRace) }
    Given(:attack) { Attack.new(dwarf, defender, 10) }

    Given(:basic_attack) { 10 }
    Given(:basic_damage) { 1 }
    Given(:critical_damage) { 2 }

    context "against a non-orc" do
      Given(:defender) { Character.new("defender") }

      Then { attack.attack_value.should == basic_attack }
      Then { attack.normal_damage.should == basic_damage }
      Then { attack.critical_damage.should == critical_damage }
    end

    context "against an orc" do
      Given(:defender) { Character.new("defender", race: OrcRace) }

      Then { attack.attack_value.should == basic_attack + 2 }
      Then { attack.normal_damage.should == basic_damage + 2 }
      Then { attack.critical_damage.should == 2*(basic_damage+2) }
    end
  end
end
