class Patient < ApplicationRecord
  belongs_to :hospital_registration
  has_many :appointments
  has_many :payments

  validates :name, presence: true
  validates :gender, inclusion: { in: %w(male female other) }, allow_nil: true
  validates :occupation, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :role, inclusion: { in: %w(patient) }, allow_nil: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
