# Reference solution — do not share until after the learner completes the kata.

class CheckInSummary
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
