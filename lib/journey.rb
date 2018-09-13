class Journey

    PENALTY_CHARGE = 6

  attr_reader :entry_station, :journey_history

  def initialize
    @journey_history = []
    @in_use = false
    @didnt_touch_out = false
    @entry_station = nil
  end

  def touch_in(tube_stop)
    @entry_station = tube_stop
    @didnt_touch_out = true if @in_use
    @in_use = true
  end

  def touch_out(tube_stop)
    @journey_history << {entry_station: @entry_station, exit_station: tube_stop}
    @entry_station = nil
    @didnt_touch_out = false
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  def no_touch_in?
    !@in_use
  end

  def no_touch_out?
    @didnt_touch_out
  end

end
