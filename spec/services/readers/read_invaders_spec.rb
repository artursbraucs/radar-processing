RSpec.describe RadarProcessing::Readers::ReadInvaders do
  describe '#call' do
    subject(:call) { described_class.new(path).call }

    context 'when path to existing file' do
      let(:path) { 'spec/fixtures/data/dummy' }

      it 'returns matrix with radar' do
        expect(call).to eq(
          [
            RadarProcessing::Matrix[%w[- - o -], %w[- o o -]],
            RadarProcessing::Matrix[%w[o -], %w[- o]]
          ]
        )
      end
    end

    context 'when path to non existing file' do
      let(:path) { 'foo' }

      it 'raises error' do
        expect { call }.to raise_error(
          Errno::ENOENT
        )
      end
    end
  end
end
