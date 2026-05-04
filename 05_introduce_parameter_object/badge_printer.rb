class BadgePrinter
  def print_badge(data)
    first_name = data[:first_name]
    last_name = data[:last_name]
    grade = data[:grade]
    check_in_time = data[:check_in_time]
    medical_note = data[:medical_note]

    name_line = "#{first_name} #{last_name}"
    grade_line = "Grade: #{grade}"
    time_line = "Checked in: #{check_in_time.strftime("%I:%M %p")}"
    lines = [name_line, grade_line, time_line]
    lines << "MEDICAL: #{medical_note}" if medical_note
    lines.join("\n")
  end
end
