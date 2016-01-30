require 'position'

class Rover
  attr_reader :instructions, :position

  def initialize(pos, instructions)
    @position = Position(pos)
    @instructions = instructions
  end

  def evaluate_destination
    instructions.chars.reduce(position) do |cur_pos, instruction|
      evaluate_instruction(cur_pos, instruction)
    end
  end

  private

  def evaluate_instruction(pos, instruction)
    case instruction
    when 'L' then pos.rotate_left
    when 'R' then pos.rotate_right
    when 'M' then pos.move_forward
    end
  end
end
