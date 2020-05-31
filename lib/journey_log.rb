class JourneyLog

  attr_reader :current_journey

  def initialize(journey)
    @journey = journey
    @journeys = []
  end

  def start(station)
    @current_journey = @journey.new(station)
    @journeys << current_journey
  end

  def finish(station)
    current_journey.finish(station)
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

end
