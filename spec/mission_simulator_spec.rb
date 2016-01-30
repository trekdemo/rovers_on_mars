require 'mission_simulator'

FIXTURES_PATH = Pathname(File.expand_path('../fixtures', __FILE__))

def load_mission_expectations(version)
  File.read(FIXTURES_PATH.join("mission#{version}_expectation.txt"))
end

RSpec.describe MissionSimulator do
  let(:mission_version) { '01' }
  let(:mission_path) { FIXTURES_PATH.join("mission#{mission_version}.txt") }
  let(:mission_expectation) { load_mission_expectations(mission_version) }

  subject { described_class.new(mission_path) }

  describe '#simulate' do
    it 'should return expected formatted output' do
      expect(subject.simulate).to eq(mission_expectation)
    end
  end
end
