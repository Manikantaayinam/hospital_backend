class WardSerializer < ActiveModel::Serializer
  attributes :id, :ward_number, :ward_name, :available_beds, :hospital_registration_id, :bed
end
