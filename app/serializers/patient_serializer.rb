class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :dob, :gender, :bloodgroup, :address, :phone_number, :hospital_registration_id
end
