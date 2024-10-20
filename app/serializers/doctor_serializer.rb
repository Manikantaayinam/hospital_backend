class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone_number, :role, :email, :specialist_in, :profile, :status, :hospital_registration_id
end
