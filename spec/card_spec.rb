require 'card'

describe Card do

  subject(:card) { described_class.new() }
  let(:station) { double :station }

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
      card.touch_in(:station)
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'raises an error' do
      expect { card.touch_out }.to raise_error 'Payment not allowed; Min credit reached'
    end
    it 'finishes a journey' do
      card.top_up described_class::MAX_CREDIT
      card.touch_out
      expect(card).not_to be_in_journey
    end
    it 'deducts the min fare' do
      card.top_up described_class::MAX_CREDIT
      expect{ card.touch_out }.to change{ card.balance }.by -described_class::MIN_FARE
    end
  end

  describe '#entry_station' do
    it 'records where the journey started' do
      card.touch_in(:station)
      expect(card.entry_station).to be :station
    end
  end

end
