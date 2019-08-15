class PrintJob < ApplicationRecord
  belongs_to :customer
  has_many :plate_jobs
  has_many :plate_dimensions, through: :plate_jobs

  accepts_nested_attributes_for :plate_jobs
end
