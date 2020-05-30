require 'card'

describe Card do

  subject(:card) { described_class.new() }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

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

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'starts a journey' do
      card.touch_in entry_station
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'raises an error' do
      expect { card.touch_out exit_station }.to raise_error 'Payment not allowed; Min credit reached'
    end
    context 'when in journey' do
      before do
        card.top_up described_class::MAX_CREDIT
        card.touch_in entry_station
      end
      it 'finishes a journey' do
        card.touch_out exit_station
        expect(card).not_to be_in_journey
      end
      it 'deducts the min fare' do
        expect{ card.touch_out exit_station }.to change{ card.balance }.by -described_class::MIN_FARE
      end
    end
  end

  describe '#entry_station' do
    context 'when in journey' do
      before do
        card.top_up described_class::MAX_CREDIT
        card.touch_in entry_station
      end
      it 'records where the journey started' do
        expect(card.entry_station).to be entry_station
      end
    end
  end

  describe '#exit_station' do
    context 'when in journey' do
      before do
        card.top_up described_class::MAX_CREDIT
        card.touch_in entry_station
      end
      it 'records where the journey ends' do
        card.touch_out exit_station
        expect(card.exit_station).to be exit_station
      end
    end
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(card.journeys).to be_empty
    end
    context 'when in journey' do
      before do
        card.top_up described_class::MAX_CREDIT
        card.touch_in entry_station
      end
      it 'stores a journey' do
        card.touch_out exit_station
        expect(card.journeys).to include journey
      end
    end
  end

end
