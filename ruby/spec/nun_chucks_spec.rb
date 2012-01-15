require 'spec_helper'

describe NunChucks do
  Given(:nun_chucks) { NunChucks.new }

  context "when attacking" do
    Given(:attacker_class) { StandardClass }
    Given(:defender_class) { StandardClass }

    Given(:attacker) { Character.new("attacker", :class => attacker_class) }
    Given(:defender) { Character.new("defender", :class => defender_class) }
    Given { attacker.wields(nun_chucks) }

    Given(:basic_attack) { 19 }
    Given(:basic_damage) { 1 }
    Given(:monk_damage) { 3 }

    When(:attack) { Attack.new(attacker, defender, basic_attack) }

    context "with a non-War Monk" do
      Then { attack.attack_value.should == basic_attack - 4 }
      Then { attack.normal_damage.should == basic_damage }
    end

    context "with a War Monk" do
      Given(:attacker_class) { WarMonkClass }
      Then { attack.attack_value.should == basic_attack }
      Then { attack.normal_damage.should == monk_damage + 6 }
    end
  end
end
