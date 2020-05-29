class Card

  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end

  def top_up(money_in)
    @balance += money_in
  end

end
