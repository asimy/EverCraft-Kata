require 'spec_helper'

describe FighterClass do
  let(:character) { Character.new("Me", FighterClass)}
  it "gets an attack bonus at level 2" do
    character.set_level(2)
    attack = character.attacking_with(10)
    attack.attack_value.should == 11
  end
  it "gets an hit point bonus at level 2" do
    character.set_level(2)
    attack = character.attacking_with(10)
    character.hit_points.should == 20
  end
end
