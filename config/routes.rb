Rails.application.routes.draw do

  root 'shortener#index'

  post '/' => 'shortener#do_shorten', as: :shorten

end
