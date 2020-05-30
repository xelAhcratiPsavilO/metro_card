describe 'User Stories' do

  let (:card) { Card.new() }
  let (:station) { Station.new('Station Name', 1) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

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

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it 'Card can be used to touch in' do
    expect(card).to respond_to :touch_in
  end
  it 'Card can be used to touch out' do
    expect(card).to respond_to :touch_out
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.
  it 'Card has a min credit limit' do
    card.touch_in entry_station
    expect { card.touch_out exit_station }.to raise_error 'Payment not allowed; Min credit reached'
  end

# In journey
  context 'when in journey' do
    before do
      card.top_up Card::MAX_CREDIT
      card.touch_in entry_station
    end

    # In order to pay for my journey
    # As a customer
    # I need my fare deducted from my card
    it 'Card can get a fare deducted' do
      card.touch_out exit_station
      expect(card.balance).to eq Card::MAX_CREDIT - Card::MIN_FARE
    end

    # In order to pay for my journey
    # As a customer
    # When my journey is complete, I need the correct amount deducted from my card
    it 'Card deducts amount on touch out' do
      card.touch_out exit_station
      expect(card.balance).to eq Card::MAX_CREDIT - Card::MIN_FARE
    end

    # In order to pay for my journey
    # As a customer
    # I need to know where I've travelled from

    # In order to know where I have been
    # As a customer
    # I want to see all my previous trips
    it 'The list of journeys can record a journey' do
      card.touch_out exit_station
      expect(card.journeys).to include journey
    end
  end

  # In order to know where I have been
  # As a customer
  # I want to see all my previous trips
  it 'Card has an empty list of journeys by default' do
    expect(card.journeys).to be_empty
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  it 'Station has a zone' do
    expect(station.zone).to eq(1)
  end

end
