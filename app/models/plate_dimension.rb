class PlateDimension < ApplicationRecord
  has_many :plate_jobs
  has_many :print_jobs, through: :plate_jobs
end
