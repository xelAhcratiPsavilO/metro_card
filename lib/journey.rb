# frozen_string_literal: true

class Journey
  PENALTY_FARE = 6
  MIN_FARE = 1

  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    record_entry(station)
  end

  def fare
    select_fare
  end

  def finish(station)
    record_exit(station)
    self
  end

  def complete?
    exit_station && entry_station
  end

  private

  def select_fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  def record_exit(station)
    @exit_station = station
  end

  def record_entry(station)
    @entry_station = station
  end
end
