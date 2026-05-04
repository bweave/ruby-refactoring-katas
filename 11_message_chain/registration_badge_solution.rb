# Reference solution — do not share until after the learner completes the kata.

Campus = Struct.new(:name, keyword_init: true)

Event =
  Struct.new(:title, :campus, keyword_init: true) do
    def campus_name
      campus.name
    end
  end

Person =
  Struct.new(:first_name, :last_name, keyword_init: true) do
    def full_name
      "#{first_name} #{last_name}"
    end
  end

class EventRegistration
  attr_reader :role

  def initialize(person:, event:, role:)
    @person = person
    @event = event
    @role = role
  end

  def person_name
    @person.full_name
  end

  def campus_name
    @event.campus_name
  end
end

class RegistrationBadge
  def initialize(registration)
    @registration = registration
  end

  def label
    "#{@registration.person_name} — #{@registration.role} — #{@registration.campus_name}"
  end
end
