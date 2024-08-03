class Receptionist < ApplicationRecord
    has_secure_password
        before_save :store_plaintext_password

    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
    before_save :store_plaintext_password


    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "email", "id", "id_value", "name", "password_digest", "phone_number", "plaintext_password", "role", "updated_at"]
    end
   
      private

      def store_plaintext_password
        self.plaintext_password = password if password.present?
        self.role ="Receptionist"
      end
    
end
