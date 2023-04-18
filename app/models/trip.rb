class Trip < ApplicationRecord
  belongs_to :bus, optional: true
  belongs_to :route, optional: true
  has_many :tickets, dependent: :nullify
  has_many :seats, dependent: :nullify
  validates :ticket_price, :total_booked, :date, :time, presence: true
  validate :check_if_present
  def check_if_present
    return unless new_record? && (Trip.where(date:, time:, bus:).size >= 1)

    errors.add(:time, 'Trip is already exist with tihs bus on this date and time')
  end
end
