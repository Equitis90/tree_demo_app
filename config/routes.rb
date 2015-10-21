Rails.application.routes.draw do
  resources :nodes, :element

  get 'draw_tree', to: 'nodes#draw_tree'

  root to: 'nodes#index'
end
