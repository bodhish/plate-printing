class CashbookEntry < ApplicationRecord
  belongs_to :cashbook_category
  belongs_to :user
end
