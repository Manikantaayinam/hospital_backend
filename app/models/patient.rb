class Patient < ApplicationRecord
	belongs_to :hospital_registration
	has_many :appointments
	has_many :payments
		validates :phone_number, presence: true, uniqueness: true
end
