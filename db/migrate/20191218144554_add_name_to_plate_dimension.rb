class AddNameToPlateDimension < ActiveRecord::Migration[6.0]
  def change
    add_column :plate_dimensions, :name, :string
  end
end
