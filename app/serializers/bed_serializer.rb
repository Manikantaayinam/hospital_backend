class BedSerializer < ActiveModel::Serializer
  attributes :id, :bed_number, :bed_type, :status, :entryDate, :exitDate

  

end
