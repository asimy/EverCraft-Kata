require 'spec_helper'

describe WarAxe do
  Given(:axe) { WarAxe.new }

  context "when attacking" do
    Given(:attacker_class) { StandardClass }
    Given(:attacker) { Character.new("attacker", :class => attacker_class ) }
    Given { attacker.wields(axe) }
    Given(:defender) { Character.new("defender") }
    Given(:attack) { Attack.new(attacker, defender, 10) }

    Given(:basic_attack) { 10 }
    Given(:basic_damage) { 1 }

    context "when wielded by a non-rogue" do
      Then { attack.attack_value.should == basic_attack + 2 }
      Then { attack.normal_damage.should == basic_damage + 2 }
      Then { attack.critical_damage.should == 3*(basic_damage + 2) }
    end

    context "when normal attack" do
      Given(:attacker_class) { RogueClass }
      Then { attack.attack_value.should == basic_attack + 2 }
      Then { attack.normal_damage.should == basic_damage + 2 }
      Then { attack.critical_damage.should == 4*(basic_damage + 2) }
    end
  end
end
