class Node < ActiveRecord::Base
  has_many :elements, :dependent => :delete_all

  validates :title, presence: true

  before_destroy :delete_children

  def delete_children
    Node.where(parent_node_id: self.id).destroy_all
  end
end
