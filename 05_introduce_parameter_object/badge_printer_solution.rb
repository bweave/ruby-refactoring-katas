# Reference solution — do not share until after the learner completes the kata.

CheckIn =
  Struct.new(:first_name, :last_name, :grade, :check_in_time, :medical_note, keyword_init: true) do
    def full_name
      "#{first_name} #{last_name}"
    end

    def formatted_time
      check_in_time.strftime("%I:%M %p")
    end
  end

class BadgePrinter
  def print_badge(data)
    check_in = CheckIn.new(**data)
    lines = [
      "#{check_in.full_name}",
      "Grade: #{check_in.grade}",
      "Checked in: #{check_in.formatted_time}",
    ]
    lines << "MEDICAL: #{check_in.medical_note}" if check_in.medical_note
    lines.join("\n")
  end
end
