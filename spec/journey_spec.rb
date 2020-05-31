# frozen_string_literal: true

require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station, zone: 1 }

  describe '#entry_station' do
    context 'when no entry station is given' do
      it 'has an entry station' do
        expect(journey.entry_station).to be_nil
      end
    end
    context 'when an entry station is given' do
      subject(:started_journey) { described_class.new(:entry_station) }
      it 'has an entry station' do
        expect(started_journey.entry_station).to eq :entry_station
      end
    end
  end

  describe '#completed?' do
    it 'records if a journey is not complete' do
      expect(journey).not_to be_complete
    end

    context 'when an entry station is given' do
      subject(:started_journey) { described_class.new(:entry_station) }

      context 'when an exit station is given' do
        let(:exit_station) { double :station }

        before do
          started_journey.finish(exit_station)
        end

        it 'records if a journey is complete' do
          expect(started_journey).to be_complete
        end
      end
    end
  end

  describe '#fare' do
    it 'has a default penalty fare' do
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end

    context 'when an entry station is given' do
      subject(:started_journey) { described_class.new(:entry_station) }

      it 'returns a penalty fare if no exit station given' do
        expect(started_journey.fare).to eq described_class::PENALTY_FARE
      end

      context 'when an exit station is given' do
        let(:exit_station) { double :station }

        before do
          started_journey.finish(exit_station)
        end

        it 'calculates a fare' do
          expect(started_journey.fare).to eq described_class::MIN_FARE
        end
      end
    end
  end

  describe '#finish' do
    it 'returns itself when journey is completed' do
      expect(journey.finish(station)).to eq journey
    end
  end
end
