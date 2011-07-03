ActiveRecord::Schema.define do

  create_table :users, :force => true do |t|
    t.string  :name
    t.timestamps
  end
  
  create_table :meta_data, :force => true do |t|
    t.integer :metabolized_id
    t.string  :metabolized_type
    t.string  :key
    t.text    :data
    t.timestamps
  end
  
  add_index :meta_data, [:metabolized_id, :metabolized_type, :key]
  
end