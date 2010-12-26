require 'rspec'
require_relative 'game'

describe "Card" do
  it "should be rotatable" do
    c = Cards.new
    card = c.cards[0]
    card.rotate.should == [:BT, :WB, :MT, :CT]
  end

  it "should give rotateable perms" do
    c = Cards.new
    cards = c.cards[0]
    cards.rotate_perms.size.should == 4
  end

  it "should not modify the existing card" do
    c = Cards.new
    card = c.cards[0]
    new_card = card.rotate
    new_card.should_not == card
  end

  it "should be rotatable a number of times" do
    c = Cards.new
    card = c.cards[0]
    new_card = card.rotate 3
    new_card.should == [:MT, :CT, :BT, :WB]
  end

  it "has top, bottom, left, right" do
    c = Cards.new
    card = c.cards[0]
    card.top.should == :CT
    card.bottom.should == :WB
    card.left.should == :MT
    card.right.should == :BT
  end

  it "can compare sides" do
    c = Cards.new
    middle = c.cards[8]
    top = c.cards[6]

    left = c.cards[1]
    right = c.cards[3]

    middle.below?(top).should be_true
    top.below?(middle).should be_false
    top.above?(middle).should be_true

    left.left_of?(right).should be_true
    right.right_of?(left).should be_true
    left.left_of?(middle).should be_false
  end

end

describe "CardItem" do
  it "should have the opposite" do
    :CT.opposite.should == :CB
    :CB.opposite.should == :CT
    :MT.opposite.should == :MB
  end

  it "can align" do
    :CT.aligns?(:CB).should be_true
    :CT.aligns?(:MB).should_not be_true
  end
end


describe "Game" do
  it "should have 36 first possible combinations" do
    c = Cards.new
    step1 = c.step_1
    step1.size.should == 36

    step1[0][0].should == [c.cards[0]]
    step1[0][1].should_not include(c.cards[0])

    step1[1][0].should == [c.cards[0].rotate]
    step1[4][0].should == [c.cards[1]]
    step1[4][1].should_not include(c.cards[1])
  end

  it "should check rotated step 2" do
    c = Cards.new
    step1 = c.step_1[4]
    step2 = c.step_2(step1)
    step2.size.should == 4
    step2[0][0].should be_an Array
    step2[0][0].size.should == 2
    step2[0][1].should_not include(c.cards[3])
  end

  it "should check rotated step 3" do
    c = Cards.new
    step1 = c.step_1[4]
    step2 = c.step_2(step1)[0]
    #[1][3]
    step3 = c.step_3(step2)
    #[1][3][0RR]
    step3.size.should == 3
    step3[0][0][2].should == c.cards[0].rotate(2)
  end

  it "should check rotated step 4" do
    c = Cards.new
    step1 = c.step_1[4]
    step2 = c.step_2(step1)[0]
    #[1][3]
    step3 = c.step_3(step2)
    #[1][3][0RR]
    
    step4 = c.step_4(step3[0])
    step4.size.should == 2
    step4[0][0][0..2].should == step3[0][0]
  end
end
