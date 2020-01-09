Rails.application.routes.draw do
  get 'delivery_notes/index'
  get 'delivery_notes/create'
  ActiveAdmin.routes(self)
  devise_for :users, only: %i[sessions omniauth_callbacks], controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#dashboard'

  resources :print_jobs, only: %i[new create show index edit update] do
    post 'mark_printed', action: 'mark_printed'
    get 'delivery_note_form', action: 'delivery_note_form'
    patch 'mark_delivered', action: 'mark_delivered'
  end

  get '/admin_dashboard', action: 'admin_dashboard', controller: 'admin'

  resources :delivery_notes, only: %i[create index show]
  get 'delivery_note_preview/:id', action: 'preview', controller: 'delivery_notes', as: 'delivery_note_preview'
end
