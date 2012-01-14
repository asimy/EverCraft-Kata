require 'spec_helper'

describe HalflingRace do
  Given(:character) { Character.new("Me", race: HalflingRace) }
  Given(:base_modifier) { 0 }
  Given(:base_armor_class) { 10 }
  Given(:armor_class) { base_armor_class + character.dexterity_modifier }

  Then { character.race.should == :halfling }

  Then { character.dexterity_modifier.should == base_modifier + 1 }
  Then { character.strength_modifier.should == base_modifier - 1 }

  describe "armor class" do
    context "when attacked by halfling" do
      Given(:attacker) { Character.new("Them", race: HalflingRace) }
      Then { character.armor_class(attacker).should == armor_class }
    end
    context "when attacked by non-halfling" do
      Given(:attacker) { Character.new("Them") }
      Then { character.armor_class(attacker).should == armor_class + 2 }
    end
  end
end
