class CreateSearchQueries < ActiveRecord::Migration[8.0]
  def change
    create_table :search_queries do |t|
      t.string :query, null: false
      t.string :ip_address, null: false
      t.timestamps

    end
    add_index :search_queries, :ip_address
    add_index :search_queries, :created_at
  end
end
