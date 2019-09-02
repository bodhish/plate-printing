class AddAssigneeIdToPrintJob < ActiveRecord::Migration[6.0]
  def change
    add_reference :print_jobs, :assignee, index: true, foreign_key: { to_table: :users }
  end
end
