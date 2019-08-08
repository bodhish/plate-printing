class PrintJob < ApplicationRecord
  belongs_to :customer
  has_many :plate_jobs
end
