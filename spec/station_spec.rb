require 'station'

describe Station do

  subject(:station) { described_class.new('Station Name', 1) }

  describe '#name' do
    it 'knows its name' do
      expect(station.name).to eq 'Station Name'
    end
  end

  describe '#zone' do
    it 'knows its zone' do
      expect(station.zone).to eq 1
    end
  end
end
