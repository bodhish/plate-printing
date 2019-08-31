class SetJobStateDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :print_jobs, :state, 0
  end
end
