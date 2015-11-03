class ElementController < ApplicationController
  respond_to :json

  def create
    respond_with Element.create!(element_params)
  end

  def update
    respond_with Element.where(id: params[:id]).first.update_attributes(element_params)
  end

  def delete
    respond_with Element.destroy(params[:id])
  end

  private
  def element_params
    params.permit(:title, :parent_node_id)
  end
end
