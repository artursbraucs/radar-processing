RSpec.describe RadarProcessing do
  describe '.run' do
    before do
      stub_const('RadarProcessing::RADAR_INPUT_LOCATION', 'spec/fixtures/data/radar')
      stub_const('RadarProcessing::INVADERS_INPUT_LOCATION', 'spec/fixtures/data/invaders')
    end

    subject(:run) { described_class.run }
    let(:result_table) { fixture('results/table') }
    let(:result_radar) { fixture('results/radar') }

    it 'returns result table with matched data' do
      expect(run).to include(result_table)
    end

    it 'returns cleanded radar with result' do
      expect(run).to include(result_radar)
    end
  end
end
