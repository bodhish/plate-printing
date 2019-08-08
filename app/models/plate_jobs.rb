class PlateJobs < ApplicationRecord
  belongs_to :print_job
  belongs_to :plate_dimension
end