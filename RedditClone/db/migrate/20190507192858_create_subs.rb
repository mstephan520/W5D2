class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description, null: false 
      t.integer :user_id, null: false
      
      t.timestamps
    end
    add_index :subs, :user_id

    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :sub_id, null: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :sub_id
  end
end
