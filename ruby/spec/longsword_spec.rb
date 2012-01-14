require 'spec_helper'

describe LongSword do
  Given(:longsword) { LongSword.new }
  Then { longsword.should_not be_nil }

  context "when attacking" do
    Given(:attacker) { Character.new("attacker") }
    Given { attacker.wields(longsword) }
    Given(:defender) { Character.new("defender") }
    Given(:attack) { Attack.new(attacker, defender, 19) }

    Given(:basic_damage) { 1 }

    Then { attack.normal_damage.should == basic_damage + 5 }
  end

end
