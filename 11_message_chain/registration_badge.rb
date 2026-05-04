Campus = Struct.new(:name, keyword_init: true)
Event = Struct.new(:title, :campus, keyword_init: true)
Person =
  Struct.new(:first_name, :last_name, keyword_init: true) do
    def full_name
      "#{first_name} #{last_name}"
    end
  end
EventRegistration = Struct.new(:person, :event, :role, keyword_init: true)

class RegistrationBadge
  def initialize(registration)
    @registration = registration
  end

  def label
    name = @registration.person.full_name
    campus = @registration.event.campus.name
    "#{name} — #{@registration.role} — #{campus}"
  end
end
