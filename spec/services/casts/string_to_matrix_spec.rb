RSpec.describe RadarProcessing::Casts::StringToMatrix do
  describe '#call' do
    subject(:call) { described_class.new(data).call }

    context 'when dimmensions matches' do
      let(:data) do
        "abc\ndef"
      end

      it 'returns matrix splited by chars and newlines' do
        expect(call).to eq(
          RadarProcessing::Matrix[%w[a b c], %w[d e f]]
        )
      end
    end

    context 'when dimmensions mismatches' do
      let(:data) do
        "abc\nde"
      end

      it 'returns matrix splited by chars and newlines' do
        expect { call }.to raise_error(
          ExceptionForMatrix::ErrDimensionMismatch
        )
      end
    end
  end
end
