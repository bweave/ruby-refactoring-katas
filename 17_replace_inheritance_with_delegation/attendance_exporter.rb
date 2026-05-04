class ReportFormatter
  def format_count(n, singular, plural = nil)
    plural ||= "#{singular}s"
    "#{n} #{n == 1 ? singular : plural}"
  end

  def format_percentage(numerator, denominator)
    return "0%" if denominator.zero?
    "#{(numerator * 100.0 / denominator).round}%"
  end

  def divider(width = 40)
    "-" * width
  end

  def header(title)
    [divider, title.upcase, divider].join("\n")
  end
end

class AttendanceExporter < ReportFormatter
  def initialize(records)
    # records: [{week:, total:, first_timers:}, ...]
    @records = records
  end

  def export
    lines = [header("Weekly Attendance")]
    @records.each do |r|
      pct = format_percentage(r[:first_timers], r[:total])
      lines << "Week of #{r[:week]}: #{format_count(r[:total], "person", "people")} (#{pct} first-timers)"
    end
    total = @records.sum { |r| r[:total] }
    lines << divider
    lines << "Total: #{format_count(total, "person", "people")}"
    lines.join("\n")
  end
end
