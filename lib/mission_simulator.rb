require 'rover'
require 'mission_file_reader'

class MissionSimulator
  attr_reader :rovers, :plateau_size

  def initialize(mission_file_path)
    @mission_file = MissionFileReader.new(mission_file_path)
    @rovers = @mission_file.rover_data.map do |rover_params|
      Rover.new(rover_params[0], rover_params[1])
    end

    @plateau_size = @mission_file.plateau_size
  end

  def evaluate_destinations
    rovers.map(&:evaluate_destination)
  end

  def report_destinations
    format_output(evaluate_destinations)
  end

  private

  def format_output(positions)
    positions
      .map { |pos| pos.to_a.join(' ') << "\n" }
      .join("\n")
  end
end
