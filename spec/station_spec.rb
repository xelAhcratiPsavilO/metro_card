# frozen_string_literal: true

require 'station'

describe Station do
  subject(:station) { described_class.new(:name, 1) }

  describe '#name' do
    it 'returns its name' do
      expect(station.name).to eq :name
    end
  end

  describe '#zone' do
    it 'returns its zone' do
      expect(station.zone).to eq 1
    end
  end
end
