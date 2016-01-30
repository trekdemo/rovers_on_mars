require 'rover'

RSpec.describe Rover do
  describe '.initialize' do
    subject { described_class.new(position, '') }

    context 'when position is an Array' do
      let(:position) { [1, 2, 'N'] }
      it 'converts position argument into Position' do
        expect(subject.position).to be_kind_of(Position)
      end
    end

    context 'when position is a Position' do
      let(:position) { Position(1, 2, 'N') }
      it 'converts position argument into Position' do
        expect(subject.position).to be_kind_of(Position)
      end
    end
  end
end
