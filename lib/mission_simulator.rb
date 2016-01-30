require 'rover'
require 'mission_file_reader'

class MissionSimulator
  attr_reader :rovers

  def initialize(mission_file_path)
    @mission_file = MissionFileReader.new(mission_file_path)
    @rovers = @mission_file.rover_data.map do |rover_params|
      Rover.new(rover_params[0], rover_params[1])
    end
  end

  def evaluate_destinations
    format_output(rovers.map(&:evaluate_destination))
  end

  private

  def format_output(positions)
    positions
      .map { |pos| pos.join(' ') << "\n" }
      .join("\n")
  end
end
