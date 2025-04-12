class CreateSearchSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :search_summaries do |t|
      t.string :ip_address, null: false
      t.string :query, null: false
      t.integer :search_count, default: 1
      t.datetime :last_searched_at

      t.timestamps
    end
    add_index :search_summaries, [:ip_address, :query], unique: true
  end
end
