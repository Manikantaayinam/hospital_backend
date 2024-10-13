# app/serializers/wards_and_beds_serializer.rb
class WardsAndBedsSerializer < ActiveModel::Serializer
  attributes :id, :ward_number, :available_beds, :ward_name

  # You can also include a method to get the associated beds
  def beds
    object.beds.map do |bed|
      {
        id: bed.id,
        bed_number: bed.bed_number,
        bed_type: bed.bed_type,
        status: bed.status,
        entry_date: bed.entryDate,
        exit_date: bed.exitDate
      }
    end
  end

  # Include the beds in the serialized output
  attribute :beds
end
