RSpec.describe RadarProcessing::Matrix::ReplaceElements do
  describe '#call' do
    subject(:call) do
      described_class.new(
        matrix,
        replace_with: replace_with
      ).call
    end

    let(:matrix) do
      RadarProcessing::Matrix.build(5, 5) { '-' }
    end

    context 'when replace withing bounds' do
      let(:replace_with) do
        { [1, 1] => (RadarProcessing::Matrix.build(2, 2) { 'o' }) }
      end

      it 'replaces part of matrix with sub matrix' do
        expect(call).to eq(
          Matrix[
            %w[- - - - -],
            %w[- o o - -],
            %w[- o o - -],
            %w[- - - - -],
            %w[- - - - -]
          ]
        )
      end
    end

    context 'when out of bounds' do
      let(:replace_with) do
        { [4, 4] => (RadarProcessing::Matrix.build(2, 2) { 'o' }) }
      end

      it 'replaces elements within bounds only' do
        expect(call).to eq(
          Matrix[
            %w[- - - - -],
            %w[- - - - -],
            %w[- - - - -],
            %w[- - - - -],
            %w[- - - - o]
          ]
        )
      end
    end
  end
end
