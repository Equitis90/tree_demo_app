class NodesController < ApplicationController
  def index

  end

  def draw_tree
    @nodes = {}
    plain_nodes = {}
    node_connections = {}
    parent_nodes = []
    Node.where(parent_node_id: nil).each do |parent_node|
      parent_nodes << parent_node.id
    end
    Node.includes(:elements).each do |node|
      plain_nodes[node.id] = {title: node.title, elements: {}, nodes: {}}
      node_connections[node.id] = []
      Node.where(parent_node_id: node.id).each do |child_node|
        node_connections[node.id] << child_node.id
      end
      node.elements.each do |element|
        plain_nodes[node.id][:elements][element.id] = element.title
      end
    end

    parent_nodes.each do |node_id|
      @nodes[node_id] = plain_nodes[node_id]
      create_chain(node_id, @nodes[node_id][:nodes], node_connections, plain_nodes)
    end

    respond_to do |format|
      format.json do
        render :json => @nodes.to_json
      end
    end
  end

  def create
  end

  def update
  end

  def delete
  end

  private
  def create_chain(node_id, nodes, node_connections, plain_nodes)
    node_connections[node_id].each do |child_node_id|
      nodes[child_node_id] = plain_nodes[child_node_id]
      unless node_connections[child_node_id].empty?
        create_chain(child_node_id, nodes[child_node_id][:nodes], node_connections, plain_nodes)
      end
    end
  end
end
