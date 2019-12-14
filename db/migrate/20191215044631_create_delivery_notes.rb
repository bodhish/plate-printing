class CreateDeliveryNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_notes do |t|
      t.integer :number

      t.timestamps
    end
  end
end
