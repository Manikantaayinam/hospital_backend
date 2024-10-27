# app/serializers/wards_and_beds_serializer.rb
class WardsAndBedsSerializer < ActiveModel::Serializer
  attributes :id, :ward_number, :available_beds, :ward_name

  def available_beds
    object.beds.count
  end

  def beds
    object.beds.map do |bed|
      {
        id: bed.id,
        bed_number: bed.bed_number,
        bed_type: bed.bed_type,
        status: bed.status,
        entry_date: bed.entryDate,
        exit_date: bed.exitDate,
        cost_per_day: bed.cost_per_day
      }
    end
  end

  attribute :beds
end
