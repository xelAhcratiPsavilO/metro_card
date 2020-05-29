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
      expect { card.top_up 1 }.to raise_error 'Top up not allowed; Max limit reached'
    end
  end

  describe '#deduct' do
    it 'decreases the balance of the card' do
      expect{ card.deduct 5 }.to change{ card.balance }.by -5
    end
  end

end
