class AddSetAndColorToPlateJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :plate_jobs, :set, :integer
    add_column :plate_jobs, :color, :integer
    add_column :plate_jobs, :wastage, :integer, default: 0
    remove_column :plate_jobs, :is_wasted
    remove_column :plate_jobs, :count
  end
end
