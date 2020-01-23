class CashbookEntry < ApplicationRecord
  belongs_to :category, class_name: 'CashbookCategory'
  belongs_to :recorded_by, class_name: 'User'
  has_and_belongs_to_many :color_tags
end
