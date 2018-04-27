require_relative 'journey'
DEFAULT_BALANCE = 0
MAX_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1

class Oystercard
  attr_reader :balance, :list_of_journeys

  def initialize(journey = Journey.new)
    @balance = DEFAULT_BALANCE
    @list_of_journeys = []
    @journey = journey
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def touch_in(station)
    raise 'Insufficient funds for a journey' if balance < MINIMUM_BALANCE
    @journey.start_journey(station)

  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @list_of_journeys << @journey.merge({ exit_station: station })
    @journey = nil
  end


private

  def deduct(amount)
    "Your total balance is £#{@balance -= amount}"
  end

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
