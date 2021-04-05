RSpec.describe RadarProcessing::Matrix do
  subject(:matrix) { described_class[*data] }

  describe '#take_part' do
    let(:data) do
      [%w[1a 1b 1c], %w[2a 2b 2c], %w[3a 3b 3c]]
    end

    context 'when part in bounds' do
      it 'returns new matrix with elements' do
        expect(
          matrix.take_part(row: 1, col: 1, rows: 2, cols: 2)
        ).to eq(
          described_class[%w[2b 2c], %w[3b 3c]]
        )
      end
    end

    context 'when part bounds partially' do
      it 'returns new matrix with elements and non existing replace with nils' do
        expect(
          matrix.take_part(row: 1, col: 1, rows: 3, cols: 3)
        ).to eq(
          described_class[['2b', '2c', nil], ['3b', '3c', nil], [nil, nil, nil]]
        )
      end
    end

    context 'when part fully out of bounds' do
      it 'returns new matrix with nils' do
        expect(
          matrix.take_part(row: 3, col: 3, rows: 2, cols: 2)
        ).to eq(
          described_class[[nil, nil], [nil, nil]]
        )
      end
    end
  end

  describe '#to_joined_string' do
    let(:data) do
      [%w[1a 1b 1c], %w[2a 2b 2c]]
    end

    it 'returns joined string with newlines for rows' do
      expect(
        matrix.to_joined_string
      ).to eq(
        "1a1b1c\n2a2b2c"
      )
    end
  end
end
