class ElementController < ApplicationController
  respond_to :json

  def create
    result = {}
    begin
      Element.create!(element_params)
      result[:status] = 'ok'
    rescue Exception => e
      result[:status] = 'error'
      result[:error] = e.to_s
    end

    render :json => result.to_json
  end

  def update
    result = {}
    begin
      element = Element.where(id: params[:id]).first
      if element
        if params[:drag]
          element.parent_node_id = params[:parent_node_id]
          element.save!
          result[:status] = 'ok'
        else
          element.title = params[:title]
          element.save!
          result[:status] = 'ok'
        end
      else
        result[:status] = 'error'
        result[:error] = 'Element does not exists'
      end
    rescue Exception => e
      result[:status] = 'error'
      result[:error] = e.to_s
    end

    render :json => result.to_json
  end

  def delete
    result = {}
    element = Element.where(id: params[:id]).first
    if element
      element.destroy
      result[:status] = 'ok'
    else
      result[:status] = 'error'
      result[:error] = 'Element does not exists'
    end

    render :json => result.to_json
  end

  private
  def element_params
    params.permit(:title, :parent_node_id)
  end
end
