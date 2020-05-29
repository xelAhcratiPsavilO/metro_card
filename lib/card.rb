class Card

  MAX_CREDIT = 90

  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(money_in)
    raise 'Top up not allowed; Max limit reached' if limit_reached?(money_in)
    @balance += money_in
  end

  def deduct(money_out)
    @balance -= money_out
  end

  private

  def limit_reached?(money_in)
    (@balance + money_in) > MAX_CREDIT
  end

end
