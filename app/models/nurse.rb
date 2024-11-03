class Nurse < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :hospital_registration
  
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: %w(active inactive) }
  
  validates :email, uniqueness: true
end
