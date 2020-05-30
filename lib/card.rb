class Card

  MAX_CREDIT, MIN_CREDIT, MIN_FARE = 90, 0, 5

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max credit reached' if max_reached?(money_in)
    @balance += money_in
  end

  def touch_in(station)
    record_entry(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    record_exit(station)
    record_journey
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

  def record_entry(station)
    @journey = {:entry_station => station}
  end

  def record_exit(station)
    @journey[:exit_station] = station
  end

  def record_journey
    @journeys << @journey
  end

end
