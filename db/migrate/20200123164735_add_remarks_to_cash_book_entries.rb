class AddRemarksToCashBookEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :cashbook_entries, :remarks, :text
  end
end
