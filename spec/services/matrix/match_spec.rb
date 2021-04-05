RSpec.describe RadarProcessing::Matrix::Match do
  describe '#call' do
    subject(:call) do
      described_class.new(
        matrix, other, required_elements: required_elements
      ).call
    end

    let(:required_elements) { 0.7 }

    context 'when matrix dimmensions matches' do
      let(:matrix) do
        Matrix[%w[- o - o -], %w[- o o o -]]
      end

      let(:other) do
        Matrix[%w[- o - o -], %w[- o - o -]]
      end

      it 'returns match' do
        expect(call).to eq(0.9)
      end
    end

    context 'when matrix dimmensions does not matches' do
      let(:matrix) do
        Matrix[%w[- o - o -], %w[- o o o -]]
      end

      let(:other) do
        Matrix[%w[- o - o -]]
      end

      it 'returns zero match' do
        expect(call).to eq(0)
      end
    end

    context 'when matrix have nils' do
      let(:matrix) do
        Matrix[%w[- o -], %w[- o -], %w[- o -], [nil, nil, nil]]
      end

      let(:other) do
        Matrix[%w[- o -], %w[- o -], %w[o - o], %w[- - -]]
      end

      it 'returns zero match' do
        expect(call).to eq(0.75)
      end
    end
  end
end
