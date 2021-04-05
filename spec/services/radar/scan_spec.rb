RSpec.describe RadarProcessing::Radar::Scan do
  describe '#call' do
    subject(:call) do
      described_class.new(
        matrix, finder: finder, known_invaders: known_invaders
      ).call
    end

    let(:matrix) do
      Matrix.build(5, 5) { '-' }
    end
    let(:finder) { double(:finder) }
    let(:known_invaders) do
      [
        Matrix.build(3, 3) { 'o' },
        Matrix.build(2, 2) { 'o' }
      ]
    end

    before do
      known_invaders.each do |invader|
        matrix.each_with_index do |_, row, col|
          if invader == known_invaders[0] && row == 2 && col == 2
            allow(finder).
              to receive(:call).
              with(invader, row: row - 1, col: col - 1).
              and_return({ origin: :origin, match: 0.8 })
          else
            allow(finder).to receive(:call).with(invader, row: row - 1, col: col - 1)
          end
        end
      end
    end

    it 'returns result for scanned invaders' do
      expect(call).to eq(
        {
          [1, 1] => {
            invader: Matrix[%w[o o o], %w[o o o], %w[o o o]],
            match: 0.8,
            origin: :origin
          }
        }
      )
    end
  end
end
