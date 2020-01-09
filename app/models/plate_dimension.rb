class PlateDimension < ApplicationRecord
  has_many :plate_usages
  has_many :print_jobs, through: :plate_usages
end
