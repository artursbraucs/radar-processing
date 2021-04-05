RSpec.describe RadarProcessing::Readers::ReadRadar do
  describe '#call' do
    subject(:call) { described_class.new(path).call }

    context 'when path to existing file' do
      let(:path) { 'spec/fixtures/data/dummy/test' }

      it 'returns matrix with radar' do
        expect(call).to eq(
          RadarProcessing::Matrix[%w[- - o -], %w[- o o -]]
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
