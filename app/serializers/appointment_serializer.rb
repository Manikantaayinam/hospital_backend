class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :problem, :doctor_id, :appointment_timing, :consultancy_fees, :hospital_registration_id,
             :appointment_type, :appointment_status, :bed_id, :ward, :doctor

  belongs_to :patient, serializer: PatientSerializer

  def ward
    if object.bed.present? && object.bed.ward.present?
      {
        id: object.bed.ward.id,
        ward_number: object.bed.ward.ward_number,
        ward_name: object.bed.ward.ward_name,
        available_beds: object.bed.ward.available_beds,
        hospital_registration_id: object.bed.ward.hospital_registration_id,
        bed: {
          id: object.bed.id,
          bed_number: object.bed.bed_number,
          bed_type: object.bed.bed_type,
          status: object.bed.status,
          entryDate: object.bed.entryDate,
          exitDate: object.bed.exitDate
        }
      }
    end
  end

  # Include doctor details
  def doctor
    DoctorSerializer.new(object.doctor) if object.doctor.present?
  end
end
