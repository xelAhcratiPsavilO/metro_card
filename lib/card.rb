class Card

  MAX_CREDIT, MIN_CREDIT, MIN_FARE = 90, 0, 5

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max credit reached' if max_reached?(money_in)
    @balance += money_in
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    !!entry_station
  end

  private

  def max_reached?(money_in)
    (balance + money_in) > MAX_CREDIT
  end

  def min_reached(money_out)
    (balance - money_out) < MIN_CREDIT
  end

  def deduct(money_out)
    raise 'Payment not allowed; Min credit reached' if min_reached(money_out)
    @balance -= money_out
  end

end
