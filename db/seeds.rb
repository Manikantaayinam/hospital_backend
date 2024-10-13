# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
 # AdminUser.create!(email: 'adminHospital@gmail.com', password: 'password', password_confirmation: 'password') 

# ward1 = Ward.create(available_beds: 10, room_number: 'Ward 101')
# ward2 = Ward.create(available_beds: 5, room_number: 'Ward 102')
# ward3 = Ward.create(available_beds: 15, room_number: 'Ward 103')


# Bed.create(bed_number: 'B001', bed_type: 'ICU', status: 'available', entryDate: nil, exitDate: nil, ward_id: ward1)
# Bed.create(bed_number: 'B002', bed_type: 'General', status: 'occupied', entryDate: Time.now, exitDate: Time.now + 5.days, ward_id: ward1)
# Bed.create(bed_number: 'B003', bed_type: 'General', status: 'available', entryDate: nil, exitDate: nil, ward_id: ward2)
# Bed.create(bed_number: 'B004', bed_type: 'ICU', status: 'available', entryDate: nil, exitDate: nil, ward_id: ward2)
# Bed.create(bed_number: 'B005', bed_type: 'Ac', status: 'occupied', entryDate: Time.now, exitDate: Time.now + 3.days, ward_id: ward3)
# Bed.create(bed_number: 'B006', bed_type: 'General', status: 'available', entryDate: nil, exitDate: nil, ward_id: ward3)


# db/seeds.rb

# Ensure that the hospital registration exists with ID 1
hospital_registration = HospitalRegistration.find(1)

# Create some Wards
wards = [
  { ward_number: "001", available_beds: 5, ward_name: "General Ward", hospital_registration: hospital_registration },
  { ward_number: "002", available_beds: 10, ward_name: "ICU", hospital_registration: hospital_registration },
  { ward_number: "003", available_beds: 8, ward_name: "Pediatrics", hospital_registration: hospital_registration }
]

wards.each do |ward_attributes|
  ward = Ward.create!(ward_attributes)

  # Create Beds associated with each Ward
  5.times do |i|
    Bed.create!(
      bed_number: "#{ward.ward_number}-#{i + 1}",
      bed_type: "Standard",
      status: "Available",
      entryDate: nil,
      exitDate: nil,
      ward: ward
    )
  end
end


