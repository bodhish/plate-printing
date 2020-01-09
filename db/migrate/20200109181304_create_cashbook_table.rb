class CreateCashbookTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cashbook_categories do |t|
      t.string :name
    end

    create_table :cashbook_entries do |t|
      t.datetime :recorded_at
      t.string :particular
      t.float :amount

      t.timestamps
    end
    add_reference :cashbook_entries, :recorded_by, index: true, foreign_key: { to_table: :users }
    add_reference :cashbook_entries, :category, index: true, foreign_key: { to_table: :cashbook_categories }
  end
end
