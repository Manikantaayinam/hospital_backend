class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true
  belongs_to :hospital_registration, optional: true
  belongs_to :bed, optional: true 
  has_many :payments, dependent: :destroy

  validates :problem, presence: true
  validates :appointment_timing, presence: true
  validates :consultancy_fees, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :appointment_type, inclusion: { in: %w[OP IP], message: "%{value} is not a valid type" }

  def status
    appointment_status || "Pending"
  end

  # Scopes for commonly used queries
  scope :upcoming, -> { where('appointment_timing > ?', Time.current) }
  scope :past, -> { where('appointment_timing <= ?', Time.current) }
end

