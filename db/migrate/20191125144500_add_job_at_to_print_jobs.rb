class AddJobAtToPrintJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :print_jobs, :job_on, :date
  end
end
