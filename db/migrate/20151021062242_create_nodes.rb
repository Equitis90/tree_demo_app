class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.integer :parent_node_id

      t.timestamps null: false
    end
  end
end
