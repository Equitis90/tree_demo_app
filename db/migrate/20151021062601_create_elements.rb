class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :title
      t.references :node, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
