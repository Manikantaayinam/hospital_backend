class ReceptionistSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone_number , :role, :email, :hospital_registration_id, :profile, :status, :created_at, :updated_at
end
