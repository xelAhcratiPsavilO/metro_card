describe 'User Stories' do

  let (:card) { Card.new(20) }

# In order to use public transport
# As a customer
# I want money on my card
it 'Card has a balance' do
  expect(card.balance).to eq 20
end
# In order to keep using public transport
# As a customer
# I want to add money to my card
it 'Card can be topped up' do
  card.top_up(5)
  expect(card.balance).to eq 25
end

end
