# Reference solution — do not share until after the learner completes the kata.

class Address
  attr_reader :street, :city, :state, :zip

  def initialize(street:, city:, state:, zip:)
    @street = street
    @city = city
    @state = state
    @zip = zip
  end

  def mailing_lines
    "#{street}\n#{city}, #{state} #{zip}"
  end

  def one_line
    "#{street}, #{city}, #{state} #{zip}"
  end

  def same_city?(other)
    city == other.city && state == other.state
  end
end

class TeamMember
  attr_reader :name, :email, :address

  def initialize(attrs)
    @name = attrs[:name]
    @email = attrs[:email]
    @address =
      Address.new(
        street: attrs[:street],
        city: attrs[:city],
        state: attrs[:state],
        zip: attrs[:zip],
      )
  end

  def mailing_label
    "#{name}\n#{address.mailing_lines}"
  end

  def address_summary
    address.one_line
  end

  def same_city?(other)
    address.same_city?(other.address)
  end
end
