require 'csv'
require_relative 'patient'
require_relative 'room_repository'

class PatientRepository
  def initialize(csv_file, room_repository)
    @csv_file = csv_file
    @room_repository = room_repository
    @patients = []
    @next_id = 1
    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      room = @room_repository.find(row[:room_id].to_i)
      patient = Patient.new(row)
      patient.room = room
      @patients << patient
    end
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end
end

room_repo = RoomRepository.new('rooms.csv')
repo = PatientRepository.new('patients.csv', room_repo)
ringo = Patient.new(name: "Ringo")
repo.add(ringo)
p repo