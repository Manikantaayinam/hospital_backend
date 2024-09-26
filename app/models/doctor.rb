class Doctor < ApplicationRecord

    belongs_to :hospital_registration

    has_secure_password
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
     before_save :store_plaintext_password

   
     private

      def store_plaintext_password
        self.plaintext_password = password if password.present?
        self.role ="Doctor"
      end
end
