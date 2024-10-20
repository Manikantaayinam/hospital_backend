class Bed < ApplicationRecord
	belongs_to :ward
	has_many :appointments
end
