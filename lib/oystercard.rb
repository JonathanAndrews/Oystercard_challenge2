require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90

  PENALTY_CHARGE = 6

  MIN_CHARGE = 1


  attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(tube_stop)
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_CHARGE
    journey.touch_in(tube_stop)
  end

  def touch_out(tube_stop)
    deduct(fare)
    journey.touch_out(tube_stop)
  end

  def journey_history
    journey.journey_history
  end

  def fare
    return PENALTY_CHARGE if journey.no_touch_in?
    return PENALTY_CHARGE + MIN_CHARGE if journey.no_touch_out?
    MIN_CHARGE
  end

  private

  def deduct(money)
    @balance -= money
  end
end
