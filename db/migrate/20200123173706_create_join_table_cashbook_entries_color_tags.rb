class CreateJoinTableCashbookEntriesColorTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cashbook_entries, :color_tags do |t|
      t.index [:cashbook_entry_id, :color_tag_id], name: 'index_cashbook_tags'
      t.index [:color_tag_id, :cashbook_entry_id], name: 'cashbook_index_tags'
    end
  end
end
