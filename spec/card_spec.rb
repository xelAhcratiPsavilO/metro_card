require 'card'

describe Card do

  subject(:card) { described_class.new() }

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

  describe '#deduct' do
    it 'decreases the balance of the card' do
      card.top_up 10
      expect{ card.deduct 5 }.to change{ card.balance }.by -5
    end
    it 'raises an error' do
      expect { card.deduct 1 }.to raise_error 'Payment not allowed; Min credit reached'
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'starts a journey' do
      card.touch_in
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'finishes a journey' do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end
  end

end
