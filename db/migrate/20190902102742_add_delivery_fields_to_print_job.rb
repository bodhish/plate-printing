class AddDeliveryFieldsToPrintJob < ActiveRecord::Migration[6.0]
  def change
    add_column :print_jobs, :delivery_note_no, :integer
    add_column :print_jobs, :delivered_at, :datetime
    add_column :print_jobs, :printed_at, :datetime
    add_reference :print_jobs, :delivered_by,index: true, foreign_key: { to_table: :users }
  end
end
