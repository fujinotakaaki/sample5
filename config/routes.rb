Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users
  # get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'#, as: 'aiueokakikukeko' #は無くてもsignup_pathが使える
  post '/signup',  to: 'users#create'
  # ↑postメソッド実行時にユーザー登録に失敗した際のアドレスの不適切な表示を除くために追加
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
