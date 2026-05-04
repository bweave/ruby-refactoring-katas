class ServiceTeam
  attr_reader :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def add(member)
    @members << member
  end

  def size
    @members.size
  end

  def confirmed
    @members.select { |m| m[:status] == "confirmed" }
  end

  def leaders
    @members.select { |m| m[:role] == "leader" }
  end

  def roster
    @members.select { |m| m[:status] == "confirmed" }.map { |m| m[:name] }.sort
  end
end
