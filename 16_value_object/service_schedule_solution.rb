# Reference solution — do not share until after the learner completes the kata.

class ServiceTime
  include Comparable

  DAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze
  ZONES = {
    "America/Chicago" => "CT",
    "America/New_York" => "ET",
    "America/Denver" => "MT",
    "America/Los_Angeles" => "PT"
  }.freeze

  attr_reader :day, :time, :zone

  def initialize(day, time, zone)
    @day = day
    @time = time
    @zone = zone
  end

  def ==(other)
    day == other.day && time == other.time && zone == other.zone
  end

  def <=>(other)
    [DAYS.index(day) || 7, time] <=> [DAYS.index(other.day) || 7, other.time]
  end

  def to_s
    hour, min = time.split(":").map(&:to_i)
    suffix = hour < 12 ? "AM" : "PM"
    hour12 = hour % 12 == 0 ? 12 : hour % 12
    "#{day} #{hour12}:#{min.to_s.rjust(2, "0")} #{suffix} #{ZONES.fetch(zone, zone)}"
  end
end

class ServiceSchedule
  def initialize(services)
    @services = services.map { |s| [s[:name], ServiceTime.new(s[:day], s[:time], s[:zone])] }
  end

  def display
    @services.map { |name, time| "#{name}: #{time}" }
  end

  def same_slot?(a, b)
    build(a) == build(b)
  end

  def sorted_names
    @services.sort_by { |_, time| time }.map { |name, _| name }
  end

  private

  def build(hash)
    ServiceTime.new(hash[:day], hash[:time], hash[:zone])
  end
end
