RSpec.describe RadarProcessing::Matrix::OnceFinder do
  subject(:finder) do
    described_class.new(
      matrix,
      tollerance: tollerance,
      matcher_class: match_class
    )
  end

  describe '#call' do
    let(:matrix) do
      RadarProcessing::Matrix.build(100, 100) { '-' }
    end

    let(:other) do
      RadarProcessing::Matrix.build(10, 10) { '-' }
    end

    let(:tollerance) { 0.25 }

    let(:match_class) { class_double('RadarProcessing::Matrix::Match') }
    let(:match_instance) { double(:matcher) }

    before do
      allow(match_instance).to receive('call').and_return(match_result)
      allow(match_class).to receive('new').and_return(match_instance)
    end

    context 'when match in tollerance' do
      let(:match_result) { 0.75 }

      context 'when called first time' do
        it 'returns result' do
          expect(finder.call(other, row: 1, col: 1)).to include(
            { match: 0.75 }
          )
        end
      end

      context 'when called second time within found coordinates' do
        before do
          finder.call(other, row: 1, col: 1)
        end

        it 'returns nil' do
          expect(finder.call(other, row: 5, col: 5)).to be(nil)
        end
      end
    end

    context 'when does not match in tollerance' do
      let(:match_result) { 0.6 }

      it 'returns nil' do
        expect(finder.call(other, row: 5, col: 5)).to be(nil)
      end
    end
  end
end
