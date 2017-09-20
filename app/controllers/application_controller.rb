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
    erb :new
  end


  get '/login' do
    erb :login
  end

  get '/logout' do
    erb :logout
  end


  get '/tweets' do
    # Grab all tweets
    erb :index
  end

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    # Receive post from '/tweets/new'
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    # Grab instance of tweet
    erb :show
  end

  get '/tweets/:id/edit' do
    # Grab instance of tweet
    erb :edit
  end

  patch '/tweets/:id' do
    # Receive patch from '/tweets/:id/edit'
    erb "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    # Receive delete from '/tweets/:id'
    redirect to '/tweets'
  end



end
