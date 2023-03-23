class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets

  enum :role, %i[user admin]
  validates :first_name, :last_name, :email, :user_name, :password, :phone, :role, presence: true
  validates :email, :user_name, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }
end
