require 'position'

class Rover
  attr_reader :instructions, :position

  def initialize(pos, instructions)
    @position = Position(pos)
    @instructions = instructions.to_s.upcase

    unless instructions.match(/[LRM]*/)
      fail ArgumentError, "Invalid instructions: #{instructions}"
    end
  end

  def waypoints
    instructions.chars.reduce([position]) do |points, instruction|
      points.concat([evaluate_instruction(points.last, instruction)])
    end
  end

  def evaluate_destination
    waypoints.last
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
