Rails.application.routes.draw do

  root 'shortener#index'

  post '/' => 'shortener#do_shorten', as: :shorten
  post '/c' => 'shortener#do_json_shorten', as: :json_shorten

  get '/l' => 'shortener#lookup', as: :lookup

end
