require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/new'
  end


  get '/login' do
    erb :'users/login'
  end

  get '/logout' do
    erb :'users/logout'
  end


  get '/tweets' do
    # Grab all tweets
    erb :'tweets/index'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    # Receive post from '/tweets/new'
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    # Grab instance of tweet
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    # Receive patch from '/tweets/:id/edit'
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    # Receive delete from '/tweets/:id'
    redirect to '/tweets'
  end



end
