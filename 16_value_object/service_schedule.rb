class ServiceSchedule
  DAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze
  ZONES = {
    "America/Chicago" => "CT",
    "America/New_York" => "ET",
    "America/Denver" => "MT",
    "America/Los_Angeles" => "PT",
  }.freeze

  def initialize(services)
    # services: [{name:, day:, time:, zone:}, ...]
    @services = services
  end

  def display
    @services.map { |s| "#{s[:name]}: #{format_time(s[:day], s[:time], s[:zone])}" }
  end

  def same_slot?(a, b)
    a[:day] == b[:day] && a[:time] == b[:time] && a[:zone] == b[:zone]
  end

  def sorted_names
    @services.sort_by { |s| [DAYS.index(s[:day]) || 7, s[:time]] }.map { |s| s[:name] }
  end

  private

  def format_time(day, time, zone)
    hour, min = time.split(":").map(&:to_i)
    suffix = hour < 12 ? "AM" : "PM"
    hour12 = hour % 12 == 0 ? 12 : hour % 12
    tz = ZONES.fetch(zone, zone)
    "#{day} #{hour12}:#{min.to_s.rjust(2, "0")} #{suffix} #{tz}"
  end
end
