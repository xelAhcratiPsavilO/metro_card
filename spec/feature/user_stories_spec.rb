describe 'User Stories' do

  let (:card) { Card.new(20) }

# In order to use public transport
# As a customer
# I want money on my card
it 'Card has a balance' do
  expect(card.balance).to eq 20
end

end
