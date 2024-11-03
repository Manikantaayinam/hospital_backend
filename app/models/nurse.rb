class Nurse < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :hospital_registration
  
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }  
  validates :email, uniqueness: true
end
