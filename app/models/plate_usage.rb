class PlateUsage < ApplicationRecord
  belongs_to :print_job
  belongs_to :plate_dimension

  delegate :dimension, to: :plate_dimension
end