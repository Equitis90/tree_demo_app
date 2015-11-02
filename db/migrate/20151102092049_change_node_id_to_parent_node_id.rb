class ChangeNodeIdToParentNodeId < ActiveRecord::Migration
  def change
    rename_column :elements, :node_id, :parent_node_id
  end
end
