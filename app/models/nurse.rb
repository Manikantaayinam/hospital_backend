class Nurse < ApplicationRecord
	acts_as_paranoid
	belongs_to :hospital_registration
	 validates :status, inclusion: { in: %w(active inactive) }
end
