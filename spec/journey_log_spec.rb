require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey) }
  let(:journey) { double :journey }
  let(:station) { double :station }

  describe '#start' do
    it 'starts a journey' do
      expect(journey).to receive(:new).with(station)
      journey_log.start(station)
    end

    it 'records a journey' do
      allow(journey).to receive(:new).and_return journey
      journey_log.start(station)
      expect(journey_log.journeys).to include journey
    end
  end

  describe '#finish' do
    it 'adds an exit station' do
      allow(journey).to receive(:new).and_return journey
      journey_log.start(station)
      expect(journey).to receive(:finish).with(station)
      journey_log.finish(station)
    end

    it 'sets the current journey to nil' do
      allow(journey).to receive(:new).and_return journey
      allow(journey).to receive(:finish).and_return journey
      journey_log.start(station)
      journey_log.finish(station)
      expect(journey_log.current_journey).to be_nil
    end
  end

  describe '#current_journey' do
    context 'when no journey has started' do
      it 'is nil' do
        expect(journey_log.current_journey).to be_nil
      end
    end

    context 'when a journey has started' do
      it 'returns the current journey' do
        allow(journey).to receive(:new).and_return journey
        journey_log.start(station)
        expect(journey_log.current_journey).to be journey
      end

    end

    context 'when a journey has finished' do
      it 'is nil' do
        allow(journey).to receive(:new).and_return journey
        allow(journey).to receive(:finish).and_return journey
        journey_log.start(station)
        journey_log.finish(station)
        expect(journey_log.current_journey).to be_nil
      end
    end
  end
end
