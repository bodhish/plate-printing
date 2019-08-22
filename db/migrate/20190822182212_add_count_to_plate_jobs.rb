class AddCountToPlateJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :plate_jobs, :count, :integer
  end
end
