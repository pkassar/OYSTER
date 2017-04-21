class Journey

  attr_reader :history
  attr_accessor :entry_station

  def initialize
    @history = []
    @entry_station
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def exit_st(station)
    @history.push({@entry_station => station.name})
    @entry_station = nil
  end
end
