require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :in_use, :journey
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(name,zone)
    station = Station.new(name,zone)
    fail "Insufficient funds!" if @balance < MINIMUM_BALANCE
    @journey.entry_station = station.name
  end

  def touch_out(name,zone)
    station = Station.new(name,zone)
    @journey.exit_st(station)
    deduct(MINIMUM_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def penalty
    @balance -= PENALTY
    fail "Did not touch out, fare penalty of £#{PENALTY}"
  end


end
