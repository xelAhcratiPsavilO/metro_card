class Card

  MAX_CREDIT, MIN_CREDIT = 90, 0

  attr_accessor :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max credit reached' if max_reached?(money_in)
    @balance += money_in
  end

  def deduct(money_out)
    raise 'Payment not allowed; Min credit reached' if min_reached(money_out)
    @balance -= money_out
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def max_reached?(money_in)
    (@balance + money_in) > MAX_CREDIT
  end

  def min_reached(money_out)
    (@balance - money_out) < MIN_CREDIT
  end

end
