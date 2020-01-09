class PlatePricing < ApplicationRecord
  belongs_to :customer
  belongs_to :plate_dimension
  validates_presence_of :price
  validates_uniqueness_of :plate_dimension, scope: :customer
end
