class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :problem, :doctor_id, :appointment_timing, :consultancy_fees, :hospital_registration_id,
             :appointment_type, :appointment_status, :bed_id, :bed, :ward, :doctor

  belongs_to :patient, serializer: PatientSerializer

  def doctor  
    @doctor ||= Doctor.find_by(id: object.doctor_id) if object.doctor_id.present?  
  end
  def bed
    @bed ||= Bed.find_by(id: object.bed_id) if object.bed_id.present?
  end

  def ward
    @bed&.ward
  end
end
