class CheckInStats
  def initialize(check_ins)
    @check_ins = check_ins
  end

  def total
    @check_ins.size
  end

  def by_location
    @check_ins.group_by { |c| c[:location] }.transform_values(&:size)
  end

  def first_timers
    @check_ins.count { |c| c[:first_time] }
  end

  def returning
    @check_ins.count { |c| !c[:first_time] }
  end
end

class CheckInSummary
  def initialize(check_ins)
    @stats = CheckInStats.new(check_ins)
  end

  def total
    @stats.total
  end

  def by_location
    @stats.by_location
  end

  def first_timers
    @stats.first_timers
  end

  def returning
    @stats.returning
  end
end
