require 'card'

describe Card do

  subject(:card) { described_class.new(journey_log) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  let(:journey_log) { double :journey_log }

  describe '#balance' do
    it 'starts at zero' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance of the card' do
      expect{ card.top_up 5 }.to change{ card.balance }.by 5
    end
    it 'raises an error' do
      card.top_up described_class::MAX_CREDIT
      expect { card.top_up 1 }.to raise_error 'Top up not allowed; Max credit reached'
    end
  end

  describe '#touch_out' do
    it 'raises an error' do
      allow(journey_log).to receive(:finish)
      allow(journey_log).to receive(:journeys)
      allow(nil).to receive(:last)
      allow(nil).to receive(:fare).and_return(1)
      expect { card.touch_out exit_station }.to raise_error 'Payment not allowed; Min credit reached'
    end
  end

end
