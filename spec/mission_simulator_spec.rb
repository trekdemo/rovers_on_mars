require 'mission_simulator'

RSpec.describe MissionSimulator do
  def load_mission_expectations(version)
    File.read(FIXTURES_PATH.join("mission#{version}_expectation.txt"))
  end

  let(:mission_version) { '01' }
  let(:mission_path) { FIXTURES_PATH.join("mission#{mission_version}.txt") }
  let(:mission_expectation) { load_mission_expectations(mission_version) }

  subject { described_class.new(mission_path) }

  describe '#rovers' do
    specify { expect(subject.rovers.count).to eq(2) }
  end

  describe '#report_destinations' do
    it 'should return expected formatted output' do
      expect(subject.report_destinations).to eq(mission_expectation)
    end
  end
end
