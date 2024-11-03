class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :patient_id, :appointment_id, :total_amount, :payment_status, :due_amount, :paid_amount, :payment_mode, :created_at, :updated_at
  ,:hospital_registration_id
  
  belongs_to :patient, serializer: PatientSerializer
    belongs_to :appointment, serializer: AppointmentSerializer

end
