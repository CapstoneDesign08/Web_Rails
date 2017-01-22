Rails.application.routes.draw do
 # get 'applicants/:id/upload' => 'applicants#upload', as: 'upload_applicant'

  resources :applicants
  resources :challenges
  get '/applicants/logging/:id/', to: 'applicants#logging'
  root :to => 'applicants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
