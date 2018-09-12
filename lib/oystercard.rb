require 'journey'

class Oystercard

  MAX_BALANCE = 90

  MIN_CHARGE = 1


  attr_reader :balance, :entry_station, :journey_history, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    @journey_history = []
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(tube_stop)
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_CHARGE
    journey.touch_in
  end

  def touch_out(tube_stop)
    deduct(MIN_CHARGE)
    journey.touch_in
  end

  private

  def deduct(money)
    @balance -= money
  end
end
