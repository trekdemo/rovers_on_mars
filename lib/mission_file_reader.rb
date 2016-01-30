require 'position'

class MissionFileReader
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def rover_data
    line_seq.drop(1).each_slice(2).map do |(position, instructions)|
      x, y, orientation = position.split(' ')

      [Position(x.to_i, y.to_i, orientation), instructions]
    end
  end

  private

  def line_seq
    File.new(path)
      .map(&:strip)      # Clear the input lines
      .reject(&:empty?)  # Skip empty lines
  end
end

