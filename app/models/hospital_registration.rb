class HospitalRegistration < ApplicationRecord

    has_many :doctors
    has_many :receptionists
    has_many :nurses
    has_many :patients
    has_many :wards
    has_many :appointments
    has_many :payments

    has_secure_password
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
     #  validates :password, presence: true, length: { minimum: 4}
     # validates :password_confirmation, presence: true
    
   
     before_save :store_plaintext_password
      private

      def store_plaintext_password
        self.plaintext_password = password if password.present?
        self.role ="Management"
      end
end
