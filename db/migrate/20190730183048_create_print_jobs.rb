class CreatePrintJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :print_jobs do |t|
      t.integer :ref_no
      t.string :name
      t.references :customer, null: false, foreign_key: true
      t.text :comments
      t.integer :state

      t.timestamps
    end
  end
end
