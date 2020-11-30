class Oystercard
  
  attr_reader :balance

  BALANCE_LIMIT = 90

  def initialize(balance_limit = BALANCE_LIMIT)
    @balance = 0
    @balance_limit = balance_limit
  end

  def top_up(amount)
    limit(amount)
    @balance += amount
  end

  private
  
  def limit(amount)
    limit = @balance + amount
    fail "Balance limit of #{@balance_limit} exceeded" if limit > @balance_limit
  end

end