class Oystercard
  
  attr_reader :balance

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance_limit = BALANCE_LIMIT)
    @balance = 0
    @balance_limit = balance_limit
    @card_in_use = false
  end

  def top_up(amount)
    limit(amount)
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  public
  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @card_in_use = true
  end

  def in_journey?
    @card_in_use
  end

  def touch_out
    @card_in_use = false
    @balance -= MINIMUM_FARE
    @balance
  end

  private
  
  def limit(amount)
    limit = @balance + amount
    fail "Balance limit of #{@balance_limit} exceeded" if limit > @balance_limit
  end

end