class Route < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :origin, :destination, presence: true, format: { with: /\A[A-Za-z]+\z/ }
  attr_accessor :fullRoute

  before_save :formatName
  after_initialize :getFullRoute

  def getFullRoute
    self.fullRoute = origin.to_s + '-' + destination.to_s
  end

  def formatName
    self.origin = origin.upcase
    self.destination = destination.upcase
  end
end
