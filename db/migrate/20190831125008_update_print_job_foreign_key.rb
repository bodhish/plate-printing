class UpdatePrintJobForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :plate_jobs, :print_jobs
    add_foreign_key :plate_jobs, :print_jobs, on_delete: :cascade
  end
end
