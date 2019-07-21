class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :number
      t.text :comments
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
