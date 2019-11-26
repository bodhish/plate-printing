class WeeklyTarget < ApplicationRecord
  validates_presence_of :start_on, :plate_count
  validates_uniqueness_of :start_on
  validate :start_on_should_be_a_saturday

  def start_on_should_be_a_saturday
    errors.add(:start_on, "must be a Saturday") unless start_on&.wday == 6
  end
end
