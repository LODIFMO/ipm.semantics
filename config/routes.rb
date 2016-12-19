Rails.application.routes.draw do
  # mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  # devise_for :users
  # scope 'admin' do
  #   resources :publications, except: :show
  #   resources :people, except: :show
  #   resources :projects, except: :show
  #   resources :pages, except: :show
  #   resources :users, except: :show
  #   resources :courses, except: :show
  #   resources :research_areas, only: %i(index new destroy create)
  # end
  #
  # scope 'api' do
  #   scope 'v1' do
  #     get 'courses/keyword' => 'api/courses#keyword', format: :json
  #   end
  # end
  #
  # root 'pages#show'
  #
  # # research areas - public
  # get '/research_areas' => 'research_areas#public_index'
  #
  # get '/courses/search/keywords/:keyword' => 'keywords#index', constraints: {keyword: /.+/}
  #
  # # people - public
  # get '/staff' => 'people#public_index'
  # get '/staff/:id' => 'people#show', constraints: {id: /[0-9]+/}
  #
  # # courses - public
  # get '/courses' => 'courses#public_index'
  # get '/courses/:id' => 'courses#show', constraints: {id: /[0-9]+/}
  #
  # # projects - public
  # get '/projects' => 'projects#public_index'
  # get '/projects/:id' => 'projects#show', constraints: {id: /[0-9]+/}
  #
  # get '/admin' => 'pages#index'
  #
  # # debug cube
  # get '/admin/cube/project' => 'projects#cube'
  # get '/admin/cube/person' => 'people#cube'
  # get '/admin/cube/department' => 'application#department'
  # get '/admin/cube/search' => 'application#search'
  #
  # # page
  # get '*path', to: 'pages#show'
end
