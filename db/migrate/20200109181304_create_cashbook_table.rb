class CreateCashbookTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cashbook_categories do |t|
      t.string :name
    end

    create_table :cashbook_entries do |t|
      t.datetime :recorded_at
      t.string :particular
      t.float :amount
      t.references :cashbook_category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
