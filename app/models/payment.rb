class Payment < ApplicationRecord
  belongs_to :patient
  belongs_to :appointment
  belongs_to :hospital_registration

  validates :total_amount, :paid_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_mode, presence: true
  validates :payment_status, inclusion: { in: %w(Payment Due Completed) }, allow_nil: true
end
