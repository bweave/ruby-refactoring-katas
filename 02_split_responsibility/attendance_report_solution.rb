# Reference solution — do not share until after the learner completes the kata.

class AttendanceStats
  attr_reader :total, :present_count, :absent_count, :first_timers, :rate

  def initialize(attendances)
    @total = attendances.length
    @present_count = attendances.count { |a| a[:status] == "present" }
    @absent_count = attendances.count { |a| a[:status] == "absent" }
    @first_timers = attendances.count { |a| a[:first_time] }
    @rate = total > 0 ? (present_count.to_f / total * 100).round : 0
  end
end

class AttendanceSummaryFormatter
  def format(group, stats)
    lines = [
      "#{group[:name]} — Attendance Summary",
      "Present: #{stats.present_count} of #{stats.total} (#{stats.rate}%)",
      "Absent: #{stats.absent_count}",
    ]
    lines << "First-time visitors: #{stats.first_timers}" if stats.first_timers > 0
    lines << status_line(stats.rate)
    lines.join("\n")
  end

  private

  def status_line(rate)
    if rate >= 80
      "Status: Strong"
    elsif rate >= 60
      "Status: Needs attention"
    else
      "Status: Follow up required"
    end
  end
end

class AttendanceReport
  def summary(group, attendances)
    stats = AttendanceStats.new(attendances)
    AttendanceSummaryFormatter.new.format(group, stats)
  end
end
