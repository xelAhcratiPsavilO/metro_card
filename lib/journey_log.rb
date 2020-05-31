# frozen_string_literal: true

class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class)
    @journey = journey_class
    @journeys = []
  end

  def start(station)
    record_entry(station)
    record_journey
  end

  def finish(station)
    record_exit(station)
    close_current_journey
  end

  def journeys
    @journeys.dup
  end

  private

  def record_entry(station)
    @current_journey = @journey.new(station)
  end

  def record_journey
    @journeys << current_journey
  end

  def record_exit(station)
    @current_journey ||= @journey.new
    current_journey.finish(station)
    record_journey if @journeys.last != current_journey
  end

  def close_current_journey
    @current_journey = nil
  end
end
