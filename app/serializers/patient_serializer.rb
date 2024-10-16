class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender, :occupation, :address, :phone_number,:role, :hospital_registration_id
end
