class Ward < ApplicationRecord
	has_many :beds,  dependent: :destroy
	belongs_to :hospital_registration
end
