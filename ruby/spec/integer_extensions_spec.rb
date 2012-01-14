require 'spec_helper'

describe "Integer extensions" do
  describe "#but_at_least(n)" do
    Then { 10.but_at_least(1).should == 10 }
    Then { 10.but_at_least(11).should == 11 }
    Then { -2.but_at_least(1).should == 1 }
  end

  describe "dice DSL" do
    def expected_rolls(n)
      srand(10)
      result = (0..10).map { rand(n)+1 }
      srand(10)
      result
    end

    context "nD20" do
      Given!(:rolls) { expected_rolls(20) }
      Then { 1.D(20).should == rolls[0] }
      Then { 2.D(20).should == rolls[0] + rolls[1] }
      Then { 5.D(20).should == rolls[0] + rolls[1] + rolls[2] + rolls[3] + rolls[4] }
    end

    context "nD12" do
      Given!(:rolls) { expected_rolls(12) }
      Then { 1.D(12).should == rolls[0] }
      Then { 2.D(12).should == rolls[0] + rolls[1] }
      Then { 5.D(12).should == rolls[0] + rolls[1] + rolls[2] + rolls[3] + rolls[4] }
    end

    describe "ranges" do
      Then { (1..100).map { 1.D(12) }.all? { |n| n >= 1 && n <= 12 }.should be_true }
      Then { (1..100).map { 1.D(20) }.all? { |n| n >= 1 && n <= 20 }.should be_true }

      context "when rolled a lot" do
        Given(:rolls) { (1..1000).map { 1.D(20) } }
        Then { rolls.any? { |n| n ==  1 }.should be_true }
        Then { rolls.any? { |n| n == 10 }.should be_true }
        Then { rolls.any? { |n| n == 20 }.should be_true }
      end
    end
  end
end
