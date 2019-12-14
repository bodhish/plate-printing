class AddDeliveryNoteIdToPrintJob < ActiveRecord::Migration[6.0]
  def change
    add_reference :print_jobs, :delivery_note, foreign_key: true
  end
end
