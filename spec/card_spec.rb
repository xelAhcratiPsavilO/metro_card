require 'card'

describe Card do

  subject(:card) { described_class.new(20) }

  describe '#balance' do
    it 'has a given value' do
      expect(card.balance).to eq 20
    end
  end

  describe '#top_up' do
    it 'increases the balance of the card' do
      expect{ card.top_up 5 }.to change{ card.balance }.by 5
    end
  end

end
