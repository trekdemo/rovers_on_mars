class Rover
  attr_reader :instructions
  attr_reader

  def initialize(pos, instructions)
    @x, @y, @orientation = *pos
    @instructions = instructions
  end

  def position
    [@x, @y, @orientation]
  end

  def evaluate_destination
    instructions.chars.reduce(position) do |cur_pos, instruction|
      evaluate_instruction(cur_pos, instruction)
    end
  end

  private

  def evaluate_instruction(pos, instruction)
    case instruction
    when 'L' then rotate_left(pos)
    when 'R' then rotate_right(pos)
    when 'M' then move_forward(pos)
    end
  end

  def rotate_left(pos)
    x, y, o = *pos
    case o
    when 'N' then [x, y, 'W']
    when 'S' then [x, y, 'E']
    when 'W' then [x, y, 'S']
    when 'E' then [x, y, 'N']
    end
  end

  def rotate_right(pos)
    x, y, o = *pos
    case o
    when 'N' then [x, y, 'E']
    when 'S' then [x, y, 'W']
    when 'W' then [x, y, 'N']
    when 'E' then [x, y, 'S']
    end
  end

  def move_forward(pos)
    x, y, o = *pos
    case o
    when 'N' then [x,   y+1, o]
    when 'S' then [x,   y-1, o]
    when 'W' then [x-1, y,   o]
    when 'E' then [x+1, y,   o]
    end
  end
end

class MissionFileReader
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def rover_data
    line_seq.drop(1).each_slice(2).map do |(position, instructions)|
      x, y, orientation = position.split(' ')

      [[x.to_i, y.to_i, orientation], instructions]
    end
  end

  private

  def line_seq
    File.new(path)
      .map(&:strip)      # Clear the input data
      .reject(&:empty?)  # Skip empty lines
  end
end

class MissionSimulator
  attr_reader :rovers

  def initialize(mission_file_path)
    @mission_file = MissionFileReader.new(mission_file_path)
    @rovers = @mission_file.rover_data.map do |rover_params|
      Rover.new(rover_params[0], rover_params[1])
    end
  end

  def evaluate_destinations
    rovers
      .map(&:evaluate_destination)
      .map { |pos| pos.join(' ') << "\n" }
      .join("\n")
  end
end
