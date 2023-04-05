class Bus < ApplicationRecord
  has_many :tickets
  has_many :seats
  has_one :trip
  validates :name, format: { with: /\A\S*\z/, message: 'no whitespace is allowed' }
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, :typed, :brand, :capacity, presence: true

  validates :capacity, numericality: { greater_than: 0, less_than_or_equal_to: 45 }

  enum typed: { ac: 'ac', non_ac: 'non_ac' }
end
