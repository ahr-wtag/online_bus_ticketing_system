class User < ApplicationRecord
    has_many :tickets


    enum :role, [ :user, :admin ]
    validates :first_name, :last_name, :email, :user_name, :encrypted_password, :phone, :role, presence: true
    validates :email, :user_name, uniqueness: { case_sensitive: false }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :phone, numericality: true, length: {minimum: 10, maximum: 15}

end
