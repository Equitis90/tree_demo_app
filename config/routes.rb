Rails.application.routes.draw do
  #resources :nodes, :element

  get 'draw_tree', to: 'nodes#draw_tree'

  get 'update_node', to: 'nodes#update'
  get 'update_element', to: 'element#update'

  get 'create_node', to: 'nodes#create'
  get 'create_element', to: 'element#create'

  get 'delete_node', to: 'nodes#delete'
  get 'delete_element', to: 'element#delete'

  root to: 'nodes#index'
end
