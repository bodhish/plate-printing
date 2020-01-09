class CreatePlatePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :plate_pricings do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :plate_dimension, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
