class CreateColorTags < ActiveRecord::Migration[6.0]
  def change
    create_table :color_tags do |t|
      t.string :name
    end
  end
end
