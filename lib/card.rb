class Card

  MAX_CREDIT, MIN_CREDIT, MIN_FARE = 90, 0, 5

  attr_reader :balance

  def initialize(journey_log)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max credit reached' if max_reached?(money_in)
    add(money_in)
  end

  def touch_in(station)
    start_journey_at(station)
  end

  def touch_out(station)
    finish_journey_at(station)
    deduct_fare
  end

  private

  def max_reached?(money_in)
    (balance + money_in) > MAX_CREDIT
  end

  def min_reached(money_out)
    (balance - money_out) < MIN_CREDIT
  end

  def add(money_in)
    @balance += money_in
  end

  def deduct_fare
    raise 'Payment not allowed; Min credit reached' if min_reached(calculate_fare)
    @balance -= calculate_fare
  end

  def start_journey_at(station)
    @journey_log.start(station)
  end

  def finish_journey_at(station)
    @journey_log.finish(station)
  end

  def calculate_fare
    # @journey_log.journeys.empty? ? @journey_log.journeys.journey::PENALTY_FARE : @journey_log.journeys.last.fare
    @journey_log.journeys.last.fare
  end

end
