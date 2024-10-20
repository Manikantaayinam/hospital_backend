class Appointment < ApplicationRecord
	belongs_to :patient
  	belongs_to :doctor, optional: true
  	belongs_to :hospital_registration, optional: true
  	belongs_to :bed, optional: true 
end
