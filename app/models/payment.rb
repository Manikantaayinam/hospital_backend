class Payment < ApplicationRecord
	belongs_to :patient
	belongs_to :appointment
end
