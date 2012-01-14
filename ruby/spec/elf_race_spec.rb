require 'spec_helper'

describe ElfRace do
  Given(:character) { Character.new("Me", race: ElfRace) }
  Given(:base_modifier) { 0 }
  Given(:base_armor_class) { 10 }
  Given(:armor_class) { base_armor_class + character.dexterity_modifier }

  Given(:attacker) { Character.new("Attacker") }
  Given(:orc) { Character.new("Attacker", race: OrcRace) }

  Then { character.race.should == :elf }

  Then { character.dexterity_modifier.should == base_modifier + 1 }
  Then { character.constitution_modifier.should == base_modifier - 1 }

  Then { character.armor_class(attacker).should == armor_class }
  Then { character.armor_class(orc).should == armor_class + 2 }

  describe "critical attack range" do
    Given(:defender) { Character.new("defender") }
    context "at level 1" do
      Then { Attack.new(character, defender, 20).should be_critical }
      Then { Attack.new(character, defender, 19).should be_critical }
    end
  end
end
