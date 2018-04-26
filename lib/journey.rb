class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def finish_journey(exit_station, balance)
    @exit_station = exit_station
  end

end
