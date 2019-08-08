class CreatePrintJobs < ActiveRecord::Migration[6.0]
  def up
    create_table :print_jobs do |t|
      t.integer :ref_no
      t.string :name
      t.references :customer, null: false, foreign_key: true
      t.text :comments
      t.integer :state

      t.timestamps
    end

    create_table :plate_jobs do |t|
      t.references :print_job, foreign_key: true
      t.references :plate_dimension, foreign_key: true, index: false
      t.boolean :is_wasted, default: false
    end

    add_index :plate_jobs, %i[plate_dimension_id print_job_id], unique: true
    drop_table :jobs
  end

  def down
    drop_table :print_jobs
  end
end
