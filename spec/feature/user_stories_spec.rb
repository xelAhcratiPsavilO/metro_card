describe 'User Stories' do

  let (:card) { Card.new() }

# In order to use public transport
# As a customer
# I want money on my card
  it 'Card has a balance' do
    expect(card.balance).to eq 0
  end
# In order to keep using public transport
# As a customer
# I want to add money to my card
  it 'Card can be topped up' do
    card.top_up 5
    expect(card.balance).to eq 5
  end
# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card
  it 'Card has a balance limit' do
    card.top_up Card::MAX_CREDIT
    expect { card.top_up 1 }.to raise_error 'Top up not allowed; Max limit reached'
  end

end
