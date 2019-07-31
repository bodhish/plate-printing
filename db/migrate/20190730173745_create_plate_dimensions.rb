class CreatePlateDimensions < ActiveRecord::Migration[6.0]
  def change
    create_table :plate_dimensions do |t|
      t.string :dimension

      t.timestamps
    end
  end
end
