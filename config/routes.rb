Rails.application.routes.draw do
  
  resources :episodes, only: %i[new create index]

  root to: 'episodes#index'

end
