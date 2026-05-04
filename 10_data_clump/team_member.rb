class TeamMember
  attr_reader :name, :email, :street, :city, :state, :zip

  def initialize(attrs)
    @name = attrs[:name]
    @email = attrs[:email]
    @street = attrs[:street]
    @city = attrs[:city]
    @state = attrs[:state]
    @zip = attrs[:zip]
  end

  def mailing_label
    "#{name}\n#{street}\n#{city}, #{state} #{zip}"
  end

  def address_summary
    "#{street}, #{city}, #{state} #{zip}"
  end

  def same_city?(other)
    city == other.city && state == other.state
  end
end
