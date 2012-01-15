require 'spec_helper'

describe WarAxe do
  Given(:axe) { WarAxe.new }

  context "when attacking" do
    Given(:attacker) { Character.new("attacker") }
    Given { attacker.wields(axe) }
    Given(:defender) { Character.new("defender") }
    Given(:attack) { Attack.new(attacker, defender, 10) }

    Given(:basic_attack) { 10 }
    Given(:basic_damage) { 1 }

    Then { attack.attack_value.should == basic_attack + 2 }
    Then { attack.normal_damage.should == basic_damage + 2 }
  end
end
