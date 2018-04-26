require_relative 'journey'
DEFAULT_BALANCE = 0
MAX_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1

class Oystercard
  attr_reader :balance, :list_of_journeys

  def initialize(journey_class = Journey)
    @balance = DEFAULT_BALANCE
    @list_of_journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def touch_in(station)
    if in_journey?
      touch_out(station)
      raise 'Did not touch out on last journey, please touch in again.'
    else
      @current_journey = @journey_class.new(station)
      @current_journey.fare()
      raise 'Insufficient funds for a journey' if balance < MINIMUM_BALANCE
      @journey = { entry_station: station, complete: @current_journey.complete? }
    end
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @list_of_journeys << @journey.merge({ exit_station: station })
    @journey = nil
  end

  def in_journey?
      !@current_journey.complete?
  end

private

  def deduct(amount)
    "Your total balance is £#{@balance -= amount}"
  end

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
