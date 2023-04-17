class Route < ApplicationRecord
  has_many :trips, dependent: :destroy
  validates :origin, :destination, presence: true, format: { with: /\A[A-Za-z]+\z/ }
  attr_accessor :fullRoute

  after_initialize :getFullRoute

  def getFullRoute
    self.fullRoute = origin.to_s + '-' + destination.to_s
  end
end
