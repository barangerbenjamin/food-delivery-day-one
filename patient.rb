class Patient
  attr_accessor :room, :id
  attr_reader :name, :cured, :blood_type

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @cured = attributes[:cured] || false
    @blood_type = attributes[:blood_type]
  end

  def cure
    @cured = true
  end
end