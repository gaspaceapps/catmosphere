Catmosphere::Application.routes.draw do
  root 'dashboard#index'
  get 'zipcode/:zipcode', to: 'dashboard#zipcode'
end
