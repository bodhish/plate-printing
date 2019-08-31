class RemoveUniqueIndexInPlateJob < ActiveRecord::Migration[6.0]
  def change
    remove_index :plate_jobs, column: [:plate_dimension_id, :print_job_id]
  end
end
