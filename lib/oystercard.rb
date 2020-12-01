class Oystercard
  attr_reader :balance, :entry_station

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance_limit = BALANCE_LIMIT)
    @balance = 0
    @balance_limit = balance_limit
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

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out
    @balance -= MINIMUM_FARE
    @balance
    @entry_station = nil
  end

  private

  def limit(amount)
    limit = @balance + amount
    fail "Balance limit of #{@balance_limit} exceeded" if limit > @balance_limit
  end
end
