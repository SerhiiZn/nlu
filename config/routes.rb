Rails.application.routes.draw do
  get 'index/show'
  post 'index/search'

  root to: 'index#show'
end
