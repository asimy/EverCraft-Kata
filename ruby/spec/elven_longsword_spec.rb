require 'spec_helper'

describe ElvenLongsword do
  Given(:sword) { ElvenLongsword.new }

  context "when attacking" do
    Given(:attacker_race) { HumanRace }
    Given(:defender_race) { HumanRace }

    Given(:attacker) { Character.new("attacker", race: attacker_race) }
    Given(:defender) { Character.new("defender", race: defender_race) }
    Given { attacker.wields(sword) }

    Given(:basic_attack) { 19 }
    Given(:basic_damage) { 1 }

    When(:attack) { Attack.new(attacker, defender, 19) }

    context "with a normal attacker/defender" do
      Then { attack.attack_value.should == basic_attack + 1 }
      Then { attack.normal_damage.should == basic_damage + 5 + 1 }
    end

    context "with an elvish attacker" do
      Given(:attacker_race) { ElfRace }
      Then { attack.attack_value.should == basic_attack + 2 }
      Then { attack.normal_damage.should == basic_damage + 5 + 2 }
    end

    context "with an orcish defender" do
      Given(:defender_race) { OrcRace }
      Then { attack.attack_value.should == basic_attack + 2 }
      Then { attack.normal_damage.should == basic_damage + 5 + 2 }
    end

    context "with an elvish attacker VS orcish defender" do
      Given(:attacker_race) { ElfRace }
      Given(:defender_race) { OrcRace }
      Then { attack.attack_value.should == basic_attack + 5 }
      Then { attack.normal_damage.should == basic_damage + 5 + 5 }
    end
  end

end
