class AttendanceReport
  def summary(group, attendances)
    # Calculate attendance stats
    total = attendances.length
    present_count = attendances.count { |a| a[:status] == "present" }
    absent_count = attendances.count { |a| a[:status] == "absent" }
    first_timers = attendances.count { |a| a[:first_time] }
    rate = total > 0 ? (present_count.to_f / total * 100).round : 0

    # Format the report
    header = "#{group[:name]} — Attendance Summary"
    present_line = "Present: #{present_count} of #{total} (#{rate}%)"
    absent_line = "Absent: #{absent_count}"
    first_timer_line = first_timers > 0 ? "First-time visitors: #{first_timers}" : nil

    if rate >= 80
      status_line = "Status: Strong"
    elsif rate >= 60
      status_line = "Status: Needs attention"
    else
      status_line = "Status: Follow up required"
    end

    [header, present_line, absent_line, first_timer_line, status_line].compact.join("\n")
  end
end
