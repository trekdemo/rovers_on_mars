require 'mission_file_reader'

RSpec.describe MissionFileReader do
  let(:mission_path) { FIXTURES_PATH.join("mission01.txt") }
  subject { described_class.new(mission_path) }

  describe '#rover_data' do
    it 'should parse the rover data from the file' do
      expect(subject.rover_data).to eq([
        [Position(1,2,'N'), "LMLMLMLMM"],
        [Position(3,3,'E'), "MMRMMRMRRM"],
      ])
    end
  end
end

