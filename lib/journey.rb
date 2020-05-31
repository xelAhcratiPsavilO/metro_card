class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def fare
    return 1 if complete?
    PENALTY_FARE
  end

  def finish(station)
    @exit_station = station
    self
  end

  def complete?
    exit_station
  end

end
