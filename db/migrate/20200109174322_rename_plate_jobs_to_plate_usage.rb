class RenamePlateJobsToPlateUsage < ActiveRecord::Migration[6.0]
  def change
    rename_table :plate_jobs, :plate_usages
  end
end
