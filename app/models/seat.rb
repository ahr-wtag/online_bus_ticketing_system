class Seat < ApplicationRecord
  belongs_to :bus , optional: true
  has_one :ticket
  
  validates :number, presence: true

  after_initialize :init

  def init
    self.booked ||=false
  end
end
