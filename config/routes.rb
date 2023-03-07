Rails.application.routes.draw do

  get '/plots', to: 'plots#index'

  delete '/plots/:plot_id/plants/:plant_id', to: 'plot_plants#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
