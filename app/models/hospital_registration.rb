class HospitalRegistration < ApplicationRecord
    has_secure_password
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
     #  validates :password, presence: true, length: { minimum: 4}
     # validates :password_confirmation, presence: true
    
   
     # attr_accessor :confirmnew_password
     before_save :store_plaintext_password
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "email", "hos_name", "id", "id_value", "location", "password_digest", "plaintext_password", "updated_at", "role", "phone_number"]
      end
      private

      def store_plaintext_password
        self.plaintext_password = password if password.present?
        self.role ="Management"
      end
end
