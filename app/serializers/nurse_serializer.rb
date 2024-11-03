class NurseSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone_number, :email, :hospital_registration_id, :profile, :role, :status, :created_at,
  :updated_at
end
