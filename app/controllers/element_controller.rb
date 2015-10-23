class ElementController < ApplicationController
  def create
    result = {}
    begin
        Element.create!(title: params[:title], node_id: params[:parent_id].to_i)
        result[:status] = 'ok'
    rescue Exception => e
      result[:status] = 'error'
      result[:error] = e.to_s
    end

    respond_to do |format|
      format.json do
        render :json => result.to_json
      end
    end
  end

  def update
    result = {}
    begin
      if params[:drag]
        element = Element.where(id: params[:id]).first
        if element
          element.node_id = params[:parent_node_id]
          element.save!
          result[:status] = 'ok'
        else
          result[:status] = 'error'
          result[:error] = 'Element does not exists'
        end
      else
        element = Element.where(id: params[:id]).first
        if element
          element.title = params[:title]
          element.save!
          result[:status] = 'ok'
        else
          result[:status] = 'error'
          result[:error] = 'Element does not exists'
        end
      end
    rescue Exception => e
      result[:status] = 'error'
      result[:error] = e.to_s
    end

    respond_to do |format|
      format.json do
        render :json => result.to_json
      end
    end
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

    respond_to do |format|
      format.json do
        render :json => result.to_json
      end
    end
  end
end
