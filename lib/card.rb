class Card

  MAX_CREDIT = 90

  attr_accessor :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max limit reached' if limit_reached?(money_in)
    @balance += money_in
  end

  def deduct(money_out)
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

  def limit_reached?(money_in)
    (@balance + money_in) > MAX_CREDIT
  end

end
