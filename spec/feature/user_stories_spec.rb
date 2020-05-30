describe 'User Stories' do

  let (:card) { Card.new() }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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
  it 'Card has a max credit limit' do
    card.top_up Card::MAX_CREDIT
    expect { card.top_up 1 }.to raise_error 'Top up not allowed; Max credit reached'
  end
# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
  it 'Card can get a fare deducted' do
    card.top_up Card::MAX_CREDIT
    card.touch_out(:exit_station)
    expect(card.balance).to eq Card::MAX_CREDIT - Card::MIN_FARE
  end
# In order to get through the barriers.
# As a customer
# I need to touch in and out.
  it 'Card is initially not in a journey' do
    expect(card).not_to be_in_journey
  end
  it 'Card can be used to touch in' do
    card.top_up Card::MAX_CREDIT
    card.touch_in(:entry_station)
    expect(card).to be_in_journey
  end
  it 'Card can be used to touch out' do
    card.top_up Card::MAX_CREDIT
    card.touch_in(:entry_station)
    card.touch_out(:exit_station)
    expect(card).not_to be_in_journey
  end
# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.
  it 'Card has a min credit limit' do
    card.touch_in(:entry_station)
    expect { card.touch_out(:exit_station) }.to raise_error 'Payment not allowed; Min credit reached'
  end
# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card
  it 'Card deducts amount on touch out' do
    card.top_up Card::MAX_CREDIT
    card.touch_out(:exit_station)
    expect(card.balance).to eq Card::MAX_CREDIT - Card::MIN_FARE
  end
# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
  it 'Card records entry Station' do
    card.top_up Card::MAX_CREDIT
    card.touch_in(:entry_station)
    expect(card.entry_station).to be :entry_station
  end
# In order to know where I have been
# As a customer
# I want to see all my previous trips
  it 'Card records exit Station' do
    card.top_up Card::MAX_CREDIT
    card.touch_out(:exit_station)
    expect(card.exit_station).to be :exit_station
  end
  it 'Card has an empty list of journeys by default' do
    expect(card.journeys).to be_empty
  end

end
