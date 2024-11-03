class Patient < ApplicationRecord
  belongs_to :hospital_registration
  has_many :appointments
  has_many :payments

  validates :name, presence: true
  validates :gender, inclusion: { in: %w(Male Female Other) }, allow_nil: true
  validates :occupation, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, allow_nil: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
