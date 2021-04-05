RSpec.describe RadarProcessing::Cli::FormatResult do
  describe '#call' do
    subject(:call) { described_class.new(rows: 20, cols: 20, result: result).call }
    let(:result) do
      {
        [1, 2] => { invader: Matrix[%w[- o -], %w[o o o], %w[- o -]], match: 0.7 },
        [6, 5] => { invader: Matrix[%w[o o o], %w[- o -], %w[- o -]], match: 0.8 }
      }
    end

    it 'prepares result table' do
      expect(call).to include(
        ">> Total matched count: 2\n" \
        "| Location   | Match      |\n" \
        "| ---------- | ---------- |\n" \
        "| [1, 2]     | 0.7        |\n" \
        '| [6, 5]     | 0.8        |'
      )
    end

    it 'prepares result matrix' do
      expect(call).to include(
        "--------------------\n" \
        "---o----------------\n" \
        "--ooo---------------\n" \
        "---o----------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "-----ooo------------\n" \
        "------o-------------\n" \
        "------o-------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        "--------------------\n" \
        '--------------------'
      )
    end
  end
end
