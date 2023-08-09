Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  resources :accounts
  get '/deposit_money', to: 'accounts#deposit'
  get '/withdraw_money', to: 'accounts#withdraw'
  get '/transfer_money', to: 'accounts#transfer'
  get '/check_balance', to: 'accounts#check_balance'
  get '/account_details', to: 'accounts#account_details'
  get '/transaction_history', to: 'accounts#transaction_history'
end
