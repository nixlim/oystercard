class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def complete?
    exit_station.nil? || entry_station.nil? ? false : true
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
