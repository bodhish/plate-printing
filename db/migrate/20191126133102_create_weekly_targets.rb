class CreateWeeklyTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :weekly_targets do |t|
      t.date :start_on
      t.integer :plate_count

      t.timestamps
    end
  end
end
