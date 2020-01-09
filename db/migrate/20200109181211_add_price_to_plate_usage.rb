class AddPriceToPlateUsage < ActiveRecord::Migration[6.0]
  def change
    add_column :plate_usages, :price, :float
  end
end
