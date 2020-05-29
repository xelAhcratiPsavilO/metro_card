require 'card'

describe Card do

  subject(:card) { described_class.new(20) }

  describe '#balance' do
    it 'has a given value' do
      expect(card.balance).to eq 20
    end

  end

end
