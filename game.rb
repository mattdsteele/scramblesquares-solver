class Symbol
  def opposite
    as_string = to_s
    type = as_string[0,1]
    ord = as_string[1,1] == 'T' ? 'B' : 'T'
    (type + ord).to_sym
  end

  def aligns?(candidate)
    opposite == candidate
  end
end

class Array
  def rotate(number = 1)
    item = self + []
    number.times { item << (item.shift) }
    item
  end
  def rotate_perms
    [self+[], rotate, rotate(2), rotate(3)]
  end
  def top
    self[0]
  end
  def bottom
    self[2]
  end
  def left
    self[3]
  end
  def right
    self[1]
  end

  def below?(candidate)
    top.aligns? candidate.bottom
  end

  def above?(candidate)
    bottom.aligns? candidate.top
  end

  def left_of?(candidate)
    right.aligns? candidate.left
  end

  def right_of?(candidate)
    left.aligns? candidate.right
  end
end
class Cards
  attr_accessor :cards

  def initialize
    @cards = [
      [:CT, :BT, :WB, :MT],
      [:MB, :CT, :BB, :WT],
      [:WB, :BB, :MT, :WT],
      [:MT, :BB, :BT, :CB],
      [:BB, :CB, :MB, :WT],
      [:MT, :WB, :BT, :CT],
      [:BT, :MT, :CT, :CB],
      [:MT, :WB, :BB, :CT],
      [:CB, :WB, :MB, :WT]
    ]
  end

  def solve
    cards = @cards
    card = cards.shift
  end

  def step_1
    valid_step_1 = []
    @cards.each do |c|
      temp = @cards + []
      temp.delete c
      valid_step_1 << [[c], temp]
      valid_step_1 << [[c.rotate], temp]
      valid_step_1 << [[c.rotate(2)], temp]
      valid_step_1 << [[c.rotate(3)], temp]
    end
    valid_step_1
  end

  def step_2(prev_state)
    next_step(prev_state) {|p, steps| p.right_of? steps[0] }
  end

  def step_3(prev_state)
    next_step(prev_state) { |p, steps| p.right_of? steps[1] }
  end

  def step_4(prev_state)
    next_step(prev_state) { |p, steps| p.below? steps[0] }
  end

  def step_5(prev_state)
    next_step(prev_state) do |p, steps| 
      (p.below? steps[1]) && (p.right_of? steps[3])
    end
  end

  def step_6(prev_state)
    next_step(prev_state) do |p, steps| 
      (p.below? steps[2]) && (p.right_of? steps[4])
    end
  end

  def step_7(prev_state)
    next_step(prev_state) { |p, steps| p.below? steps[3] }
  end

  def step_8(prev_state)
    next_step(prev_state) do |p, steps| 
      (p.below? steps[4]) && (p.right_of? steps[6])
    end
  end

  def step_9(prev_state)
    next_step(prev_state) do |p, steps| 
      (p.below? steps[5]) && (p.right_of? steps[7])
    end
  end

  def next_step(prev_state)
    new_state = []
    leftover_items = prev_state[1]

    leftover_items.each do |c|
      temp = leftover_items + []
      temp.delete c
      c.rotate_perms.each do |p|
        valid_steps = prev_state[0]
        if (yield(p, valid_steps))
          new_state << [prev_state[0] + [p], temp]
        end
      end
    end
    new_state
  end

  def play_game
    working_states = []
    after_1 = step_1
    i = 0
    after_1.each do |state_1|
      after_2 = step_2(state_1)
      after_2.each do |state_2|
        after_3 = step_3(state_2)
        after_3.each do |state_3|
          after_4 = step_4(state_3)
          after_4.each do |state_4|
            after_5 = step_5(state_4)
            after_5.each do |state_5|
              step_6(state_5).each do |state_6|
                step_7(state_6).each do |state_7|
                  step_8(state_7).each do |state_8|
                    step_9(state_8).each do |state_9|
                      working_states << state_9[0]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end 
    puts "Valid states: "
    working_states.uniq.each {|i| puts i.to_s}
  end
end

