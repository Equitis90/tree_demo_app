class NodesController < ApplicationController
  respond_to :json

  def index

  end

  def draw_tree
    nodes = {}
    plain_nodes = {}
    node_connections = {}
    parent_nodes = []
    Node.includes(:elements).each do |node|
      if node.parent_node_id.nil?
        parent_nodes << node.id
      end
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
      nodes[node_id] = plain_nodes[node_id]
      create_chain(node_id, nodes[node_id][:nodes], node_connections, plain_nodes)
    end

    render :json => nodes.to_json
  end

  def create
    respond_with Node.create!(node_params)
  end

  def update
    respond_with Node.where(id: params[:id]).first.update_attributes(node_params)
  end

  def delete
    respond_with Node.destroy(params[:id])
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

  def node_params
    params.permit(:title, :parent_node_id)
  end
end
