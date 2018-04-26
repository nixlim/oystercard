DEFAULT_BALANCE = 0
MAX_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1

class Oystercard
  attr_reader :balance, :list_of_journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def touch_in(station)
    if @list_of_journeys.empty?
      Journey.new(station).fare()
    elsif @list_of_journeys.last[:complete] == :incomplete
      Journey.new(station).fare(:penalty)  
    else
     raise 'Insufficient funds for a journey' if balance < MINIMUM_BALANCE
     @journey = { entry_station: station }
    end
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @list_of_journeys << @journey.merge({ exit_station: station })
    @journey = nil
  end

  def in_journey?
      !@journey.nil?
  end

private

  def deduct(amount)
    "Your total balance is £#{@balance -= amount}"
  end

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
