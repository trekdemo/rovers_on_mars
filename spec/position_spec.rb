require 'position'

RSpec.describe Position do
  describe '.initialize' do
    it 'casts the inputs' do
      {
        ['1', '2', 'N'] => [1, 2, 'N'],
        ['1', 2, 'n'] => [1, 2, 'N'],
        [1, 2, 'N'] => [1, 2, 'N'],
        [1, '2', 'N'] => [1, 2, 'N'],
      }.each do |params, expectation|
        expect(described_class.new(*params).to_a).to eq(expectation)
      end
    end

    it 'rases error on invalid orientation' do
      expect { described_class.new(1, 2, 'u') }
        .to raise_error(ArgumentError)
    end
  end

  describe '#to_a' do
    it 'returns an Array representation' do
      expect(described_class.new(1, 2, 'N').to_a)
        .to eq([1, 2, 'N'])
    end
  end

  describe '#==' do
    subject { described_class.new(1, 2, 'N') }

    it 'returns true if all attributes are equal' do
      expect(subject).to eq(described_class.new(1, 2, 'N'))
    end

    context 'when x is not equal' do
      specify { expect(subject).to_not eq(described_class.new(2, 2, 'N')) }
    end

    context 'when y is not equal' do
      specify { expect(subject).to_not eq(described_class.new(1, 1, 'N')) }
    end

    context 'when orientation is not equal' do
      specify { expect(subject).to_not eq(described_class.new(1, 2, 'E')) }
    end
  end

  describe '#rotate_left' do
    subject { described_class.new(1, 2, orientation) }

    {'N' => 'W', 'S' => 'E', 'E' => 'N', 'W' => 'S'}.each do |heading, expectation|
      context "when heading #{heading}" do
        let(:orientation) { heading }
        let(:new_position) { subject.rotate_left }

        specify { expect(new_position.orientation).to eq(expectation) }

        it 'keeps the coordinates' do
          expect(new_position.x).to eq(subject.x)
          expect(new_position.y).to eq(subject.y)
        end
      end
    end
  end

  describe '#rotate_right' do
    subject { described_class.new(1, 2, orientation) }

    {'N' => 'E', 'S' => 'W', 'E' => 'S', 'W' => 'N'}.each do |heading, expectation|
      context "when heading #{heading}" do
        let(:orientation) { heading }
        let(:new_position) { subject.rotate_right }

        specify { expect(new_position.orientation).to eq(expectation) }

        it 'keeps the coordinates' do
          expect(new_position.x).to eq(subject.x)
          expect(new_position.y).to eq(subject.y)
        end
      end
    end
  end

  describe '#move_forward' do
    subject { described_class.new(1, 2, orientation) }

    {
      'N' => [1, 3],
      'S' => [1, 1],
      'E' => [2, 2],
      'W' => [0, 2],
    }.each do |heading, expectation|
      context "when heading #{heading}" do
        let(:orientation) { heading }
        let(:new_position) { subject.move_forward }

        it 'keeps the orientation' do
          expect(new_position.orientation).to eq(subject.orientation)
        end

        it 'has new coordinates' do
          expect(new_position.x).to eq(expectation.first)
          expect(new_position.y).to eq(expectation.last)
        end
      end
    end
  end
end
