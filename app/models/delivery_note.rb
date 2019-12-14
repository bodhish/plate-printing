class DeliveryNote < ApplicationRecord
  has_many :print_jobs
  validates_uniqueness_of :number
end
