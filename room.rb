require_relative 'patient'

class Room
  attr_accessor :id
  attr_reader :capacity, :patients
  def initialize(attributes = {})
    @id = attributes[:id]
    @capacity = attributes[:capacity] || 0
    @patients = attributes[:patients] || []
  end

  def full?
    @patients.size == @capacity
  end

  def add_patient(patient)
    fail Exception, "Room is full!" if full?
    patient.room = self
    @patients << patient
  end
end